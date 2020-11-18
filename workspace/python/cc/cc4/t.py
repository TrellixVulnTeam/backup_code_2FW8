import re

text = """
A boy, a cat, mses a rat and a dog were friends. 
But the cat ate the rat. The dog ate the cat. 
The boy? The boy and mese dog were friends.you're welcome
"""


# def find_lucky(text, num):
#     p = re.compile(r'\b\w+\'?\w+\b', re.S)
#     words = p.findall(text)[0]
#     words_set = set(words)
#     lucky = []
#     for word in words_set:
#         if len(word) == num and \
#                 words.count(word) == num:
#             lucky.append(word)

#     return lucky

def find_lucky(text, num):
    patch = r'(\b\w+\'?\w+\b)(?=(.*\1){%s})' % (num - 1)
    print(patch)
    p = re.compile(patch, re.S)
    words = p.findall(text)
    return words


res = find_lucky(text, 3)
print(res)
