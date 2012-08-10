import QtQuick 1.1
import com.nokia.meego 1.0
import "month.js" as Month

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
