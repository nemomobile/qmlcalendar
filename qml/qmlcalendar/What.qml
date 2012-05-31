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







        ListView {

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            spacing: 2

            model: VisualItemModel {

                Row {
                    spacing: 2
                    Text {
                        id: object

                        text: qsTr("Description")
                        font.pixelSize: 28

                    }
                    TextArea {

                        id: text_what

                        text: (item)?item.description:"Add object"
                        font.pixelSize: 28
                        onActiveFocusChanged: { object.color = "orange";}

                        /*onFocusChanged:
                        : {
                            if ( text_what.activeFocus ) {

                                object.color = "orange";
                                text_what.openSoftwareInputPanel();
                            }
                            else {
                                object.color= "black";
                                text_what.closeSoftwareInputPanel();
                            }
                        }*/



                    }
                }

                Row {

                    Text {
                        id: text_day

                        text: day;
                        font.pixelSize: 28

                    }

                    Text {
                        id: label_time

                        text: qsTr("Start")
                        font.pixelSize: 28

                    }

                    TextArea {

                        id: text_time
                        text: startTime;
                        font.pixelSize: 28
                        //onFocusChanged: { if ( text_time.activeFocus ) { timePickerDialog.open(); console.log ("timer");} }
                        MouseArea {
                            id: clear
                            anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }
                            height: text_time.height; width: text_time.height
                            onClicked: {
                               timePickerDialog.open()
                            }
                        }
                        readOnly: true

                    }


                }


            Row {

                Text {
                    id: text_w

                    text: qsTr("Location")
                    font.pixelSize: 28

                }
                TextArea {
                    id: text_where

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

            TimePickerDialog {
                id:timePickerDialog
                titleText: "Select Time"
                acceptButtonText: "Confirm"
                rejectButtonText: "Reject"
                fields: DateTime.Hours | DateTime.Minutes
                anchors.fill: parent
                onAccepted: { startTime = timePickerDialog.hour + ":" + timePickerDialog.minute}
            }

}
