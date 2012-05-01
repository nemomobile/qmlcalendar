

import Qt 4.7
import com.nokia.meego 1.0
import QtMobility.organizer 1.1
import "month.js" as Month
import com.nokia.extras 1.0

Page
{
    id:dayView
    property variant calendarView;
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
                Rectangle {
                    height : 1
                    width : hourList.width
                    color : "orange"
                }

                Text {
                    // text: hour
                    id: dum
                    text: index + ":00"
                    width: hourList.width
                    font.pointSize: 18
                    // property OrganizerItem oi: calendarView.organizer.item(repeater.modelData)
                    MouseArea {
                        id: mouseAreaHour

                        anchors.fill: parent

                        onClicked: {
                            console.log("hour " + dum.text);
                            hourList.currentIndex = index;
                            whatItem.startTime = dum.text;
                            whatItem.day = Qt.formatDate(calendarView.currentDate, "dd-MM-yy");

                            var items = calendarView.organizer.itemIds(new Date(calendarView.year, calendarView.month, calendarView.day)
                                                                       , new Date(calendarView.year, calendarView.month, calendarView.day+1));
                            var item = null;
                            if (items) {
                                var i;
                                console.log("ITEM length " + items.length);
                                for (i = 0; i < items.length; i++) {
                                    var itemo = calendarView.organizer.item(items[i]);
                                    console.log("time " + (Qt.formatTime( itemo.startDateTime, "h" ) + ":00") + " dum.text " + dum.text);
                                    if ( (Qt.formatTime( itemo.startDateTime, "h" ) + ":00") === dum.text) {
                                        console.log("ITEM START TIME" + itemo.startDateTime + " " + Qt.formatTime( itemo.startDateTime, "hh" ));
                                        item = calendarView.organizer.item(items[i]);
                                        break;
                                    }
                                }

                                if (item) {
                                    console.log("item.desc " + item.description)
                                    whatItem.description =  item.description;
                                    whatItem.location = item.location;
                                    whatItem.isNew = false;
                                    whatItem.item = item;
                                }
                                else {
                                    whatItem.description = "Add object";
                                    whatItem.location = "Here";
                                    whatItem.isNew = true;
                                }
                            }

                            whatItem.current = Month.atHourObject(calendarView.currentDate, index);

                            //dayView.opacity = 0;
                            whatItem.opacity = 1;

                            mainStack.pageStack.push(whatItem);

                        }
                    }
                }



                // List all, if any, of the events within this hour.
                Repeater {

                    focus: true
                    id: repeater
                    // Simple fetch ALL events on this day...and we will filter them by hour.
                    model: calendarView.organizer.items? calendarView.organizer.itemIds(new Date(calendarView.year, calendarView.month, calendarView.day)
                                                                                        , new Date(calendarView.year, calendarView.month, calendarView.day+1))
                                                       : 0

                    Row {

                        spacing:  4


                        Text {
                            id: itemText
                            clip: true
                            focus: true
                            font.pointSize: 18
                            property OrganizerItem oi: calendarView.organizer.item(modelData)

                            text: ((hourDelegateInstanceItem.rowIndex == Qt.formatTime(oi.startDateTime, "hh")) ?  oi.description:"")

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
