import sys, pygame, random
from pygame import mouse, time, key, transform, font, draw
pygame.init()

size = width, height = 480, 360
black = 0, 0, 0

screen = pygame.display.set_mode(size)
enemys = []
enemy_caches = []
is_game_pause = True

#全局分数
score = 0

class Vector:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def add(self, vector):
        self.x += vector.x
        self.y += vector.y
    
    def mul(self, num):
        self.x *= num
        self.y *= num

class GameObject():
    ALL_OBJECTS = []
    def __init__(self):
        GameObject.add_child(self)

    def pre_update(self, delay):
        pass

    def update(self, delay):
        pass

    def draw(self):
        pass

    def on_add(self):
        pass
    
    def on_remove(self):
        pass

    @staticmethod
    def remove_child(child):
        if child in GameObject.ALL_OBJECTS:
            GameObject.ALL_OBJECTS.remove(child)
            child.on_remove()

    @staticmethod
    def add_child(child):
        GameObject.ALL_OBJECTS.append(child)
        child.on_add()

class Player(GameObject):
    def __init__(self, is_outer = False):
        super(Player, self).__init__()
        self.image = pygame.image.load("img/ball.png")
        self.image = transform.scale(self.image, (32, 32))
        self.rect = self.image.get_rect()
        self.yy = height - self.rect.height
        self.rect.y =self.yy
        self.rect.x = 100
        self.is_jump = False
        self.accle = Vector(0, 0)
        self.velocity = Vector(0, 0)

    def apply_force(self, force):
        self.accle.add(force)

    def update(self, delay):
        if key.get_pressed()[32] == True and not self.is_jump:
            self.is_jump = True
            self.apply_force(Vector(0, -13))

        if self.is_jump:
            self.apply_force(Vector(0, 0.5))
            self.velocity.add(self.accle)
            self.rect.x += self.velocity.x
            self.rect.y += self.velocity.y

            if self.rect.y > self.yy:
                self.rect.y = self.yy
                self.is_jump = False
                self.velocity.mul(0)
            self.accle.mul(0)


        for enemy in enemys:
            if self.rect.colliderect(enemy.rect):
                GameOver()

    def draw(self):
        screen.blit(self.image, self.rect)

class Bg(GameObject):
    def __init__(self, is_outer = False):
        super(Bg, self).__init__()
        self.image = pygame.image.load("img/bg.png")
        self.space_width = self.image.get_rect().width
        self.rect = self.image.get_rect()
        if is_outer:
            self.rect.x = self.space_width
        else:
            self.rect.x = 0
        self.speed = 100

    def update(self, delay):
        self.rect = self.rect.move((-self.speed*delay, 0))

    def draw(self):
        screen.blit(self.image, self.rect)
       
class Bgs(GameObject):
    def __init__(self):
        super(Bgs, self).__init__()
        self.bg1 = Bg()
        self.bg2 = Bg(is_outer=True)
    
    def update(self, delay):
         if self.bg1.rect.x < -self.bg1.space_width:
            self.bg1.rect.x = self.bg2.rect.x + self.bg2.rect.width

         if self.bg2.rect.x < -self.bg2.space_width:
            self.bg2.rect.x = self.bg1.rect.x + self.bg1.rect.width

class Enemy(GameObject):
    def __init__(self, offset_x):
        super(Enemy, self).__init__()
        self.image = pygame.image.load("img/box.png")
        self.rect = self.image.get_rect()
        self.rect.x = width + 20 + offset_x
        self.rect.y = height - self.rect.height

    def on_add(self):
        enemys.append(self)

    def on_remove(self):
        if self in enemys:
            enemys.remove(self)

    def reset(self, offset_x):
        GameObject.add_child(self)
        self.rect.x = width + 20 + offset_x

    def update(self, delay):
        global score
        self.rect = self.rect.move((-100 * delay, 0))
        if self.rect.x < -50:
            enemy_caches.append(self)
            GameObject.remove_child(self)
            score += 10

    def draw(self):
         screen.blit(self.image, self.rect)
        
class EnemyGenerator(GameObject):
    def __init__(self):
        super(EnemyGenerator, self).__init__()
        self.spacing = 3
        self.current = 0

    def update(self, delay):
        self.current += delay
        if self.current >= self.spacing:
            self.current = 0
            offset = random.randint(-1, 2)
            count = random.randint(0, 3)
            for i in range(0, count):
                if len(enemy_caches) > 0:
                    enemy = enemy_caches.pop()
                    enemy.reset(offset * 20)
                else:
                    Enemy(offset * 20)
                offset += 1

class Score(GameObject):
    def __init__(self):
        super(Score, self).__init__()
        self.newFont = font.Font("img/Courier_New_Bold.ttf", 20)
        score_str = 'score: {0}'.format(score)
        self.text = self.newFont.render(score_str,False,(255,200,10))

    def update(self, delay):
        global score
        score_str = 'score: {0}'.format(score)
        self.text = self.newFont.render(score_str,False,(255,200,10))

    def draw(self):
        screen.blit(self.text, (20, 20))


class GameOver(GameObject):
    def __init__(self):
        super(GameOver, self).__init__()
        global is_game_pause
        global score
        self.newFont = font.Font("img/Courier_New_Bold.ttf", 20)
        self.text = self.newFont.render("your score is: {0}".format(score), True, (255, 255, 255))
        self.text2 = self.newFont.render("press space to restart!", True, (255, 255, 255))
        self.rect= self.text.get_rect()
        self.rect2 = self.text2.get_rect()
        self.pos = (
            (width - self.rect.width) / 2,
            (height - self.rect.height) / 2 - 20,
        )
        self.pos2 = (
            (width - self.rect2.width) / 2,
            (height - self.rect2.height) / 2 + 20,
        )
        is_game_pause = True

    def pre_update(self, delay):
        global is_game_pause
        if key.get_pressed()[32] == True:
            print("重新开始")
            runGame()
            GameObject.remove_child(self)
            is_game_pause = False

    def draw(self):
        screen.blit(self.text, self.pos)
        screen.blit(self.text2, self.pos2)

class GameStart(GameObject):
    def __init__(self):
        super(GameStart, self).__init__()
        global is_game_pause
        self.newFont = font.Font("img/Courier_New_Bold.ttf", 20)
        self.text = self.newFont.render("press space start!", True, (255, 255, 255))
        self.rect= self.text.get_rect()
        self.pos = (
            (width - self.rect.width) / 2,
            (height - self.rect.height) / 2,
        )
        is_game_pause = True

    def pre_update(self, delay):
        global is_game_pause
        if key.get_pressed()[32] == True:
            print("游戏开始")
            GameObject.remove_child(self)
            is_game_pause = False

    def draw(self):
        screen.blit(self.text, self.pos)

def runGame():
    global is_game_pause, score, enemys, enemy_caches
    is_game_pause = False
    score = 0
    enemys.clear()
    enemy_caches.clear()
    for g in GameObject.ALL_OBJECTS:
        GameObject.remove_child(g)
    EnemyGenerator()
    Bgs()
    Player()
    Score()
    GameStart()


clock = time.Clock()

runGame()

while 1:
    time.delay(33)
    clock.tick()
    delay = clock.get_time() / 1000
    for event in pygame.event.get():
        if event.type == pygame.QUIT: sys.exit()

    for game_object in GameObject.ALL_OBJECTS:
        game_object.pre_update(delay)

    if not is_game_pause:
        for game_object in GameObject.ALL_OBJECTS:
            game_object.update(delay)

    screen.fill(black)

    for game_object in GameObject.ALL_OBJECTS:
        game_object.draw()
        
        # 碰撞框显示
        # if hasattr(game_object, 'rect'):
        #     rect = game_object.rect
        #     draw.line(screen, (255, 0, 0, 0), (rect.x, rect.y), (rect.x + rect.width, rect.y))
        #     draw.line(screen, (255, 0, 0, 0), (rect.x, rect.y), (rect.x, rect.y + rect.height))
        #     draw.line(screen, (255, 0, 0, 0), (rect.x + rect.width, rect.y), (rect.x+ rect.width, rect.y + rect.height))
        #     draw.line(screen, (255, 0, 0, 0), (rect.x, rect.y  + rect.height), (rect.x+ rect.width, rect.y + rect.height))
            
        
    pygame.display.flip()
