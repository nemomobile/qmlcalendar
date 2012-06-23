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
            id: calendarView;
        }
    }

    DayView {
        id: dayView;
        calendarView: calendarView;
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
                whatItem.startTime = new Date().getHours();
                whatItem.day = Qt.formatDate(calendarView.currentDate, "dd-MM-yy");

                whatItem.description = "Add object";
                whatItem.location = "Here";
                whatItem.isNew = true;
                whatItem.item = null;

                whatItem.current = calendarView.currentDate;

                mainStack.pageStack.push(whatItem)
            }
        }

        ToolIcon {
            id: toolEdit
            platformIconId: "toolbar-edit"
            onClicked: mainStack.pageStack.push(dayView)
        }
    }
}
