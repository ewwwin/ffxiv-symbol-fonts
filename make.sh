#!/bin/bash

urls=(
https://lds-img.finalfantasyxiv.com/pc/global/fonts/FFXIV_Lodestone_SSF-1745376275.woff
https://lds-img.finalfantasyxiv.com/pc/global/fonts/FFXIV_Lodestone_SSF-1745376275.ttf
https://lds-img.finalfantasyxiv.com/pc/global/fonts/FFXIV_Lodestone_SSF-1745376275.svg
)

for url in "${urls[@]}"; do
	file="$(basename -- $url)"
	file="${file//-*./.}"
	echo $file
	curl -fLo "$file" "$url"
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
