#!/bin/bash

# fetch css files from the lodestone homepage
possible_css_urls=($(
	curl -s https://na.finalfantasyxiv.com/lodestone | sed -nr 's/<link href="(.*)" rel="stylesheet">/\1/p'
))

# search for URLs that look like fonts in each CSS file
font_urls=()
for css_url in "${possible_css_urls[@]}"; do
	font_urls+=($(
		curl "$css_url" \
		| grep -Eo '/pc/global/fonts/FFXIV_Lodestone_SSF-[[:digit:]]+\.[[:alnum:]]+' \
		| uniq \
		| sed 's|^|https://lds-img.finalfantasyxiv.com|'
	))
done

# fetch each font URL and process it
for url in "${font_urls[@]}"; do
	file="$(basename -- $url)"
	file="${file//-*./.}"
	echo $file

	# ignore eot because fontforge can't process it
	case "$file" in
	*.eot)
		continue
		;;
	esac

	# download file to current directory
	curl -fLo "$file" "$url"

	# remove space glyph so the resulting font contains *only* PUA glyphs
	fontforge -c "
font = open(argv[1])
font.selection[0x20] = True
for i in font.selection.byGlyphs:
    font.removeGlyph(i)
font.generate(argv[1])
" "$file"

	# remove metadata from svg font for cleaner diffs
	echo $file
	case "$file" in
	*.svg)
		sed -i '/<metadata>/,/<\/metadata>/d' "$file"
		;;
	esac
done
