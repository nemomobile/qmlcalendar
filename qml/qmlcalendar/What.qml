// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.0
import QtMobility.organizer 1.1
import "logic.js" as Logic
import "month.js" as Month

Page {
    id: whatItem
    tools: commonTools
    property string startTime: "00:00";
    property string day ;
    property OrganizerModel organizer: calendarView.organizer;
    property date current; // new Date();
    property OrganizerItem selecteditem: null;
    property string description : "";
    property string location: "";
    property bool isNew: true;
    property Event item: null;






    Rectangle {
        id: line1;

        width: parent.width
        height: text_what.height
        anchors {
            left: parent.left
            top: parent.top

            //top: label.bottom
            topMargin: 10
        }
        Text {
            id: object

            text: qsTr("Description")
            font.pixelSize: 28

        }
        TextArea {

            id: text_what
            width: parent.width - object.width
            anchors.left: object.right
            text: (item)?item.description:"Add object"
            font.pixelSize: 28
            onFocusChanged: {
                if ( text_what.activeFocus ) {

                    object.color = "orange";
                    text_what.openSoftwareInputPanel();
                }
                else {
                    object.color= "black";
                    text_what.closeSoftwareInputPanel();
                }
            }
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

        TextArea {

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

            onAccepted: { startTime = timePickerDialog.hour + ":" + timePickerDialog.minute}
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

            text: qsTr("Location")
            font.pixelSize: 28

        }
        TextArea {
            id: text_where
            anchors {
                leftMargin: 10;
                left: text_w.right;
            }
            width: parent.width - object.width

            text: (item)?item.location:"Here"
            font.pixelSize: 28
            onFocusChanged: {
                if ( text_where.activeFocus ) {

                    text_w.color = "orange";
                    text_where.openSoftwareInputPanel();
                }
                else   {
                    text_w.color= "black";
                    text_where.closeSoftwareInputPanel();
                }
            }
        }
    }


        function remove() {

            organizer.removeItem(item.itemId);
            //mainStack.pageStack.pop();
        }
        //color: "#ffffff"


    Event {
        id: item1;
        startDateTime: current;
        description: text_what.text;
        location: location;
        endDateTime: Month.plus1Hour(current);
    }




        function save () {

            //text_what.closeSoftwareInputPanel();
            text_what.focus = false;

            if (item === null) {
                console.log("NULL");
                item1.description = text_what.text;
                item1.location = text_where.text;
                item = item1;

            }

            console.log("what = " + text_what.text);

            item.description = text_what.text;
            item.location = text_where.text;

            console.log("current " + item.startDateTime + " desc " +  item.description);

            if ( isNew )
                organizer.saveItem(item);
            else {
                item.save();

            }

           organizer.update();

           console.log("In save N ITEM " + organizer.itemCount);
           var items = organizer.items;
           var i;
           for (i = 0; i < organizer.itemCount;i++) {
               console.log("item " + i + " start date" + items[i].itemStartTime);
           }

            //mainStack.pageStack.pop();



    }

}
