#include "calendarmanager.h"
#include <QOrganizerEvent>
#include <QDebug>

CalendarManager::CalendarManager(QObject *parent) :
    QObject(parent)
{
    _manager = QOrganizerManager::fromUri("qtorganizer:mkcal:");
}

void CalendarManager::createEvent(QDateTime startTime, QDateTime endTime, QString description)
{
    QOrganizerEvent event;

    QDateTime s, e;

    event.setStartDateTime(QDateTime::currentDateTime());

    event.setEndDateTime(QDateTime::currentDateTime().addSecs(3600));
    event.setDescription(description);
    qDebug() << "date " << startTime.toString("dd-MM-yyyy") << " ev" << event.startDateTime().toString("dd-MM-yyyy") <<  " " << event.description() << endl;
    if (_manager->saveItem(&event) )
        qDebug() << "Salvato\n";
    else
        qDebug() << "error " << _manager->error() << endl;


    qDebug() << "NUM " << _manager->items().length() << endl;
    for (int i = 0; i < _manager->items().length(); i++) {
        qDebug() << "TEMPO " << ((QOrganizerEvent)_manager->items().at(i)).startDateTime() << endl;
    }

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
