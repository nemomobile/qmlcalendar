/****************************************************************************
**
** Copyright (C) 2011 Nicola De Filippo.
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

.pragma library

var MONTH_NAMES = ['January','February','March','April','May','June','July',
'August','September','October','November','December'];

Date.prototype.clone = function() { return new Date(this.getTime()); }

function getDayOfMonth(date, offset)
{
    var day = date.clone();
    day.setDate(offset);
    return day.getDate();
}

function dateOfThisDay(date, offset)
{
    var day = date.clone();
    day.setDate(offset);
    return day;
}

function getColorOfDay(date, offset)
{

    var newDay = date.clone();
    newDay.setDate(offset);
    if (newDay.getMonth() == date.getMonth())
        return "black";
    else
        return "#848284";

}

function isToday(date, offset)
{

    var newDay = date.clone();
    newDay.setDate(offset);
    var today = new Date();
    return newDay.toDateString() == today.toDateString();
}

function getMonthName(month)
{
    if(month instanceof Date){
        return MONTH_NAMES[month.getMonth()];
    }else{
        return MONTH_NAMES[month];
    }
}

function today()
{
    return new Date();

}

function tomorrow(dateObject)
{
    var dateTime = new Date( Qt.formatDate( dateObject, "MM/dd/yyyy" ) );

       dateTime.setHours( Qt.formatDateTime ( dateObject, "hh" ) + 24 );
       return Qt.formatDateTime(dateTime, "yyyy-MM-dd hh:mm:ss");
}

function atHour(dateObject, hour)
{
    var dateTime = new Date( Qt.formatDate( dateObject, "MM/dd/yyyy" ) );

       dateTime.setHours( Qt.formatDateTime ( dateObject, "hh" ) + hour );
       return Qt.formatDateTime(dateTime, "yyyy-MM-dd hh:mm:ss");
}

function atHourObject(dateObject, hour)
{
    var dateTime = new Date( Qt.formatDate( dateObject, "MM/dd/yyyy" ) );

       dateTime.setHours( Qt.formatDateTime ( dateObject, "hh" ) + hour );
       return dateTime;
}

function at59Object(dateObject)
{
    var dateTime = new Date( Qt.formatDate( dateObject, "MM/dd/yyyy" ) );
    console.log("in 59"+dateTime);
    dateTime.setMinutes( Qt.formatDateTime ( dateTime, "mm" ) + 59 );
       //dateTime.setHours( Qt.formatDateTime ( dateObject, "hh:" ) + hour );
       return dateTime;
}

function plus1Hour(dateObject)
{
    var dateTime = new Date(dateObject);

    dateTime.setMinutes( dateTime.getMinutes() + 60 );

    return dateTime;
}

function plusMinutes(dateObject, minutes)
{
    var dateTime = new Date(dateObject);

    dateTime.setMinutes( dateTime.getMinutes() + minutes );

    return dateTime;
}

function calculateIndex(startDate, endDate)
{
    return 1;
}

function getMinutes(index)
{
    switch(index) {
        case 0:
            return 0;
        case 1:
            return 15;
        case 2:
            return 30;
        case 3:
            return 45;
        case 4:
            return 60;
        case 5:
            return 120;
        case 6:
            return (60 * 24);
        default:
            return 0;

    }


}

/*
 * Code taken from:
 * http://www.developer.nokia.com/Community/Wiki/QML_Day_of_Week_%26_Time_Dialog
 * and slightly modified to accept date objects.
 *
 */
function dayIdxByLocalizedDayName(dateObject)
{
    var dayName = Qt.formatDateTime(dateObject, "dddd")

    var myDate = new Date(2012, 0, 2) // This was a Moday for sure.
    for(var i = 0; i < 7; i++){
        if(Qt.formatDateTime(myDate, "dddd" ) == dayName)
        {
            return i-1;
        }
        else{
            myDate.setDate(myDate.getDate() + 1)
        }
    }

    console.log("Error, calculation of weekday index failed.")
    return -1
}
