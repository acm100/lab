#!/bin/bash

# Define the temporary file location
TEMP_FILE=$(mktemp --tmpdir screenshot_XXXXXX.png)

# 1. Capture the selected region and copy it to the clipboard immediately
grim -g "$(slurp)" - | tee "$TEMP_FILE" | wl-copy

# check if the screenshot was actually taken (user did't press Esc)
if [ ! -s "$TEMP_FILE" ]; then
        rem -f "$TEMP_FILE" 
	exit 0
fi

# 2. Ask the user if they want to save it locally via a system notification
# If they click the action button, it saves to the Pictures directory
ACTION=$(notify-send \
	--app-name="Screenshot" \
	--icon="$TEMP_FILE" \
	--action="save=Save to Picture" \
	"Screenshot copied" \
	"Click below to save a local copy.")

if [ "$ACTION" = "save" ]; then
	TARGET_DIR="$HOME/Pictures"
	mkdir -p "$TARGET_DIR"
	mv "$TEMP_FILE" "$TARGET_DIR/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
	notify-send --app-name="Screenshot" "Saved!" "Stored in $TARGET_DIR"
else
	# Clean up the temporary file if they ignore or close it
	rm -f "$TEMP_FILE"
fi
