
QT += qml quick

CONFIG += link_pkgconfig

PKGCONFIG = Qt5Organizer

OTHER_FILES += \
    qml/qmlcalendar/*.qml \
    qml/qmlcalendar/*.js

SOURCES += main.cpp

TARGET = qmlcalendar

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

CONFIG += link_pkgconfig

packagesExist(qdeclarative5-boostable) {
    message("Building with qdeclarative5-boostable support")
    DEFINES += HAS_BOOSTER
    PKGCONFIG += qdeclarative5-boostable
} else {
    warning("qdeclarative5-boostable not available; startup times will be slower")
}

