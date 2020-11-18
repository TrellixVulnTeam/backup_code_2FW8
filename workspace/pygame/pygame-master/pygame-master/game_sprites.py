import random
import pygame
import time
import math

# 屏幕大小的常量
SCREEN_RECT = pygame.Rect(0, 0, 480, 700)
# 刷新的帧率
FRAME_PER_SEC = 60
# 创建敌机的定时器常量
CREATE_ENEMY_EVENT = pygame.USEREVENT
CREATE_ENEMY_BOSS_EVENT = 31
levels = [
    {'hp': 3, 'time': 10},
    {'hp': 5, 'time': 15},
    {'hp': 10, 'time': 10},
    {'hp': 12, 'time': 15},
    {'hp': 15, 'time': 10},
]

class GameSprite(pygame.sprite.Sprite):
    """游戏精灵"""

    def __init__(self, image_name, speed=1):
        # 调用父类的初始化方法
        super().__init__()

        # 定义对象的属性
        self.image = pygame.image.load(image_name)
        self.rect = self.image.get_rect()
        self.speed = speed

    def update(self):
        # 在屏幕的垂直方向上移动
        self.rect.y += self.speed


class Background(GameSprite):
    """游戏背景精灵"""

    def __init__(self, is_alt=False):

        # 1.调用父类方法实现精灵的创建(image/rect/speed)
        image_name = "./images/background.png"
        super().__init__(image_name)

        # 2.判断是否交替图像，如果是需要设置初始位置
        if is_alt:
            self.rect.y = -self.rect.height

    def update(self):

        # 1.调用父类的方法实现
        super().update()

        # 2.判断是否移出屏幕，如果移出屏幕，将设置到屏幕的上方
        if self.rect.y >= SCREEN_RECT.height:
            self.rect.y = -self.rect.height


class Hero(GameSprite):
    """英雄精灵"""

    __alive = 1

    def __init__(self):

        # 1.调用父类方法，设置image/speed
        super().__init__("./images/me1.png", 0)
        # 2.设置英雄的初始位置
        self.rect.centerx = SCREEN_RECT.centerx
        self.rect.bottom = SCREEN_RECT.bottom - 120
        # 3.创建子弹的精灵组
        self.bullets = pygame.sprite.Group()
        self.sound = pygame.mixer.Sound('./music/bullet.wav')
        self.hp = 3

    def update(self):

        if self.__alive == 1:
            x, y = pygame.mouse.get_pos()

            self.rect.x = x - self.image.get_width() / 2
            self.rect.y = y - self.image.get_height() / 2

        # 控制英雄不能离开屏幕
        if self.rect.x < 0:
            self.rect.x = 0
        elif self.rect.right > SCREEN_RECT.right:
            self.rect.right = SCREEN_RECT.right

    def fire(self):
        # 1.创建子弹精灵
        bullet = Bullet()
        # 2.设置精灵的位置
        bullet.rect.centerx = self.rect.centerx
        bullet.rect.bottom = self.rect.y - 20
        # 3.将精灵添加到精灵组
        self.bullets.add(bullet)
        self.sound.play()
    def sub_hp(self, n):
        self.hp -= n
        if self.hp <= 0:
            self.hp = 0
            self.die()

    def die(self):
        self.__alive = 0
        self.image = pygame.image.load('./images/me_destroy_1.png')


class Bullet(GameSprite):
    """子弹精灵"""

    def __init__(self):
        # 调用父类方法，设置子弹图片，设置初始速度
        super().__init__("./images/bullet1.png", -2)

    def update(self):
        # 调用父类方法，让子弹沿垂直方向飞行
        super().update()
        # 判断子弹是否飞出屏幕
        if self.rect.bottom < 0:
            self.kill()

    def __del__(self):
        pass
        # print("子弹被销毁...")


class Enemy(GameSprite):
    """敌机精灵"""

    def __init__(self):
        # 1.调用父类方法，创建敌机精灵，同时指定敌机图片
        super().__init__("./images/enemy1.png")
        # 2.设置敌机的随机初始速度
        self.speed = random.randint(1, 3)

        # 3.设置敌机的随机初始位置
        self.rect.bottom = 0

        max_x = SCREEN_RECT.width - self.rect.width
        self.rect.x = random.randint(0, max_x)

    def update(self):
        # 1.调用父类方法，让敌机在垂直方向上运动
        super().update()

        # 2.调用是否飞出屏幕，如果是，需要将敌机从精灵组删除
        if self.rect.y >= SCREEN_RECT.height:
            print("敌机飞出屏幕...")
            self.kill()

    # def die(self):
    #     self.speed = 0
    #     self.image = pygame.image.load('./images/enemy1_down1.png')
    #     time.sleep(0.5)
    #     # kill方法将精灵从所有精灵组中移出
    #     self.kill()

    def __del__(self):
        pass
        # print("敌机挂了 %s" % self.rect)

class EnemyBoss(GameSprite):
    def __init__(self, hp = 3):
        # 调用父类方法，设置子弹图片，设置初始速度
        super().__init__("./images/enemy3_n1.png")
        self.speed = 1
        self.rect.bottom = 0
        self.hp = hp
        max_x = SCREEN_RECT.width - self.rect.width
        self.rect.x = random.randint(0, max_x)

    def update(self):
        # 1.调用父类方法，让敌机在垂直方向上运动
        super().update()

        # 2.调用是否飞出屏幕，如果是，需要将敌机从精灵组删除
        if self.rect.y >= SCREEN_RECT.height:
            print("敌机飞出屏幕...")
            self.kill()

    def sub_hp(self, n):
        self.hp -= n
        if self.hp <= 0:
            self.hp = 0


class Hp(GameSprite):
     def __init__(self, image):
        # 1.调用父类方法，创建敌机精灵，同时指定敌机图片
        super().__init__(image)

class HpBar(GameSprite):
    def __init__(self, player, x = 10, y =10, image='./images/heart.png'):
        # 1.调用父类方法，创建敌机精灵，同时指定敌机图片
        super().__init__(image)
        self.image = image
        self.hearts = pygame.sprite.Group()
        self.player = player
        self.x = x
        self.y = y
        if player is not None:
            self.start()

    def start(self):
        for i in range(0, self.player.hp):
           self.add()

    def add(self):
        heart = Hp(self.image )
        heart.rect.y = self.y
        heart.rect.x = self.x + 32 * len(self.hearts)
        self.hearts.add(heart)

    def change_model(self, md):
        self.player = md
        self.hearts.empty()
        if self.player is not None:
            self.start()

    def update(self):
        super().update()
        if self.player is None:
            return

        while len(self.hearts) < self.player.hp:
            self.hearts.add()

        while len(self.hearts) > self.player.hp:
            self.hearts.remove(self.hearts.sprites()[-1])

class Score:
    def __init__(self):
        self._score = 0
        self.font = pygame.font.Font('./font/Courier_New_Bold.ttf', 20)

    def add_score(self, s):
        self._score += s

    def draw(self, screen):
        textSurfaceObj = self.font.render('Score: {0}'.format(self._score), True, (0, 0, 0))
        screen.blit(textSurfaceObj, (300, 680))


class Animation(GameSprite):
    def __init__(self, x, y, speed, images):
        super().__init__(images[0]) 
        self.images = [pygame.image.load(image) for image in images]
        self.speed = speed
        self.rect.x, self.rect.y = x, y
        self.curr_frame = 0

    def update(self):
        self.curr_frame += 1
        index = math.floor(self.curr_frame / self.speed)
        if index == len(self.images):
            self.kill()
            return
        self.image = self.images[index]

class GamePause(GameSprite):
    def __init__(self):
        self._score = 0
        self.font = pygame.font.Font('./font/Courier_New_Bold.ttf', 36)

    def draw(self, screen):
        textSurfaceObj = self.font.render('Pause', True, (0, 0, 0))
        screen.blit(textSurfaceObj, (180, 300))

class GameOver(GameSprite):
    def __init__(self):
        self._score = 0
        self.font = pygame.font.Font('./font/Courier_New_Bold.ttf', 36)

    def draw(self, screen):
        textSurfaceObj = self.font.render('Game Over!', True, (0, 0, 0))
        textSurfaceObj2 = self.font.render('Press R To Restart!', True, (0, 0, 0))
        screen.blit(textSurfaceObj, (140, 300))
        screen.blit(textSurfaceObj2, (60, 330))
