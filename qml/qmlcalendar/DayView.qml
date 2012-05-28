

import Qt 4.7
import com.nokia.meego 1.0
import QtMobility.organizer 1.1
import "month.js" as Month
import com.nokia.extras 1.0

Page
{
    id:dayView
    property variant calendarView: calendarView;
    property variant itemIds:calendarView.organizer.itemIds(calendarView.currentDate, new Date(calendarView.year, calendarView.month, calendarView.day+1))

    tools: commonTools




    ListView {
        anchors.fill: parent
        id: hourList
        model : hourModel
        delegate : hourDelegate
    }

    Component {
        id: hourDelegate


        Item {
            width : hourList.width
            height : childrenRect.height
            property int rowIndex : index
            id:hourDelegateInstanceItem

            Column {
                // Draw a line under the previous Hour list tiem
                id: line
                Rectangle {
                    height : 1
                    width : hourList.width
                    color : "orange"
                }

                Row {
                    spacing: 4
                    Rectangle {
                        border.color: "red"
                        width:80
                        height: dum.height
                        Text {
                            // text: hour
                            id: dum
                            text: index + ":00"
                            width: 80//hourList.width
                            font.pointSize: 18


                            // property OrganizerItem oi: calendarView.organizer.item(repeater.modelData)
                            MouseArea {
                                id: mouseAreaHour

                                anchors.fill: parent

                                onClicked: {
                                    console.log("NUOVO\n");
                                    console.log("hour " + dum.text);
                                    hourList.currentIndex = index;
                                    whatItem.startTime = dum.text;
                                    whatItem.day = Qt.formatDate(calendarView.currentDate, "dd-MM-yy");

                                    whatItem.description = "Add object";
                                    whatItem.location = "Here";
                                    whatItem.isNew = true;
                                    whatItem.item = null;

                                    whatItem.current = Month.atHourObject(calendarView.currentDate, index);

                                    //dayView.opacity = 0;
                                    whatItem.opacity = 1;

                                    console.log("description " + whatItem.description);
                                    commonTools.visible = true;
                                    toolDone.visible = true;

                                    //mainStack.pageStack.pop();
                                    mainStack.pageStack.push(whatItem);


                                }
                            }
                        }
                    }



                    // List all, if any, of the events within this hour.

                    Repeater {

                        //focus: true
                        id: repeater
                        // Simple fetch ALL events on this day...and we will filter them by hour.
                        model: calendarView.organizer.items? calendarView.organizer.itemIds(Month.atHour(new Date(calendarView.year, calendarView.month, calendarView.day), rowIndex)
                                                                                            , (Month.atHour(new Date(calendarView.year, calendarView.month, calendarView.day), rowIndex )))
                                                           : 0

                        Column {
                            spacing: 10


                            Rectangle {
                                color: "orange"
                                width:itemText.width
                                height: itemText.height
                                border.color: "black"
                                border.width: 1

                                Text {
                                    id: itemText
                                    //clip: true
                                    //focus: true
                                    font.pointSize: 18
                                    property OrganizerItem oi: calendarView.organizer.item(modelData)

                                    text: ((hourDelegateInstanceItem.rowIndex == Qt.formatTime(oi.startDateTime, "hh")) ?  oi.description:"")

                                    MouseArea {
                                        id: mouseAreaText

                                        anchors.fill: parent

                                        onClicked: {

                                            var o = calendarView.organizer.item(modelData)
                                            console.log("Esistente start hour " + Month.atHour(new Date(calendarView.year, calendarView.month, calendarView.day), rowIndex));
                                            console.log("TEXT " + parent.text);
                                            console.log( " Esistente item.desc " + o.description);



                                            whatItem.description =  o.description;
                                            whatItem.location = o.location;
                                            whatItem.isNew = false;
                                            whatItem.item = o;
                                            whatItem.opacity = 1;

                                            toolDone.visible = true;

                                            toolDelete.visible = true;
                                            mainStack.pageStack.push(whatItem);



                                        }
                                    }
                                }

                            }
                        }
                    }
                }
            }
        }

    }


    ListModel {
        id : hourModel
        ListElement {hour : "0:00"}
        ListElement {hour : "1:00"}
        ListElement {hour : "2:00"}
        ListElement {hour : "3:00"}
        ListElement {hour : "4:00"}
        ListElement {hour : "5:00"}
        ListElement {hour : "6:00"}
        ListElement {hour : "7:00"}
        ListElement {hour : "8:00"}
        ListElement {hour : "9:00"}
        ListElement {hour : "10:00"}
        ListElement {hour : "11:00"}
        ListElement {hour : "12:00"}
        ListElement {hour : "13:00"}
        ListElement {hour : "14:00"}
        ListElement {hour : "15:00"}
        ListElement {hour : "16:00"}
        ListElement {hour : "17:00"}
        ListElement {hour : "18:00"}
        ListElement {hour : "19:00"}
        ListElement {hour : "20:00"}
        ListElement {hour : "21:00"}
        ListElement {hour : "22:00"}
        ListElement {hour : "23:00"}
    }



}
