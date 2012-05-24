#!/bin/sh
# Harmattan "Show Today's Date in Calendar App icon" Hack
# by Thomas Perl <thp.io/about>
# Modified for usage with qmlcalendar by Ruediger Gad.

# Usage: nohup sh calenderr.sh >/dev/null &

CALENDAR_ICON=/usr/share/icons/hicolor/80x80/apps/qmlcalendar.png
ICON_PATH=/opt/qmlcalendar/images

while : ; do
    rm -f "$CALENDAR_ICON"
    cp "$ICON_PATH/icon_$(date +%d).png" "$CALENDAR_ICON"
    desktop-file-install --delete-original --dir /usr/share/applications /usr/share/applications/qmlcalendar.desktop
    SECONDS_TILL_MIDNIGHT=$((60*60*24 - `date +%-H`*60*60 - `date +%-M`*60 - `date +%-S`))
    sleep $SECONDS_TILL_MIDNIGHT
done
