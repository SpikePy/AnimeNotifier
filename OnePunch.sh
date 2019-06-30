#!/usr/bin/env sh
clear
URL=https://mangadex.org/title/7139/one-punch-man
SUBSCRIBERS="hoffelmann@gmail.com" # Separate multiple users with coma inside the quotation marks

# Get latest_notified Chapters
latest_notified=$(tail -1 $0 | cut -c2-)
#echo $latest_notified

# Store page in variable
html=$(curl -s $URL)

latest_online=$(echo "$html" | grep -EA 8 "href='/chapter/[0-9]+" | grep -B 8 "title='English'" | head -1 | grep -Po "(?<=href=').*?(?=')")  # Parse first english link to episode on page
latest_online_title=$(echo "$html" | grep -EA 8 "href='/chapter/[0-9]+" | grep -B 8 "title='English'" | head -1 | grep -Po "(?<=>).*?(?=</a)") # Parse first english title of episode on page
#echo $latest_online

if [ "$latest_online" != "$latest_notified" ]; then
	echo "New chapter online: One Punch Man $latest_online_title"
	href=$(echo "$html" | grep -EA 8 "href='/chapter/[0-9]+.*$latest_online" | grep -B 8 "title='English'" | head -1 | grep -Po "(?<=href=').*?(?=')")

	echo "#$latest_online" >> $0 # Append current episode to file
	#echo "$URL$href"   # Print URL of current episode to terminal
	#firefox $URL$href  # open new episode in firefox
	echo "Read it on: $URL$href" | mail -s "One Punch Man $latest_online_title was just released" $SUBSCRIBERS
else
	echo "No new chapter online"
fi

# Already Notified
#/chapter/642878
