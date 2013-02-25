
QT += declarative

CONFIG += mobility

MOBILITY = organizer

OTHER_FILES += \
    qml/qmlcalendar/*.qml \
    qml/qmlcalendar/*.js

#RESOURCES += \
#    qmlcalendar.qrc

SOURCES += main.cpp

jsFiles.path = /opt/$${TARGET}/qml/qmlcalendar
jsFiles.files = qml/qmlcalendar/*.js

qmlFiles.path = /opt/$${TARGET}/qml/qmlcalendar
qmlFiles.files = qml/qmlcalendar/*.qml

imageFiles.path = /opt/$${TARGET}/images
imageFiles.files = images/*.png

calenderrScript.path = /opt/$${TARGET}/bin
calenderrScript.files = auto-icon/calenderr.sh

calenderrAutostart.path = /lib/systemd/system
calenderrAutostart.files = auto-icon/calenderr.service

INSTALLS += jsFiles qmlFiles imageFiles calenderrScript calenderrAutostart

target.path = /opt/$${TARGET}/bin
INSTALLS += target

desktop.path = /usr/share/applications
desktop.files = qmlcalendar.desktop
INSTALLS += desktop

icon.files = qmlcalendar.png
icon.path = /usr/share/icons/hicolor/80x80/apps
INSTALLS += icon

