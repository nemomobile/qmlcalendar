#include "calendarmanager.h"
#include <QOrganizerEvent>
#include <QDebug>

CalendarManager::CalendarManager(QObject *parent) :
    QObject(parent)
{
    _manager = QOrganizerManager::fromUri("qtorganizer:memory:id=qml");
}

void CalendarManager::createEvent(QDateTime startTime, QDateTime endTime, QString description)
{
    QOrganizerEvent event;
    event.setStartDateTime(startTime);
    event.setDescription(description);
    qDebug() << "date " << startTime.toString("dd-MM-yyyy") << " ev" << event.startDateTime().toString("dd-MM-yyyy") <<  " " << event.description() << endl;
    if (_manager->saveItem(&event) )
        qDebug() << "Salvato\n";
    else
        qDebug() << "error " << _manager->error() << endl;



}

int CalendarManager::count()
{
    QDateTime last(QDate::currentDate());
    QDateTime today(QDate::currentDate());
    last = last.addDays(2);
    qDebug() << "today " << today.toString("dd-MM-yyyy") << " last " << last.toString("dd-MM-yyyy") << endl;
    qDebug() << " M C " <<  _manager->managerUri() << endl;
    return _manager->items(today, last).length();
}
