#
# from Intro to Jupyter Lesson
#
import re
import collections
import requests
import urllib
PG_HAMLET_URL = 'http://www.gutenberg.org/cache/epub/2265/pg2265.txt'


def sort_key(elem):
    return elem[1]


def build_google_drive_url(doc_id):
    DRIVE1 = "https://docs.google.com/uc"
    DRIVE2 = "https://drive.google.com/uc"

    baseurl = DRIVE1  # DRIVE2 works as well
    params = {"export": "download",
              "id": doc_id}

    url = baseurl + "?" + urllib.parse.urlencode(params)
    return url

def read_google_doc(doc_id):
    url = build_google_drive_url(doc_id)

    file1 = open(doc_id + ".txt", "w")
    text = requests.get(url).text
    file1.write(text)
    file1.close()
    return text
#
# from Ngrams Lesson
#


def split_text_into_tokens(text):
    pattern = r"['A-Za-z0-9]+-?['A-Za-z0-9]+"
    regex = re.compile(pattern)
    tokens = regex.findall(text)
    tokens_strip = []
    for word in tokens:
        tokens_strip.append(word.strip("'"))
    return tokens_strip


def load_stop_words():
    return ['a', 'about', 'above', 'after', 'again', 'against', 'all', 'am', 'an', 'and', 'any', 'are', "aren't", 'as', 'at', 'be', 'because', 'been', 'before', 'being', 'below', 'between', 'both', 'but', 'by', "can't", 'cannot', 'could', "couldn't", 'did', "didn't", 'do', 'does', "doesn't", 'doing', "don't", 'down', 'during', 'each', 'few', 'for', 'from', 'further', 'had', "hadn't", 'has', "hasn't", 'have', "haven't", 'having', 'he', "he'd", "he'll", "he's", 'her', 'here', "here's", 'hers', 'herself', 'him', 'himself', 'his', 'how', "how's", 'i', "i'd", "i'll", "i'm", "i've", 'if', 'in', 'into', 'is', "isn't", 'it', "it's", 'its', 'itself', "let's", 'me', 'more', 'most', "mustn't", 'my', 'myself', 'no', 'nor', 'not', 'of', 'off', 'on', 'once', 'only', 'or', 'other', 'ought', 'our', 'ours', 'ourselves', 'out', 'over', 'own', 'same', "shan't", 'she', "she'd", "she'll", "she's", 'should', "shouldn't", 'so', 'some', 'such', 'than', 'that', "that's", 'the', 'their', 'theirs', 'them', 'themselves', 'then', 'there', "there's", 'these', 'they', "they'd", "they'll", "they're", "they've", 'this', 'those', 'through', 'to', 'too', 'under', 'until', 'up', 'very', 'was', "wasn't", 'we', "we'd", "we'll", "we're", "we've", 'were', "weren't", 'what', "what's", 'when', "when's", 'where', "where's", 'which', 'while', 'who', "who's", 'whom', 'why', "why's", 'with', "won't", 'would', "wouldn't", 'you', "you'd", "you'll", "you're", "you've", 'your', 'yours', 'yourself', 'yourselves']


def bi_grams(tokens):
    bi_gram = []
    for i in range(len(tokens)-1):
        bi_gram.append((tokens[i], tokens[i+1]))
    return bi_gram


def top_n(tokens, n):
    count = collections.Counter()
    for token in tokens:
        count[token] += 1
    return count.most_common(n)


def sort_key(elem):
    return elem[1]

#
# new in this code challenge
#


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
    tokens = split_text_into_tokens(text)
    tokens_new = []
    for token in tokens:
        if token not in stoplist and token == (token[0].upper()+token[1:]) and token.upper() not in stoplist and token.lower() not in stoplist:
            tokens_new.append(token)
    return top_n(tokens_new, top)


def find_characters_v2(text, stoplist, top):
    tokens = split_text_into_tokens(text)
    bi_tokens = bi_grams(tokens)
    bi_tokens_cap = []
    for bi_gram in bi_tokens:
        if bi_gram[0] == bi_gram[0].capitalize() and bi_gram[1] == bi_gram[1].capitalize() and bi_gram[0].lower() not in stoplist and bi_gram[1].lower() not in stoplist:
            bi_tokens_cap.append(bi_gram)
    return top_n(bi_tokens_cap, top)


def find_characters_v3(text, stoplist, top):

    tokens = split_text_into_tokens(text)
    bi_tokens = bi_grams(tokens)
    titles = get_titles(text)

    def token_filter(bi_gram):
        return bi_gram[0] in titles and bi_gram[1] == bi_gram[1].capitalize() and bi_gram[1].lower() not in stoplist and bi_gram[1].upper() not in stoplist

    bi_tokens_filter = filter(token_filter, bi_tokens)
    return top_n(bi_tokens_filter, top)


#
# return the URL of your shared notebook
#

def jupyter():
    return None


HUCK_ID = "13F68-nA4W-0t3eNuIodh8fxTMZV5Nlpp"
text = read_google_doc(HUCK_ID)
stop = load_stop_words()
stop_words = load_stop_words()

print(find_characters_v1(text, stop_words, 15))
