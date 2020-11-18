import requests
import re
import urllib
import collections

PG_HAMLET_URL = 'http://www.gutenberg.org/cache/epub/2265/pg2265.txt'


def sort_key(elem):
    return elem[1]


def build_google_drive_url(doc_id):
  DRIVE1  = "https://docs.google.com/uc" 
  DRIVE2  = "https://drive.google.com/uc"  

  baseurl = DRIVE1 # DRIVE2 works as well 
  params = {"export" : "download",
            "id"     : doc_id}
 
  url = baseurl + "?" + urllib.parse.urlencode(params) 
  return url



def read_remote(url):
    # assumes the url is already encoded (see urllib.parse.urlencode)
    response = requests.get(url)
    if response.status_code == requests.codes.ok:  # that is 200
        return response.text
    return None


def read_google_doc(doc_id):
    # url = build_google_drive_url(doc_id)
    # return read_remote(url)
    f = open('cc5/huck.txt')
    return f.read()


def split_text_into_tokens(text):
    pattern_word = re.compile(r'\b[A-Z][a-z]+\'?\w+\b', re.S)
    return pattern_word.findall(text)


def load_stop_words():
    return ['a', 'about', 'above', 'after', 'again', 'against', 'all', 'am', 'an', 'and', 'any', 'are', "aren't", 'as', 'at', 'be', 'because', 'been', 'before', 'being', 'below', 'between', 'both', 'but', 'by', "can't", 'cannot', 'could', "couldn't", 'did', "didn't", 'do', 'does', "doesn't", 'doing', "don't", 'down', 'during', 'each', 'few', 'for', 'from', 'further', 'had', "hadn't", 'has', "hasn't", 'have', "haven't", 'having', 'he', "he'd", "he'll", "he's", 'her', 'here', "here's", 'hers', 'herself', 'him', 'himself', 'his', 'how', "how's", 'i', "i'd", "i'll", "i'm", "i've", 'if', 'in', 'into', 'is', "isn't", 'it', "it's", 'its', 'itself', "let's", 'me', 'more', 'most', "mustn't", 'my', 'myself', 'no', 'nor', 'not', 'of', 'off', 'on', 'once', 'only', 'or', 'other', 'ought', 'our', 'ours', 'ourselves', 'out', 'over', 'own', 'same', "shan't", 'she', "she'd", "she'll", "she's", 'should', "shouldn't", 'so', 'some', 'such', 'than', 'that', "that's", 'the', 'their', 'theirs', 'them', 'themselves', 'then', 'there', "there's", 'these', 'they', "they'd", "they'll", "they're", "they've", 'this', 'those', 'through', 'to', 'too', 'under', 'until', 'up', 'very', 'was', "wasn't", 'we', "we'd", "we'll", "we're", "we've", 'were', "weren't", 'what', "what's", 'when', "when's", 'where', "where's", 'which', 'while', 'who', "who's", 'whom', 'why', "why's", 'with', "won't", 'would', "wouldn't", 'you', "you'd", "you'll", "you're", "you've", 'your', 'yours', 'yourself', 'yourselves']


def bi_grams(tokens):
    return [(tokens[i], tokens[i+1]) for i in range(0, len(tokens) - 1)]


def top_n(tokens, n):
  count = collections.Counter()
  for token in tokens:
    count[token] += 1
  return count.most_common(n)



def sort_key(elem):
    return elem[1]

def get_titles(text):
    titles = set()
    pattern_1 = r"\b[A-Z]{1}[a-z]{1,3}\."
    regex_1 = re.compile(pattern_1)
    title_tokens = regex_1.findall(text)

    pattern_2 = r"\b[A-Z]{1}[a-z]{1,3}\s{1}"
    regex_2 = re.compile(pattern_2)
    pseudo_titles = regex_2.findall(text)

    for token in title_tokens:
        if (token[:-1]+' ') not in pseudo_titles and (token[:-1]+'\n') not in pseudo_titles:
            titles.add(token[:-1])
    return list(titles)


def find_characters_v1(text, stoplist, top):

    def filter_by_word(word):
        return word.lower() not in stoplist

    words = split_text_into_tokens(text)
    words_set = list(set(words))
    words_set = set(filter(filter_by_word, words_set))
    words_counts = []
    for word in words_set:
        words_counts.append((word, words.count(word)))

    words_counts.sort(key=sort_key, reverse=True)

    return words_counts[:top]


def find_characters_v2(text, stoplist, top):

    def filter_by_word(word):
        return word[0].lower() not in stoplist and word[1].lower() not in stoplist

    words = split_text_into_tokens(text)
    bi_tokens = bi_grams(words)
    bi_tokens_cap = []
    for bi_gram in bi_tokens:
        if bi_gram[0] == bi_gram[0].capitalize() and bi_gram[1] == bi_gram[1].capitalize() and bi_gram[0].lower() not in stoplist and bi_gram[1].lower() not in stoplist:
            bi_tokens_cap.append(bi_gram)
    return top_n(bi_tokens_cap,top)
    # words_grams_set = (filter(filter_by_word, set(words_grams)))

    # # f.write(','.join(set(words)))
    # word_counts = [(word, words_grams.count(word)) for word in words_grams_set]
    # word_counts.sort(key=sort_key, reverse=True)
    # return word_counts[:top]


def find_characters_v3(text, stoplist, top):
    return []

#
# return the URL of your shared notebook
#


def jupyter():
    return None

# def find_characters_v1(text, stoplist, top):


HUCK_ID = "13F68-nA4W-0t3eNuIodh8fxTMZV5Nlpp"
text = read_google_doc(HUCK_ID)
stop_words = load_stop_words()
answer1 = find_characters_v1(text, stop_words, 15)
answer2 = find_characters_v2(text, [], 15)

print(answer2)
