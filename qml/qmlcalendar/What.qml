// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.0
import QtMobility.organizer 1.1
import "logic.js" as Logic

Rectangle {
    id: whatItem
    anchors.fill: parent
    property string startTime: "00:00";
    property string day ;
    property OrganizerModel organizer: calendarView.organizer;
    property date current: new Date();

    Rectangle {
        id: line1;

        width: parent.width
        height: text_what.height
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
            text: qsTr("Add objecto")
            font.pixelSize: 28
            onFocusChanged: { if ( text_what.activeFocus ) object.color = "orange"; else object.color= "black";}
            anchors.leftMargin: 10
        }
    }

    Rectangle {
        id: line2
        width: parent.width
        height: text_day.height
        anchors {
            left: parent.left
            top: line1.bottom

            //top: label.bottom
            topMargin: 10
        }
        Text {
            id: text_day
            anchors.left: parent.left;
            text: day;
            font.pixelSize: 28

        }

        Text {
            id: label_time
            anchors {
                left: text_day.right
                leftMargin: 10
            }
            text: qsTr("Start")
            font.pixelSize: 28

        }

        TextInput {

            id: text_time
            width: parent.width - text_day.width - label_time.width;
            anchors {
                left: label_time.right;
                leftMargin: 10;
            }

            text: startTime;
            font.pixelSize: 28
            onFocusChanged: { if ( text_time.activeFocus ) { timePickerDialog.open(); console.log ("timer");} }
            readOnly: true

        }

        TimePickerDialog {
                id:timePickerDialog
                anchors.left: text_day.right
                titleText: "Select Time"
                acceptButtonText: "Confirm"
                rejectButtonText: "Reject"
                fields: DateTime.Hours | DateTime.Minutes
                //opacity: 1
                //onAccepted: timePickerAccepted()
            }
    }
    Rectangle {
        id: line3
        width: parent.width
        height: text_where.height
        anchors {
            left: parent.left
            top: line2.bottom

            //top: label.bottom
            topMargin: 10
        }
        Text {
            id: text_w

            text: qsTr("Where")
            font.pixelSize: 28

        }
        TextInput {
            id: text_where
            anchors {
                leftMargin: 10;
                left: text_w.right;
            }
            text: qsTr("Here")
            font.pixelSize: 28
            onFocusChanged: {
                if ( text_where.activeFocus ) {

                    text_w.color = "orange";
                }
                else
                    text_w.color= "black";}
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
        text: qsTr("Cancel")
        onClicked: {whatItem.opacity = 0; dayView.opacity = 1;}
        //color: "#ffffff"
    }

    Event {
       id: item;
       startDateTime: current;

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
        text: qsTr("Save")
        onClicked: {

           /* Qt.createQmlObject('import QtQuick 1.0; Rectangle {color: "red"; width: 20; height: 20}',
                 parentItem, "dynamicSnippet1");*/
            //var item = Qt.createQmlObject("import QtMobility.organizer 1.1; Event {"+ Logic.dumDesc() +"}", organizer, "item");
            //item.startDateTime = new Date();
            console.log("save");



            item.description = "ciao"
            //item.itemStartTime = new Date();

            //calendarManager.createEvent(new Date(), new Date(), "pipo");

            console.log("current " + item.startDateTime);
            current = new Date();
             organizer.saveItem(item);
            console.log("current " + item.startDateTime);

            organizer.update();
            console.log("N ITAM " + organizer.itemCount);
            //console.log("MANA " + organizer.manager);
            if (organizer.itemCount) {
                var listone = organizer.items;
                console.log(" H " + listone[0].startDateTime + "items " + listone);
            }
        }
        //color: "#ffffff"
    }
}
