#!/usr/bin/env sh
clear

MANGA_RSS='https://mangadex.org/rss/cknpMfm3XeCgAdyaru2sT4EzqhxPFNVv/manga_id/7139'
SUBSCRIBERS="hoffelmann@gmail.com" # Separate multiple users with coma inside the quotation marks

# Download RSS feed and save it to a variable
RSS_MANGA_DATA=$(curl -s "$MANGA_RSS")

# Parse latest notified chapters from this very file
LATEST_LOCAL_URL=$(tail -1 $0 | cut -c2-)
#echo $latest_notified

# Parse most recent online episode from RSS feed
LATEST_ONLINE_URL=$(echo "$RSS_MANGA_DATA" | sed -n 13p | grep -Po "(?<=>).*?(?=<)")

if [ "$LATEST_ONLINE_URL" != "$LATEST_LOCAL_URL" ]; then

    # Parse RSS feed data of most recent episode
    LATEST_ONLINE_TITLE=$(echo "$RSS_MANGA_DATA" | sed -n 12p | grep -Po "(?<=>).*?(?=<)")
    echo "New chapter online: $LATEST_ONLINE_TITLE"

    # Append new online episode url to this file
    echo "#$LATEST_ONLINE_URL" >> $0

	#echo "$URL$href"   # Print URL of current episode to terminal
	#firefox $URL$href  # open new episode in firefox

    # Send e-mail notification to SUBSCRIBERS
    echo "Read it on: $LATEST_ONLINE_URL" | mail -s "$LATEST_ONLINE_TITLE was just released" $SUBSCRIBERS
else
	echo "No new chapter online"
fi

# Already Notified
#===================================
#https://mangadex.org/chapter/653856
#https://mangadex.org/chapter/660185
#https://mangadex.org/chapter/660875
