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

import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.organizer 1.1
import "month.js" as Month

Page
{
    id: dayView
    property variant calendarView: calendarView;
    property variant itemIds: calendarView.organizer.itemIds(calendarView.currentDate, new Date(calendarView.year, calendarView.month, calendarView.day+1))

    tools: dayTools

    Text{
        id: dateText

        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }

        text: Qt.formatDate(calendarView.currentDate, "yyyy-MM-dd")
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 40
    }

    ListView {
        id: hourList

        anchors{
            top: dateText.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        model : hourModel
        delegate : hourDelegate

        clip: true
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
                        height: hourText.height

                        Text {
                            // text: hour
                            id: hourText
                            text: index + ":00"
                            width: 80//hourList.width
                            font.pointSize: 18


                            // property OrganizerItem oi: calendarView.organizer.item(repeater.modelData)
                            MouseArea {
                                id: mouseAreaHour

                                anchors.fill: parent

                                onClicked: {
                                    console.log("New entry")
                                    console.log("Selected hour " + hourText.text)

                                    var d = new Date(calendarView.currentDate)
                                    d.setHours(hourText.text.split(":")[0])
                                    d.setMinutes(hourText.text.split(":")[1])
                                    d.setSeconds(0)
                                    console.log(d)
                                    whatItem.startTime = d

//                                    whatItem.description = ""
//                                    whatItem.location = ""
//                                    whatItem.isNew = true
                                    whatItem.item = null

                                    whatItem.open()
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

                                            //toolDone.visible = true;

                                            //toolDelete.visible = true;
                                            whatItem.open()
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


    ToolBarLayout {
        id: dayTools
        visible: true

        ToolIcon {
            id: toolBack
            platformIconId: "toolbar-back"
            onClicked: mainStack.pageStack.pop()
        }
    }
}
