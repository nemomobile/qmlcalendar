// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

Rectangle {
    id: whatItem
    anchors.fill: parent

    Rectangle {
        width: parent.width
        anchors {
            left: parent.left
            top: save.bottom

            //top: label.bottom
            topMargin: 10
        }
        Text {
            id: object

            text: qsTr("Object")
            font.pixelSize: 28

        }
        TextInput {

            id: text_what
            width: parent.width - object.width
            anchors.left: object.right
            //text: qsTr("text")
            font.pixelSize: 28
            onFocusChanged: { if ( text_what.activeFocus ) object.color = "orange"; else object.color= "black";}
        }
    }
    Text {
        id: text_day

        text: qsTr("text")
        font.pixelSize: 28
        anchors {
            left: parent.left
            top: text_what.bottom

            //top: label.bottom
            topMargin: 10
        }
    }

    TextInput {
        id: text_how

        text: qsTr("text")
        font.pixelSize: 28
        anchors {
            left: parent.left
            top: text_day.bottom

            //top: label.bottom
            topMargin: 10
        }
    }

    Button {
        id: save

        width: 96
        height: 114
        anchors {
            left: parent.left
            top: parent.top

            //top: label.bottom
            topMargin: 10
        }
        text: qsTr("Save")
        onClicked: {console.log("salva")}
        //color: "#ffffff"
    }

    Button {
        id: rectangle2

        width: 96
        height: 114
        anchors {
            right: parent.right
            top: parent.top
            topMargin: 10
        }
        text: qsTr("Cancel")
        onClicked: {console.log("annulla")}
        //color: "#ffffff"
    }
}
