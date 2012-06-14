// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.0
import QtMobility.organizer 1.1
import "logic.js" as Logic
import "month.js" as Month



Page {
    id: whatItem
    tools: whatTools
    property string startTime: "00:00";
    property string day ;
    property OrganizerModel organizer: calendarView.organizer;
    property date current; // new Date();
    property OrganizerItem selecteditem: null;
    property string description : "";
    property string location: "";
    property bool isNew: true;
    property Event item: null;


    SelectionDialog {
         id: singleSelectionDialog
         titleText: "Duration"
         //selectedIndex: 1

         model: ListModel {
             ListElement { duration: "0 minute" }
             ListElement { duration: "15 minutes" }
             ListElement { duration: "30 minutes" }
             ListElement { duration: "45 minutes" }
             ListElement { duration: "1 hour" }
             ListElement { duration: "2 hour" }
             ListElement { duration: "day" }
         }
     }


    onStatusChanged: {
        console.log("STATUS CHANGED " + status + " " + PageStatus.Activating);
        if (status == 2) {
            console.log("page widht" + whatItem.width);
            text_what.forceActiveFocus();
            if (item == null) {
                singleSelectionDialog.selectedIndex = 0;
                console.log("index = " + singleSelectionDialog.selectedIndex);
            }
            else {
                console.log("index = " + singleSelectionDialog.selectedIndex);
                singleSelectionDialog.selectedIndex = Month.calculateIndex(item.startDateTime, item.endDateTime);
            }
        }
    }





    ListView {
        id: list
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.Right
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
                    width: whatItem.width - object.width - 10;
                    //text: (item)?item.description:"Add description"
                    placeholderText: (item)?item.description:"Add description"

                    font.pixelSize: 28
                    clip: true
                    onActiveFocusChanged: {
                        if ( text_what.activeFocus ) {

                            object.color = "orange";
                            //text_what.openSoftwareInputPanel();
                        }
                        else {
                            object.color= "black";
                            //text_what.closeSoftwareInputPanel();
                        }
                    }
                    //focus:true


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

                    text: qsTr(" Start ")
                    font.pixelSize: 28

                }

                TextField {

                    id: text_time
                    text: startTime;
                    font.pixelSize: 28
                    onActiveFocusChanged: { if ( text_time.activeFocus ) { timePickerDialog.open(); console.log ("timer");} }
                    /*MouseArea {
                        id: clear
                        anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }
                        height: text_time.height; width: text_time.height
                        onClicked: {
                            timePickerDialog.open()
                        }
                    }*/
                    //readOnly: true

                }


            }


            Row {
                spacing: 2
                Text {
                    id: labelDuration

                    text: qsTr("Duration")
                    font.pixelSize: 28

                }
                TextField {
                    id: textDuration
                    width: whatItem.width - labelDuration.width - 10;
                    text: singleSelectionDialog.model.get(singleSelectionDialog.selectedIndex).duration
                    font.pixelSize: 28
                    onActiveFocusChanged: {
                        if ( textDuration.activeFocus ) {

                            singleSelectionDialog.open();
                            //text_where.openSoftwareInputPanel();
                        }

                    }
                }
            }

            Row {
                spacing: 2
                Text {
                    id: text_w

                    text: qsTr("Location")
                    font.pixelSize: 28

                }
                TextField {
                    id: text_where
                    width: whatItem.width - text_w.width - 10;
                    text: (item)?item.location:"Here"
                    font.pixelSize: 28
                    onActiveFocusChanged: {
                        if ( text_where.activeFocus ) {

                            text_w.color = "orange";
                            //text_where.openSoftwareInputPanel();
                        }
                        else   {
                            text_w.color= "black";
                            //text_where.closeSoftwareInputPanel();
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
            item1.startDateTime = current;
            item = item1;

        }

        console.log("what = " + text_what.text);

        item.description = text_what.text;
        item.location = text_where.text;
        item.endDateTime = Month.plusMinutes(current, Month.getMinutes(singleSelectionDialog.selectedIndex));

        console.log("SELE " + singleSelectionDialog.selectedIndex);
        console.log("getminutes " + Month.getMinutes(singleSelectionDialog.selectedIndex));


        console.log("current " + item.startDateTime + " desc " +  item.description + " end " + item.endDateTime);

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

    ToolBarLayout {
        id: whatTools
        visible: true

        ToolIcon {
            id: toolBack
            platformIconId: "toolbar-back"
            onClicked: mainStack.pageStack.pop()
        }

        ToolIcon {
            id: toolDone
            platformIconId: "toolbar-done"
            onClicked: {
                save()
                mainStack.pageStack.pop()
            }
        }

        ToolIcon {
            id: toolDelete
            enabled: !isNew
            opacity: enabled ? 1 : 0.5
            platformIconId: "toolbar-delete"
            onClicked: {
                remove()
                mainStack.pageStack.pop()
            }
        }
    }
}

