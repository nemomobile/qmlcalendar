#include <QtGui/QApplication>
#include <QDeclarativeView>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QDeclarativeView view;


    view.setSource(QUrl("qrc:/qml/qmlcalendar/CalendarView.qml"));
    view.show();


    return app.exec();
}
