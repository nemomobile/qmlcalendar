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
import "month.js" as Month
import com.nokia.extras 1.0
import QtMobility.organizer 1.1
import com.nokia.meego 1.0

Item  {
    id:calendarView

    height: (parent.height > parent.width) ? parent.width : parent.height
    width: height


    property color background: "#e7e7e7"
    property color orange: "#ef5500"

    property int month
    property int year

    property date currentDate: new Date()
//    property date currentDate:new Date();
    property int day: currentDate.getDate()


    function getHeaderText(){
        return Month.getMonthName(month) + " " + year
    }

    function goToNextMonth() {
        if (month < 11)
            month++
        else {
            year++;
            month = 0;
        }
    }

    function goToPreviousMonth() {
        if (month > 0)
            month--
        else {
            year--;
            month = 11;
        }
    }

    Component.onCompleted: {
        year = Month.today().getFullYear()
        month = Month.today().getMonth()
    }

    onMonthChanged: {
        previousMonthDaysGrid.firstDayOfMonth = new Date(((month - 1) < 0) ? year - 1 : year,((month - 1) < 0) ? 11 : month - 1, 1);
        currentMonthDaysGrid.firstDayOfMonth = new Date(year, month, 1);
        nextMonthDaysGrid.firstDayOfMonth = new Date(((month + 1) > 11) ? year + 1 : year,((month + 1) > 11) ? 0 : month + 1, 1);
//        headerTitleText.text = getHeaderText()
    }


    property OrganizerModel organizer: OrganizerModel{
        //manager:"qtorganizer:mkcal:"
        //startPeriod: currentDate
        //endPeriod: Month.tomorrow(currentDate);
        startPeriod:'2011-01-01'
        endPeriod:'2012-12-31'
        autoUpdate:true
        Component.onCompleted : {
            console.log("manager " + organizer.manager + " ITEM " + organizer.itemCount)
            if (managerName == "mkcal") {
                //console.log("LOAD " + organizer.itemCount + " start " + organizer.startPeriod + " end " + organizer.endPeriod);

                //organizer.importItems(Qt.resolvedUrl("/home/user/MyDocs/qmlcalendar.ics"));
                //console.log("LOAD " + organizer.itemCount + " start " + organizer.startPeriod + " end " + organizer.endPeriod);
//                console.log("current " + currentDate + " +60 " + Month.plus1Hour(currentDate));
            }
        }
        Component.onDestruction:  {
            console.log("Destroy ITEM " + organizer.itemCount)
            if (managerName == "mkcal") {
                console.log("Save");
                organizer.exportItems(Qt.resolvedUrl("/home/user/MyDocs/qmlcalendar.ics"));
            }
        }
    }

    DatePickerDialog {
         id: datePickerDialog
         titleText: "Select Date"
         onAccepted: callbackFunction()
    }


    Item {
        id: mainColumn
        anchors.fill: parent

        Item {
            id: headerRow

            anchors{left: parent.left; right: parent.right}
            height: parent.height * 0.125

            Item{
                id: previous

                anchors{left: parent.left; top: parent.top; bottom: parent.bottom}
                width: height

                Image {
                    anchors.centerIn: parent
                    source: "../../images/left_arrow.png"
                }

                MouseArea {
                    id: mouseAreaPrevious

                    anchors.fill: parent

                    onClicked: goToPreviousMonth()
                }
            }

            Item {
                id: headerTitle

                anchors{left: previous.right; right: next.left; top: parent.top; bottom: parent.bottom}

                Text {
                    id: headerTitleText
                    anchors.fill: parent

                    text: getHeaderText()
                    font.pointSize: parent.height * 0.5
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                MouseArea {
                    id: mouseAreaTitle

                    anchors.fill: parent

                    onClicked: {
                        datePickerDialog.open();
                        //console.log("TITLE " + currentMonth);
                    }
                }
            }

            Item{
                id: next

                anchors{right: parent.right; top: parent.top; bottom: parent.bottom}
                width: height

                Image {
                    anchors.centerIn: parent
                    source: "../../images/right_arrow.png"
                }

                MouseArea {
                    id: mouseAreaNext

                    anchors.fill: parent

                    onClicked: goToNextMonth()
                }
            }
        }

        Row{
            id: headingsLabelRow

            anchors{top: headerRow.bottom; topMargin: 8; left: parent.left; right: parent.right}
            height: parent.height * 0.08

            Repeater {
                id: headerLabelRepeater

                model:["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

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

        Item{
            id: monthDaysGridItem
            anchors{top: headingsLabelRow.bottom; topMargin: 2; bottom: parent.bottom; left: parent.left; right: parent.right}

            onWidthChanged: monthDaysGridFlickable.contentX = width + 1

            Flickable{
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

                    if(contentX < 0.75 * monthDaysGridItem.width){
                        goToPreviousMonth()
                        resetFlickable()
                    }else if(contentX > 1.25 * monthDaysGridItem.width){
                        goToNextMonth()
                        resetFlickable()
                    }else{
                        resetFlickable()
                    }
                }

                onMovementEnded: {

                    animationIsRunning = true
                    if(contentX < 0.75 * monthDaysGridItem.width){
                        contentX = 0
                    }else if(contentX > 1.25 * monthDaysGridItem.width){
                        contentX = monthDaysGridItem.width * 2 + 1
                    }else{
                        contentX = monthDaysGridItem.width + 1
                    }
                }

                function resetFlickable(){
                    contentXAnimation.enabled = false
                    contentX = monthDaysGridItem.width + 1
                    contentXAnimation.enabled = true
                }

                Row{
                    id: monthDaysGridFlickableContent
                    height: monthDaysGridItem.height
                    width: monthDaysGridItem.width * 3

                    MonthDaysGrid{
                        id: previousMonthDaysGrid

                        anchors{top: parent.top; bottom: parent.bottom}
                        width: monthDaysGridFlickable.width
                    }

                    MonthDaysGrid{
                        id: currentMonthDaysGrid

                        anchors{top: parent.top; bottom: parent.bottom}
                        width: monthDaysGridFlickable.width
                    }

                    MonthDaysGrid{
                        id: nextMonthDaysGrid

                        anchors{top: parent.top; bottom: parent.bottom}
                        width: monthDaysGridFlickable.width
                    }
                }
            }
        }
    }
}
