import requests
import re
# versions
PG_HAMLET_URL = 'http://www.gutenberg.org/cache/epub/2265/pg2265.txt'

def read_remote(url):
  # assumes the url is already encoded (see urllib.parse.urlencode)
  response = requests.get(url)
  if response.status_code == requests.codes.ok: # that is 200
    return response.text
  return None

def build_google_drive_url(doc_id):
  DRIVE1  = "https://docs.google.com/uc"
  DRIVE2  = "https://drive.google.com/uc"
  baseurl = DRIVE1 # DRIVE2 works as well 
  params = {"export" : "download",
            "id"     : doc_id}
  
  # build the url using baseurl
  # and the query parameters specified 
  # so that you can fetch it using
  # read_remote
  
  # CHANGE ME:
  url = PG_HAMLET_URL
  
  return url
  
def get_hamlet():
  g_id = get_book_id()
  url = build_google_drive_url(g_id)
  return read_remote(url)

def get_book_id():
  return '1Rh1qyhFLgNHGRCIADcYbdwovigfjNztI'

hamlet = get_hamlet()
print(hamlet[0:100])

ANSWER_TO_LIFE = 42
def answer_to_life():
  text = get_hamlet()
  idx = text.find('To be,')
  ans = text[idx:idx+ANSWER_TO_LIFE]
  return ans

print(answer_to_life())

def clean_hamlet(text):
  r = re.compile(r"""(?<=The Tragedie of Hamlet)(.|\n)*(?=FINIS\.)""", re.S)
  m = r.search(text)
  return m.group()


# print(clean_hamlet(hamlet))
hamlet = clean_hamlet(hamlet)


def find_lucky(text, num):
    p = re.compile(r'\b\w+\'?\w+\b', re.S)
    words = p.findall(text)
    words_set = set(words)
    lucky = []
    for word in words_set:
        if len(word) == num and \
            words.count(word) == num:
            lucky.append(word)

    return lucky

def test_777():
  hamlet = clean_hamlet(get_hamlet())
  print(find_lucky(hamlet, 7))

# test_777()
text = """
A boy, a cat, a rat and a dog were friends. 
But the cat ate the rat. The dog ate the cat. 
The boy? The boy and dog were friends.
"""
print(find_lucky(text, 3))
