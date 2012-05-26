/****************************************************************************
**
** Copyright (C) 2012 Nicola De Filippo.
** All rights reserved.
** Contact: Nicola De Filippo (nicola.defilippo@lizard-solutions.com)
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

import Qt 4.7
import "month.js" as Month
import com.nokia.extras 1.0
import QtMobility.organizer 1.1
import com.nokia.meego 1.0

Item  {
    id:calendarView

    height: (parent.height > parent.width) ? parent.width : parent.height
    width: height

    property Rectangle prevCircle
    property Text prevText
    property color background: "#e7e7e7"
    property color orange: "#ef5500"


    property int month: Month.today().getMonth()
    property int year: Month.today().getFullYear()


//    property date currentDate:new Date();
//    property int day: currentDate.getDate()


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


    onMonthChanged: {
        previousMonthDaysGrid.firstDayOfMonth = new Date(((month - 1) < 0) ? year - 1 : year,((month - 1) < 0) ? 11 : month - 1, 1);
        currentMonthDaysGrid.firstDayOfMonth = new Date(year, month, 1);
        nextMonthDaysGrid.firstDayOfMonth = new Date(((month + 1) > 11) ? year + 1 : year,((month + 1) > 11) ? 0 : month + 1, 1);
        headerTitle.text = getHeaderText()
    }


    OrganizerModel{
        id: organizer
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
         id: tDialog
         titleText: "Date of birth"
         onAccepted: callbackFunction()
    }


    Column {
        id: mainColumn
        anchors.fill: parent

        Row {
            id: headerRow
            anchors{top: parent.top; left: parent.left; right: parent.right}
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

            Item{
                id: next

                anchors{right: parent.right; top: parent.top; bottom: parent.bottom}
                width: height

                Image {
                    anchors.centerIn: parent
                    opacity: 1
                    source: "../../images/right_arrow.png"
                }

                MouseArea {
                    id: mouseAreaNext

                    anchors.fill: parent

                    onClicked: goToNextMonth()
                }
            }

            Item {
                id: headerTitle

                anchors{left: previous.right; right: next.left; top: parent.top; bottom: parent.bottom}

                Text {
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
                        tDialog.open();
                        //console.log("TITLE " + currentMonth);
                    }
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

            contentHeight: monthDaysGridFlickableContent.height
            contentWidth: monthDaysGridFlickableContent.width

            contentX: monthDaysGridItem.width + 1
            boundsBehavior: Flickable.StopAtBounds

            onMovementEnded: {
                if(contentX < 0.75 * monthDaysGridItem.width){
                    goToPreviousMonth()
                    contentX = monthDaysGridItem.width + 1
                }else if(contentX > 1.25 * monthDaysGridItem.width){
                    goToNextMonth()
                    contentX = monthDaysGridItem.width + 1
                }else{
                    contentX = monthDaysGridItem.width + 1
                }
            }

            Row{
                id: monthDaysGridFlickableContent
                height: monthDaysGridItem.height
                width: monthDaysGridItem.width * 3

                MonthDaysGrid{
                    id: previousMonthDaysGrid

                    anchors{top: parent.top; bottom: parent.bottom; left: parent.left}
                    width: monthDaysGridFlickable.width
                }

                MonthDaysGrid{
                    id: currentMonthDaysGrid

                    anchors{top: parent.top; bottom: parent.bottom; left: previousMonthDaysGrid.right}
                    width: monthDaysGridFlickable.width
                }

                MonthDaysGrid{
                    id: nextMonthDaysGrid

                    anchors{top: parent.top; bottom: parent.bottom; left: currentMonthDaysGrid.right}
                    width: monthDaysGridFlickable.width
                }
            }
        }
        }
    }
}
