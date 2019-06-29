#!/usr/bin/env sh
clear
url=https://mangadex.org/title/7139/one-punch-man

latest_read=$(tail -1 $0 | cut -c2-)
#echo $latest_read

html_overview=$(curl -s $url)
# Get latest_read Chapters
latest_online=$(echo $html_overview | grep "/chapter/[0-9]*'" | grep -Po '(?<=Ch. )[0-9.]+' | sort -nu | tail -1)
#echo $latest_online

if [ "$latest_online" != "$latest_read" ]; then
	echo "One Punch Man Chapter $latest_online is now available!"
	href=$(echo "$html_overview" | grep -EA 8 "href='/chapter/[0-9]+.*$latest_online" | grep -B 8 "title='English'" | head -1 | grep -Po "(?<=href=').*?(?=')")

	echo "#$latest_online" >> $0 # Append current episode to
	#echo "$url$href"   # Print URL of current episode to terminal
	#firefox $url$href  # open new episode in firefox
	echo "Link to current episode: $url$href" | mail -s "One Punch Man $latest_online was just released" hoffelmann@gmail.com
else
	echo "Nothing new :("
fi

# Known chapters
#109
#110
