// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: whatItem
    anchors.fill: parent

    TextInput {
        id: text_what
        x: 29
        y: 15
        width: 348
        height: 20
        text: qsTr("text")
        font.pixelSize: 18
    }

    Text {
        id: text_day
        x: 29
        y: 62
        text: qsTr("text")
        font.pixelSize: 18
    }

    TextInput {
        id: text_how
        x: 29
        y: 107
        width: 80
        height: 20
        text: qsTr("text")
        font.pixelSize: 18
    }
}
