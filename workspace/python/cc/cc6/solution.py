import numpy as np
import collections
import urllib
import requests
import re
import spacy
import collections

HP_SS_ID = '1jOCDUhsMY3uAoLqV3NoZogyrr-FVqEoo'

pronouns = ['they', 'your', "who", "she'd", "he'd", 'madam', 'he', "she",
            'i', 'it', "i'm", "i've", "oh", "you", "mr", "mrs", "i'll", "i'd"]


def get_harry_potter():
    # DRIVE1  = "https://docs.google.com/uc"
    # DRIVE2  = "https://drive.google.com/uc"

    # baseurl = DRIVE1 # DRIVE2 works as well
    # params = {"export" : "download",
    #           "id"     : HP_SS_ID}
    # url = baseurl + "?" + urllib.parse.urlencode(params)
    # text = requests.get(url).text
    f = open('cc6/harry.txt', 'r')
    text = f.read()
    return text


def clean_hp(text):
    # pattern = re.compile(, re.S)
    s = re.sub(r'(^\s+)|(\s+$)', '', text)
    p2 = re.compile(r"(?<=Harry Potter and the Sorcerer's Stone).*$", re.S)
    m = p2.search(text)
    return m.group()


def split_text_into_tokens(text):
    pattern = r"[A-Za-z0-9]+-?[A-Za-z0-9]+(?='?)"
    regex = re.compile(pattern)
    tokens = regex.findall(text)
    tokens_strip = []
    for word in tokens:
        tokens_strip.append(word.strip("'"))
    return tokens_strip


def bi_grams(tokens):
    bi_gram = []
    for i in range(len(tokens)-1):
        bi_gram.append((tokens[i], tokens[i+1]))
    return bi_gram


def find_characters_v1(text, stoplist=[], top=15):
    tokens = split_text_into_tokens(text)
    tokens_new = []
    for token in tokens:
        if token not in stoplist and token == (token[0].upper()+token[1:]) and token.upper() not in stoplist and token.lower() not in stoplist:
            tokens_new.append(token)
    return top_n(tokens_new, top)


def find_characters_v2(text, stoplist=[], top=15):
    tokens = split_text_into_tokens(text)
    bi_tokens = bi_grams(tokens)
    bi_tokens_cap = []
    for bi_gram in bi_tokens:
        if bi_gram[0] == bi_gram[0].capitalize() and bi_gram[1] == bi_gram[1].capitalize() and bi_gram[0].lower() not in stoplist and bi_gram[1].lower() not in stoplist:
            bi_tokens_cap.append(bi_gram)
    ts = top_n(bi_tokens_cap, top)

    def jh(elem):
        return (' '.join(elem[0]), elem[1])
    return list(map(jh, ts))


def load_stop_words(add_pronouns=False):
    nlp = ['a', 'about', 'above', 'after', 'again', 'against', 'all', 'am', 'an', 'and', 'any', 'are', "aren't", 'as', 'at', 'be', 'because', 'been', 'before', 'being', 'below', 'between', 'both', 'but', 'by', "can't", 'cannot', 'could', "couldn't", 'did', "didn't", 'do', 'does', "doesn't", 'doing', "don't", 'down', 'during', 'each', 'few', 'for', 'from', 'further', 'had', "hadn't", 'has', "hasn't", 'have', "haven't", 'having', 'he', "he'd", "he'll", "he's", 'her', 'here', "here's", 'hers', 'herself', 'him', 'himself', 'his', 'how', "how's", 'i', "i'd", "i'll", "i'm", "i've", 'if', 'in', 'into', 'is', "isn't", 'it', "it's", 'its', 'itself', "let's", 'me', 'more', 'most', "mustn't", 'my', 'myself', 'no', 'nor', 'not', 'of', 'off', 'on',
           'once', 'only', 'or', 'other', 'ought', 'our', 'ours', 'ourselves', 'out', 'over', 'own', 'same', "shan't", 'she', "she'd", "she'll", "she's", 'should', "shouldn't", 'so', 'some', 'such', 'than', 'that', "that's", 'the', 'their', 'theirs', 'them', 'themselves', 'then', 'there', "there's", 'these', 'they', "they'd", "they'll", "they're", "they've", 'this', 'those', 'through', 'to', 'too', 'under', 'until', 'up', 'very', 'was', "wasn't", 'we', "we'd", "we'll", "we're", "we've", 'were', "weren't", 'what', "what's", 'when', "when's", 'where', "where's", 'which', 'while', 'who', "who's", 'whom', 'why', "why's", 'with', "won't", 'would', "wouldn't", 'you', "you'd", "you'll", "you're", "you've", 'your', 'yours', 'yourself', 'yourselves']
    if add_pronouns:
        nlp.extend(pronouns)
    return nlp


def top_n(tokens, n):
    count = collections.Counter()
    for token in tokens:
        count[token] += 1
    return count.most_common(n)


def find_characters_nlp(text, top=15):
    tokens = split_text_into_tokens(text)
    stoplist = load_stop_words()
    tokens_new = []
    for token in tokens:
        if token not in stoplist and token == (token[0].upper()+token[1:]) and token.upper() not in stoplist and token.lower() not in stoplist:
            tokens_new.append(token)
    return top_n(tokens_new, top)


def split_into_chapters(text):
    chapter_compile = re.compile(r'(?<=CHAPTER).*?(?=CHAPTER|249)', re.S)
    s = chapter_compile.findall(text)[1:]
    return s


def get_character_counts_v1(text):
    tokens = split_text_into_tokens(text)
    unique_tokens = np.unique(tokens)

    resdata = {}
    for ii in unique_tokens:
      resdata[ii] = tokens.count(ii)


def jupyter():
    return None


text = get_harry_potter()
text = clean_hp(text)
stop = load_stop_words()
texts = split_into_chapters(text)

print(get_character_counts_v1(texts[0]))
