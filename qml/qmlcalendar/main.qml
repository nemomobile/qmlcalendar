// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
/*import QtQuick 1.1
import Qt 4.7
import "month.js" as Month
import com.nokia.extras 1.0
import QtMobility.organizer 1.1
import com.nokia.meego 1.0
*/

import QtQuick 1.1
import com.nokia.meego 1.0
import "month.js" as Month
//import com.nokia.extras 1.0


PageStackWindow {
    id: mainStack
    showStatusBar: false;

    initialPage: calendarPage

    Page {
        id: calendarPage
        tools: mainTools

        CalendarView {
            id: calendarView

            onCurrentDateChanged: {
                dayView.updateItemIds()
            }
        }
    }

    DayView {
        id: dayView
    }

    ItemView {
        id: itemView;
        //calendarView: calendarView;
    }

    What {
        id: whatItem;
        organizer: calendarView.organizer;
    }

    ToolBarLayout {
        id: mainTools
        visible: true

        ToolIcon {
            id: toolAdd
            platformIconId: "toolbar-add"
            onClicked: {
                var d = new Date(calendarView.currentDate)
                var now = new Date()
                d.setHours(now.getHours())
                d.setMinutes(0)
                d.setSeconds(0)
                console.log(d)
                whatItem.startTime = d

                whatItem.item = null

                whatItem.open()
            }
        }

        ToolIcon {
            id: toolEdit
            platformIconId: "toolbar-edit"
            onClicked: mainStack.pageStack.push(dayView)
        }
    }
}
