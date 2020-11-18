import re
text = '''***The Project Gutenberg's Etext of Shakespeare's First Folio***
*********************The Tragedie of Hamlet*********************


*******************************************************************
THIS EBOOK WAS ONE OF PROJECT GUTENBERG'S EARLY FILES PRODUCED AT A
TIME WHEN PROOFING METHODS AND TOOLS WERE NOT WELL DEVELOPED. THERE
IS AN IMPROVED EDITION OF THIS TITLE WHICH MAY BE VIEWED AS EBOOK
(#100) at https://www.gutenberg.org/ebooks/100
*******************************************************************


This is our 3rd edition of most of these plays.  See the index.

FINIS. The tragedie of HAMLET, Prince of Denmarke.

'''
r = re.compile(r"""(?<=The Tragedie of Hamlet)(.|\n)*(?=FINIS\.)""", re.S)
m = r.search(text)
print(m.group())

