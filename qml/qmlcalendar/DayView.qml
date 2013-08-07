/*
 * Copyright (C) 2013 Jolla Ltd. <robin.burchell@jollamobile.com>
 * Copyright (C) 2012 Nicola De Filippo <nicola.defilippo@lizard-solutions.com>
 * Copyright (C) 2012 Ruediger Gad <r.c.g@gmx.de>
 *
 * You may use this file under the terms of the BSD license as follows:
 *
 * "Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * * Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in
 * the documentation and/or other materials provided with the
 * distribution.
 * * Neither the name of Nemo Mobile nor the names of its contributors
 * may be used to endorse or promote products derived from this
 * software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
 */

import QtQuick 2.0
import com.nokia.meego 2.0
import QtOrganizer 5.0
import "month.js" as Month

Page {
    id: dayView

    property variant itemIds

    function updateItemIds() {
        var startDateRange = new Date(calendarView.currentDate)
        startDateRange.setHours(0)
        startDateRange.setMinutes(0)
        startDateRange.setSeconds(0)
        var endDateRange = new Date(startDateRange.getFullYear(),
                                    startDateRange.getMonth(),
                                    startDateRange.getDate() + 1)
        console.log("Date range, start: " + startDateRange + " end: " + endDateRange)
        var itemIds = calendarView.organizer.itemIds(startDateRange, endDateRange)

        console.log("Item Ids length: " + itemIds.length)
        dayView.itemIds = itemIds
    }

    PageHeader {
        id: pageHeader
        color: "#ef5500"
        width: parent.width
        text: Qt.formatDate(calendarView.currentDate, "yyyy-MM-dd")
    }

    ListView {
        id: hourList
        clip: true

        anchors {
            top: pageHeader.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        model: hourModel
        delegate: Column {
            width: ListView.view.width
            height: childrenRect.height
            property int rowIndex: index

            // Draw a line under the previous Hour list tiem
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

                        MouseArea {
                            id: mouseAreaHour

                            anchors.fill: parent

                            onClicked: {
                                console.log("New entry, selected hour " + hourText.text)

                                var d = new Date(calendarView.currentDate)
                                d.setHours(hourText.text.split(":")[0])
                                d.setMinutes(hourText.text.split(":")[1])
                                d.setSeconds(0)

                                whatItem.startTime = d
                                whatItem.item = null
                                whatItem.open()
                            }
                        }
                    }
                }

                // List all, if any, of the events within this hour.
                Repeater {
                    id: repeater
                    model: itemIds

                    Rectangle {
                        color: "orange"
                        width:itemText.width
                        height: itemText.height
                        border.color: "black"
                        border.width: 1

                        Text {
                            id: itemText
                            font.pointSize: 18
                            property OrganizerItem oi: calendarView.organizer.item(modelData)

                            text: (oi != null && (rowIndex == Qt.formatTime(oi.startDateTime, "hh")) ?  oi.description:"")

                            MouseArea {
                                id: mouseAreaText

                                anchors.fill: parent

                                onClicked: {

                                    var o = calendarView.organizer.item(modelData)
                                    whatItem.description =  o.description;
                                    whatItem.location = o.location;
                                    whatItem.isNew = false;
                                    whatItem.item = o;
                                    whatItem.open()
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


    tools: ToolBarLayout {
        visible: true

        ToolIcon {
            id: toolBack
            platformIconId: "toolbar-back"
            onClicked: mainStack.pageStack.pop()
        }
    }
}
