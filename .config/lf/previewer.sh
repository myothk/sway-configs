#!/bin/sh
case "$1" in
	*.tar*) tar tf "$1";;
	*.zip) unzip -l "$1";;
	*.rar) unrar l "$1";;
	*.7z) 7z l "$1";;
	*.pdf) pdftotext "$1" -;;
	*.png | *.svg) chafa "$1" -f sixel -s "$2x$3" --animate false
		exit 1;;
	*)[ -z $(highlight -O ansi "$1" || true) ] && cat "$1" || highlight -O ansi "$1"
	 ;;	
esac
