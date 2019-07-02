#!/usr/bin/env sh
clear

NOTIFY_TO="hoffelmann@gmail.com" # Separate multiple users with coma inside the quotation marks

MANGA='OnePunchMan' # Name of the manga in the describtion tag of the rss feed
RSS_ALL_URL='https://mangadex.org/rss/follows/cknpMfm3XeCgAdyaru2sT4EzqhxPFNVv'
RSS_MANGA_DATA=$(curl -s "$RSS_ALL_URL" | grep -B 3 "$MANGA")

# Get latest_notified Chapters
LATEST_NOTIFIED=$(tail -1 $0 | cut -c2-)
#echo $latest_notified

LATEST_ONLINE_TITLE=$(echo "$RSS_MANGA_DATA" | sed -n 1p | grep -Po "(?<=>).*?(?=<)")
LATEST_ONLINE_URL=$(echo "$RSS_MANGA_DATA" | sed -n 2p | grep -Po "(?<=>).*?(?=<)")

if [ "$LATEST_ONLINE_URL" != "$LATEST_NOTIFIED" ]; then
	echo "New chapter online: One Punch Man $LATEST_ONLINE_TITLE"

	echo "#$LATEST_ONLINE_URL" >> $0 # Append current episode to file
	#echo "$URL$href"   # Print URL of current episode to terminal
	#firefox $URL$href  # open new episode in firefox
	echo "Read it on: $LATEST_ONLINE_URL" | mail -s "$LATEST_ONLINE_TITLE was just released" $NOTIFY_TO
else
	echo "No new chapter online"
fi

# Already Notified
#https://mangadex.org/chapter/653856
