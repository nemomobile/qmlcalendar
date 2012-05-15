
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

RESOURCES += \
    qmlcalendar.qrc


SOURCES += main.cpp \
    calendarmanager.cpp


HEADERS += \
    calendarmanager.h

target.path = /usr/bin
INSTALLS += target

desktop.path = /usr/share/applications
desktop.files = qmlcalendar.desktop
INSTALLS += desktop

icon.files = qmlcalendar.png
icon.path = /usr/share/icons/hicolor/80x80/apps
INSTALLS += icon

