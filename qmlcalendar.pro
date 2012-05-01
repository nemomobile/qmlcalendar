# Add more folders to ship with the application, here
folder_01.source = qml/qmlcalendar
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0xE4DD515C

# Allow network access on Symbian
symbian:TARGET.CAPABILITY += NetworkServices

# Define QMLJSDEBUGGER to allow debugging of QML in debug builds
# (This might significantly increase build time)
# DEFINES += QMLJSDEBUGGER

# If your application uses the Qt Mobility libraries, uncomment
# the following lines and add the respective components to the 
# MOBILITY variable. 
# CONFIG += mobility
# MOBILITY +=

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    calendarmanager.cpp


unix:!symbian {
    meego5 {
        target.path = /opt/usr/bin
    } else {
        target.path = /usr/local/bin
    }
    INSTALLS += target
}

QT += declarative

CONFIG += mobility

MOBILITY = organizer

OTHER_FILES += \
    qml/qmlcalendar/month.js \
    qml/qmlcalendar/CalendarView.qml \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog \
    qml/qmlcalendar/DayView.qml \
    qml/qmlcalendar/ItemView.qml \
    qml/qmlcalendar/main.qml \
    qml/qmlcalendar/MainPage.qml \
    qml/qmlcalendar/What.qml \
    qml/qmlcalendar/logic.js

RESOURCES += \
    qmlcalendar.qrc

HEADERS += \
    calendarmanager.h

contains(MEEGO_EDITION,harmattan) {
    icon.files = qmlcalendar.png
    icon.path = /usr/share/icons/hicolor/80x80/apps
    INSTALLS += icon
}
