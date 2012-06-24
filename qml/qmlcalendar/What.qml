/****************************************************************************
**
** Copyright (C) 2012 Nicola De Filippo, Ruediger Gad.
** All rights reserved.
** Contact: Nicola De Filippo (nicola.defilippo@lizard-solutions.com)
**          Ruediger Gad (r.c.g@gmx.de)
**
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** This qml components is replication of agenda meego how on N950
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.0
import QtMobility.organizer 1.1
import "logic.js" as Logic
import "month.js" as Month

Sheet {
    id: whatItem

    property string startTime: "00:00";
    property string day ;
    property OrganizerModel organizer: calendarView.organizer;
    property date current; // new Date();
    property OrganizerItem selecteditem: null;
    property string description : "";
    property string location: "";
    property bool isNew: true;
    property Event item: null;


    acceptButtonText: "OK"
    rejectButtonText: "Cancel"

    onAccepted: save()


    function remove() {
        organizer.removeItem(item.itemId);
        //mainStack.pageStack.pop();
    }
    //color: "#ffffff"

    function save () {
        //descriptionTextArea.closeSoftwareInputPanel();
        descriptionTextArea.focus = false;

        if (item === null) {
            console.log("NULL");
            item1.description = descriptionTextArea.text;
            item1.location = locationTextField.text;
            item1.startDateTime = current;
            item = item1;

        }

        console.log("Description text: " + descriptionTextArea.text);

        item.startDateTime = current
        item.description = descriptionTextArea.text;
        item.location = locationTextField.text;
        item.endDateTime = Month.plusMinutes(current, Month.getMinutes(durationSelectionDialog.selectedIndex));

        console.log("Duration index: " + durationSelectionDialog.selectedIndex);
        console.log("Duration minutes: " + Month.getMinutes(durationSelectionDialog.selectedIndex));


        console.log("Start: " + item.startDateTime + " Description: " +  item.description + " End: " + item.endDateTime);

        if ( isNew ){
            console.log("Storing new item.")
            organizer.saveItem(item);
        } else {
            console.log("Storing exisiting item.")
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


    Event {
        id: item1;
        startDateTime: current;
        description: descriptionTextArea.text;
        location: location;
        endDateTime: Month.plus1Hour(current);
    }

    SelectionDialog {
        id: durationSelectionDialog
        titleText: "Duration"
        //selectedIndex: 1

        model: ListModel {
            ListElement { duration: "0 minutes" }
            ListElement { duration: "15 minutes" }
            ListElement { duration: "30 minutes" }
            ListElement { duration: "45 minutes" }
            ListElement { duration: "1 hour" }
            ListElement { duration: "2 hour" }
            ListElement { duration: "day" }
        }
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




//    onStatusChanged: {
//        console.log("STATUS CHANGED " + status + " " + PageStatus.Activating);
//        if (status == 2) {
//            console.log("page widht" + whatItem.width);
//            descriptionTextArea.forceActiveFocus();
//            if (item == null) {
//                durationSelectionDialog.selectedIndex = 0;
//                console.log("index = " + durationSelectionDialog.selectedIndex);
//            }
//            else {
//                console.log("index = " + durationSelectionDialog.selectedIndex);
//                durationSelectionDialog.selectedIndex = Month.calculateIndex(item.startDateTime, item.endDateTime);
//            }
//        }
//    }

//    buttons: Item {
//        anchors.fill: parent
//        SheetButton{
//            id: rejectButton
//            anchors.left: parent.left
//            anchors.leftMargin: 16
//            anchors.verticalCenter: parent.verticalCenter
//            text: "Cancel"
//            onClicked: whatItem.reject()
//        }

//        SheetButton{
//            id: acceptButton
//            anchors.right: parent.right
//            anchors.rightMargin: 16
//            anchors.verticalCenter: parent.verticalCenter
//            platformStyle: SheetButtonAccentStyle { }
//            text: "OK"
//            onClicked: whatItem.accept()
//        }
//    }


    content: Flickable {
        anchors.fill: parent
        contentHeight: contentColumn.height

        Column {
            id: contentColumn
            spacing: 12

            anchors{
                top: parent.top
                left: parent.left
                right: parent.right
                margins: 15
            }

//            Item {
//                anchors{left: parent.left; right: parent.right}
//                height: subjectTextField.height

//                Text {
//                    id: subjectText

//                    anchors{verticalCenter: parent.verticalCenter; left: parent.left}

//                    text: qsTr("Subject")
//                    font.pixelSize: 28
//                }

//                TextField {
//                    id: subjectTextField

//                    anchors{
//                        left: subjectText.right
//                        leftMargin: 10
//                        right: parent.right
//                    }

//                    placeholderText: (item) ? item.subject : "Add Subject"
//                    font.pixelSize: 28
//                }
//            }

            Item {
                anchors{left: parent.left; right: parent.right}
                height: timeValue.height * 1.5

                Text {
                    id: timeText

                    anchors{
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                    }

                    text: qsTr("Start")
                    font.pixelSize: 28
                }

                Text {
                    id: timeDay

                    anchors{
                        left: timeText.right
                        leftMargin: 10
                        verticalCenter: parent.verticalCenter
                    }

                    text: day
                    font.pixelSize: 28
                }

                Rectangle{
                    height: parent.height

                    radius: timeValue.height * 0.5
                    color: timeMouseArea.pressed ? "gray" : "lightgray"

                    anchors{
                        left: timeDay.right
                        leftMargin: 10
                        right: parent.right
                    }

                    Text {
                        id: timeValue

                        anchors.verticalCenter: parent.verticalCenter

                        text: startTime
                        font.pixelSize: 28
                    }

                    MouseArea{
                        id: timeMouseArea
                        anchors.fill: parent

                        onClicked: timePickerDialog.open()
                    }
                }
            }

            Item {
                anchors{
                    left: parent.left
                    right: parent.right
                }

                height: durationValue.height * 1.5

                Text {
                    id: durationText

                    anchors.verticalCenter: parent.verticalCenter

                    text: qsTr("Duration")
                    font.pixelSize: 28
                }

                Rectangle{
                    height: parent.height

                    anchors{
                        left: durationText.right
                        leftMargin: 10
                        right: parent.right
                    }

                    radius: durationValue.height * 0.5
                    color: durationMouseArea.pressed ? "gray" : "lightgray"

                    Text {
                        id: durationValue

                        anchors.verticalCenter: parent.verticalCenter

                        text: durationSelectionDialog.model.get(durationSelectionDialog.selectedIndex).duration
                        font.pixelSize: 28
                    }

                    MouseArea{
                        id: durationMouseArea
                        anchors.fill: parent

                        onClicked: durationSelectionDialog.open()
                    }
                }
            }

            Item {
                anchors{left: parent.left; right: parent.right}
                height: locationTextField.height

                Text {
                    id: locationText

                    anchors{
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                    }

                    text: qsTr("Location")
                    font.pixelSize: 28
                }

                TextField {
                    id: locationTextField

                    anchors{
                        left: locationText.right
                        leftMargin: 10
                        right: parent.right
                    }

                    //text: (item) ? item.location : "Here"
                    placeholderText: (item) ? item.location : "Add Location"
                    font.pixelSize: 28
                }
            }

            Item {
                anchors{left: parent.left; right: parent.right}
                height: descriptionTextArea.height

                Text {
                    id: descriptionText

                    anchors{
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                    }

                    text: qsTr("Description")
                    font.pixelSize: 28
                }

                TextArea {
                    id: descriptionTextArea

                    anchors{
                        left: descriptionText.right
                        leftMargin: 10
                        right: parent.right
                    }

                    //text: (item)?item.description:"Add description"
                    placeholderText: (item) ? item.description : "Add Description"

                    font.pixelSize: 28
                }
            }
        }
    }
}

