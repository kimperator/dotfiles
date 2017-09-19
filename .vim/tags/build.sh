#!/bin/sh
#usag $0 folder file
ctags -R -f $2 --fields=+iaS --language-force=c --extra=+q $1
#ctags -R -f $2 --c++-kinds=+p --fields=+iaS --language-force=c++ --extra=+q $1
#find  /usr/lib/python2.6/ -name "*.py" -print | xargs /usr/lib/python2.6/Tools/scripts/ptags.py   && mv tags python
