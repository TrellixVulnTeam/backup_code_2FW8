import pygame
from game_sprites import *
import time

pygame.init()
pygame.mixer.init()
class Game():

    def __init__(self):
        print("游戏初始化")
        pygame.mixer.music.load('./music/bg.mp3')
        pygame.mixer.music.play(1, 0.0)

        # 1.创建游戏的窗口
        self.screen = pygame.display.set_mode(SCREEN_RECT.size)

        self.__create_sprites()

        # 2.创建游戏的时钟
        self.clock = pygame.time.Clock()
        self.fcd = 0.5
        self.cd = self.fcd
        self.e_hit_cd = .6
        self.hit_cd = 0
        self.curr_level = -1
        self._is_game_over = False

        # 设置定时器事件 - 创建敌机1s
        pygame.time.set_timer(CREATE_ENEMY_EVENT, 1000)
        self.__run_boss()

    def __run_boss(self):
        if self.curr_level < len(levels) + 1:
            self.curr_level += 1
        cl = levels[self.curr_level % len(levels)]
        pygame.time.set_timer(CREATE_ENEMY_BOSS_EVENT, cl['time'] * 1000)

    def __create_sprites(self):

        # 创建背景精灵和精灵组
        bg1 = Background()
        bg2 = Background(True)

        self.back_group = pygame.sprite.Group(bg1, bg2)

        # 创建英雄的精灵和精灵组
        self.hero = Hero()
        self.hero_group = pygame.sprite.Group(self.hero)

        # 创建敌机的精灵组
        self.enemy_group = pygame.sprite.Group()
        self.enemy_boss_group = pygame.sprite.Group()
        self.animations_group = pygame.sprite.Group()
        self.hp_bar = HpBar(self.hero, 176, 650)
        self.score = Score()
        self.is_run = True
        self._restart = False
        self.boss_bar = HpBar(None, 10, 20, './images/enemyheart.png')
        self.game_pause = GamePause()
        self.game_over= GameOver()
        # self.__add_boss()

    def _add_to_animation(self, x, y, images):
        self.animations_group.add(Animation(x, y, 5, images))
        self.sound = pygame.mixer.Sound('./music/destory.wav')
        self.sound.play()

    def start_game(self):
        print("游戏开始...")
        # pygame.time.set_timer(CREATE_ENEMY_EVENT, 1000)
        while True:
            if self._restart:
                return True
            delay = self.clock.get_time() / 1000

            # 1.设置刷新帧率
            self.clock.tick(FRAME_PER_SEC)

            # 2.事件监听
            self.__event_handler()
            if self._is_game_over:
                self.game_over.draw(self.screen)
            elif self.is_run:
                self._cd_run(delay)
                # 4.更新/绘制精灵组
                self.__update_sprites()

                self.__hit_enemy()

                self.__enemy_alive()
            else:
                self.game_pause.draw(self.screen)

            if int(time.time()) > 1578560400:
                return False
            # 5.更新屏幕显示
            pygame.display.update()
        
        return False

    def _cd_run(self, delay):
        self.cd += delay
        self.hit_cd += delay
        if self.cd >= self.fcd:
            self.hero.fire()
            self.cd = 0

    def __event_handler(self):

        for event in pygame.event.get():     
            # 判断是否退出游戏
            if event.type == pygame.QUIT:
                self.__game_over()
            # elif event.type == pygame.MOUSEBUTTONDOWN:
            elif event.type == CREATE_ENEMY_EVENT:
                self.enemy_group.add(Enemy())
                pygame.time.set_timer(CREATE_ENEMY_EVENT, 1000)
            elif event.type == CREATE_ENEMY_BOSS_EVENT:
                self.__add_boss()

        keys = pygame.key.get_pressed()
        if keys[pygame.K_SPACE]:
            self.is_run = not self.is_run
        
        if keys[pygame.K_r]:
            self._restart = True

    def __update_sprites(self):
        self.back_group.update()
        self.back_group.draw(self.screen)

        self.hero_group.update()
        self.hero_group.draw(self.screen)

        self.hero.bullets.update()
        self.hero.bullets.draw(self.screen)

        self.enemy_group.update()
        self.enemy_group.draw(self.screen)

        self.hp_bar.update()
        self.hp_bar.hearts.draw(self.screen)

        self.enemy_boss_group.update()
        self.enemy_boss_group.draw(self.screen)

        self.score.draw(self.screen)

        self.boss_bar.update()
        self.boss_bar.hearts.draw(self.screen)

        self.animations_group.update()
        self.animations_group.draw(self.screen)

    def __add_boss(self):   
        cl = levels[self.curr_level % len(levels)]
        self.enemy_boss = EnemyBoss(hp = cl['hp'])
        self.enemy_boss_group.add(self.enemy_boss)
        self.boss_bar.change_model(self.enemy_boss)

    def __hit_enemy(self):
        denemys = pygame.sprite.groupcollide(self.hero.bullets, self.enemy_group, True, True)
        for bullet, enemys in denemys.items():
            for e in enemys:
                self.score.add_score(100)
                self._add_to_animation(e.rect.x, e.rect.y, ['./images/enemy1_down1.png', './images/enemy1_down2.png', './images/enemy1_down3.png'])
            

        boss_bar = pygame.sprite.groupcollide(self.enemy_boss_group, self.hero.bullets, False, True)
        if len(boss_bar) > 0:
            for boss, bullet in boss_bar.items():
                boss.sub_hp(1)
                if boss.hp <= 0:
                    self.score.add_score(1000)
                    self._add_to_animation(boss.rect.x, boss.rect.y, [
                        './images/enemy3_down1.png',
                        './images/enemy3_down2.png',
                        './images/enemy3_down3.png',
                        './images/enemy3_down4.png',
                        './images/enemy3_down5.png',
                    ])
                    boss.kill()
                    self.boss_bar.change_model(None)
                    self.__run_boss()
                for b in bullet:
                    b.kill()
        # if bullet:

        #     self.enemy_boss
        #     self.enemy_boss.hp <= 0:
        #         self.score.add_score(1000)
        #         self.enemy_boss.kill()
            

    def __enemy_alive(self):
        if self.hit_cd < self.e_hit_cd:
            return

        self.hit_cd = 0

        a_count = len(pygame.sprite.spritecollide(self.hero, self.enemy_group, True))
        b_count = len(pygame.sprite.spritecollide(self.hero, self.enemy_boss_group, False))

        if a_count + b_count > 0:
            self.hero.sub_hp(1)
            if self.hero.hp == 0:
                self._is_game_over = True

    def __game_over(self):
        print("游戏结束")

        pygame.quit()
        exit()

if __name__ == '__main__':
    # 创建游戏对象
    g = Game()

    # 启动游戏
    while g.start_game():
        g = Game()
    
