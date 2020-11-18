import pygame, sys
from pygame import mouse, time, key, transform, font, draw, key
pygame.init()
size = width, height = 480, 720
screen = pygame.display.set_mode(size)
clock = time.Clock()
black = 0, 0, 0

class GameObject():
    def __init__(self):
        self.childs = []

    def update(self, delay):
        for child in self.childs:
            child.update(delay)
        pass

    def draw(self):
        for child in self.childs:
            child.draw()
        pass

class Game():
    def __init__(self):
        self.is_run = True
        self.game_object = None

    def change_game_object(self, game_object):
        self.game_object = game_object

    def run(self):
        while self.is_run:
            time.delay(33)
            clock.tick()
            delay = clock.get_time() / 1000
            screen.fill(black)
            for event in pygame.event.get():
                if event.type == pygame.QUIT: sys.exit()
            if self.game_object:
                self.game_object.update(delay)

            if self.game_object:
                self.game_object.draw()
            pygame.display.flip()
