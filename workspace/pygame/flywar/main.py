from game import Game, GameObject, screen, key
import pygame, math
class Image(GameObject):
    def __init__(self, image):
        super(Image, self).__init__()
        self.image = pygame.image.load(image)
        self.rect = self.image.get_rect()
        self.rect.x = 0
        self.rect.y = 0

    def draw(self):
        screen.blit(self.image, self.rect)

class Animation(GameObject):
    def __init__(self, anim_speed = 1, *images):
        super(Animation, self).__init__()
        self.images = []
        for image in images:
            self.images.append(pygame.image.load(image))
        self.rect = self.images[0].get_rect()
        self.frame_index = 0
        self.anim_speed = anim_speed
        self.frame_count = self.anim_speed * len(self.images)
    
    def draw(self):
        screen.blit(self.images[math.floor(self.frame_index / self.anim_speed)], (self.rect))
        self.frame_index = (self.frame_index + 1)  % self.frame_count

class Player(Animation):
    def __init__(self):
        super(Player, self).__init__(4, 'img/me1.png', 'img/me2.png')
        self.speed = 10
        self.rect.x = 240
        self.rect.y = 600
        self.rect.width = 64
        self.rect.height = 64

    def update(self, dt):
        keys = pygame.key.get_pressed()
        if keys[pygame.K_LEFT]:
            self.rect.x -= self.speed
        elif keys[pygame.K_RIGHT]: 
            self.rect.x += self.speed


def create_game_scene():
    game_scene = GameObject()
    game_scene.childs.append(Image('img/background.png'))
    player = Player()
    game_scene.childs.append(player)
    return game_scene
if __name__ == "__main__":
    game_scene = create_game_scene()
    game = Game()
    game.change_game_object(game_scene)
    game.run()

