#!/usr/bin/env python
# This script is an attempt to build help-files from Docbook sources
# (It is not finished)
# You call it as:
#        ./make_hp_files.py os9guide/os9guide.docbook
#        ./make_hp_files.py ccguide/ccguide.docbook
#
# It requires:
#   Python 2.0 or later
# 
# Author:  Soren Roug
#
from sys import argv
import string 
from xml.sax import make_parser,handler
import sys
#from types import *

class HandleParsing(handler.ContentHandler):
    """Parse a Docbook file"""

    def __init__(self):
        self.__data = ''

    def printdata(self):
        print self.__data
        self.__data = ''

#<funcsynopsis>
#<funcprototype>
#<funcdef>char *<function>mktemp</function></funcdef>
#    <paramdef>char *<parameter>name</parameter></paramdef>
#</funcprototype>

    def startElement(self, tag, attrs):
        if tag == 'refname':
            self.__data = '@'

        elif tag == 'funcprototype':
            self.__data = ''

        elif tag == 'cmdsynopsis':
            self.__data = 'Syntax: '

        elif tag == 'arg':
            self.optional = 0
            if attrs.has_key('choice') and attrs['choice'] == "opt":
                self.optional = 1
                self.__data += '['

        elif tag == 'replaceable':
            self.__data += '<'
        elif tag in ('parameter','paramdef','funcdef','function',
                 'command','option'):
            pass
        else:
            self.__data = ''

    def endElement(self, tag):
        if tag == 'funcdef':
            self.__data += '()\n'

        elif tag == 'paramdef':
            self.__data += ';\n'

        elif tag == 'funcprototype':
            self.printdata()

        elif tag == 'refname':
            self.printdata()

        elif tag == 'refpurpose':
            self.purpose = self.__data

        elif tag == 'refentry':
            print "Usage: %s" % self.purpose

        elif tag == 'arg':
            if self.optional == 1:
                self.__data += ']'
            self.optional = 0

        elif tag == 'cmdsynopsis':
            self.printdata()

        elif tag == 'replaceable':
            self.__data += '>'

    def characters(self, text):
        if not text == '\n':
            self.__data += text

#   def handle_charref(self,ref):
#       self.handle_data('&#' + ref + ';')

#   def unknown_entityref(self,ref):
#       self.handle_data('&' + ref + ';')

#   def syntax_error(self,message):
#       pass

#-----------
parser = make_parser()
chandler = HandleParsing()
parser.setContentHandler(chandler)

for file in argv[1:]:
    f = open(file)
    if not f:
        raise IOError, "Failure in open %s" % file
    parser.parse(f)
    f.close()


