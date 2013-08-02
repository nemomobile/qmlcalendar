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
import "month.js" as Month
import QtOrganizer 5.0
import com.nokia.meego 2.0

Item  {
    id: calendarView

    height: (parent.height > parent.width) ? parent.width : parent.height
    width: height


    property color orange: "#ef5500"

    property date currentDate


    function getHeaderText() {
        return Month.getMonthName(currentDate.getMonth()) + " " + currentDate.getFullYear()
    }

    function goToNextMonth() {
        var y = currentDate.getFullYear()
        var m = currentDate.getMonth()

        if (m < 11)
            m++
        else {
            y++;
            m = 0;
        }

        currentDate = new Date(y, m, currentDate.getDate())
    }

    function goToPreviousMonth() {
        var y = currentDate.getFullYear()
        var m = currentDate.getMonth()

        if (m > 0)
            m--
        else {
            y--;
            m = 11;
        }

        currentDate = new Date(y, m, currentDate.getDate())
    }

    Component.onCompleted: {
        currentDate = new Date()
    }

    onCurrentDateChanged: {
        var y = currentDate.getFullYear()
        var m = currentDate.getMonth()

        console.log("Current date changed: Year: " + y + " Month: " + m)

        previousMonthDaysGrid.firstDayOfMonth = new Date(((m - 1) < 0) ? y - 1 : y,((m - 1) < 0) ? 11 : m - 1, 1);
        currentMonthDaysGrid.firstDayOfMonth = new Date(y, m, 1);
        nextMonthDaysGrid.firstDayOfMonth = new Date(((m + 1) > 11) ? y + 1 : y,((m + 1) > 11) ? 0 : m + 1, 1);

        currentMonthDaysGrid.updateSelection()
    }


    property OrganizerModel organizer: OrganizerModel {
        manager: "qtorganizer:mkcal"

        // TODO: fetching a full month (possibly even a year) around currentDate would probably be a good idea
        startPeriod: currentDate
        endPeriod: Month.tomorrow(currentDate);
        autoUpdate: true

        /* FIXME: works in qt4, but ref to onEventsChanged could not be found anywhere else on qt4 nemo rootfs
        onEventsChanged: {
            console.log("Events changed...")

            for(var i = 0; i < events.length; i++) {
                var e = events[i]
                console.log("Event " + i + " " + e.description + ", " + e.location + ", " + e.startDateTime + ", " + e.endDateTime)
            }

            dayView.updateItemIds()
        }
        */
    }

    Item {
        id: headerRow

        width: parent.width
        height: parent.height * 0.125

        MouseArea {
            id: previous
            height: parent.height
            width: height

            Image {
                anchors.centerIn: parent
                source: "../../images/left_arrow.png"
            }

            onClicked: goToPreviousMonth()
        }

        MouseArea {
            id: headerTitle
            height: parent.height

            anchors {
                left: previous.right
                right: next.left
            }

            Text {
                id: headerTitleText
                anchors.fill: parent

                text: getHeaderText()
                font.pointSize: parent.height * 0.5
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            Component {
                id: dpd
                DatePickerDialog {
                }
            }

            property Item datePickerInstance

            onClicked: {
                datePickerInstance = pageStack.openDialog(dpd, {
                    day: currentDate.getDate(),
                    month: currentDate.getMonth() + 1,
                    year: currentDate.getFullYear(),
                    acceptButtonText: "Go",
                    rejectButtonText: "Cancel",
                    titleText: "Select Date" }
                )
                datePickerInstance.accepted.connect(function() {
                    currentDate = new Date(datePickerInstance.year, datePickerInstance.month - 1, datePickerInstance.day)
                })
            }
        }

        MouseArea {
            id: next
            height: parent.height
            width: height
            anchors.right: parent.right

            Image {
                anchors.centerIn: parent
                source: "../../images/right_arrow.png"
            }

            onClicked: goToNextMonth()
        }
    }

    Row {
        id: headingsLabelRow

        anchors {
            top: headerRow.bottom
            topMargin: 8
        }

        width: parent.width
        height: parent.height * 0.08

        Repeater {
            id: headerLabelRepeater

            model: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

            Text {
                text: modelData

                width: parent.width / 7
                font.pointSize: parent.height * 0.5
                verticalAlignment: Text.AlignBottom
                horizontalAlignment: Text.AlignHCenter

                color: (index > 4)?orange:"#737573"
            }
        }
    }

    Item {
        id: monthDaysGridItem

        anchors{
            top: headingsLabelRow.bottom
            topMargin: 2
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        onWidthChanged: monthDaysGridFlickable.contentX = width + 1

        Flickable {
            id: monthDaysGridFlickable
            anchors.fill: parent

            clip: true

            contentHeight: monthDaysGridFlickableContent.height
            contentWidth: monthDaysGridFlickableContent.width

            contentX: monthDaysGridItem.width + 1
            boundsBehavior: Flickable.StopAtBounds

            property bool animationIsRunning: false

            Behavior on contentX {
                id: contentXAnimation

                SequentialAnimation {
                    PropertyAnimation { duration: 140 }
                    ScriptAction { script: monthDaysGridFlickable.animationIsRunning = false }
                }
            }

            onFlickStarted: {
                animationIsRunning = true

                if(horizontalVelocity > 0){
                    contentX = monthDaysGridItem.width * 2 + 1
                }else{
                    contentX = 0
                }
            }

            onAnimationIsRunningChanged: {
                if(animationIsRunning)
                    return

                if(contentX < 0.75 * monthDaysGridItem.width) {
                    goToPreviousMonth()
                    resetFlickable()
                }else if(contentX > 1.25 * monthDaysGridItem.width) {
                    goToNextMonth()
                    resetFlickable()
                }else{
                    resetFlickable()
                }
            }

            onMovementEnded: {

                animationIsRunning = true
                if(contentX < 0.75 * monthDaysGridItem.width) {
                    contentX = 0
                }else if(contentX > 1.25 * monthDaysGridItem.width) {
                    contentX = monthDaysGridItem.width * 2 + 1
                }else{
                    contentX = monthDaysGridItem.width + 1
                }
            }

            function resetFlickable() {
                contentXAnimation.enabled = false
                contentX = monthDaysGridItem.width + 1
                contentXAnimation.enabled = true
            }

            Row {
                id: monthDaysGridFlickableContent
                height: monthDaysGridItem.height
                width: monthDaysGridItem.width * 3

                MonthDaysGrid {
                    id: previousMonthDaysGrid
                    width: monthDaysGridFlickable.width
                    height: parent.height
                }

                MonthDaysGrid {
                    id: currentMonthDaysGrid
                    width: monthDaysGridFlickable.width
                    height: parent.height
                }

                MonthDaysGrid {
                    id: nextMonthDaysGrid
                    width: monthDaysGridFlickable.width
                }
            }
        }
    }
}
