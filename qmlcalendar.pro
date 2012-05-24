
QT += declarative

CONFIG += mobility

MOBILITY = organizer

OTHER_FILES += \
    qml/qmlcalendar/month.js \
    qml/qmlcalendar/CalendarView.qml \
    qml/qmlcalendar/DayView.qml \
    qml/qmlcalendar/ItemView.qml \
    qml/qmlcalendar/main.qml \
    qml/qmlcalendar/MainPage.qml \
    qml/qmlcalendar/What.qml \
    qml/qmlcalendar/logic.js

#RESOURCES += \
#    qmlcalendar.qrc

SOURCES += main.cpp \
    calendarmanager.cpp


HEADERS += \
    calendarmanager.h

jsFiles.path = /opt/$${TARGET}/qml/qmlcalendar
jsFiles.files = qml/qmlcalendar/*.js

qmlFiles.path = /opt/$${TARGET}/qml/qmlcalendar
qmlFiles.files = qml/qmlcalendar/*.qml

imageFiles.path = /opt/$${TARGET}/images
imageFiles.files = images/*.png

calenderrScript = /opt/$${TARGET}/bin
calenderrScript.files = auto-icon/calenderr.sh

calenderrAutostart = /etc/xdg/autostart
calenderrAutostart.files = auto-icon/calenderr.desktop

INSTALLS += jsFiles qmlFiles imageFiles calenderrScript calenderrAutostart

target.path = /opt/$${TARGET}/bin
INSTALLS += target

desktop.path = /usr/share/applications
desktop.files = qmlcalendar.desktop
INSTALLS += desktop

icon.files = qmlcalendar.png
icon.path = /usr/share/icons/hicolor/80x80/apps
INSTALLS += icon

