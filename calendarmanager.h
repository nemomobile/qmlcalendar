#ifndef CALENDARMANAGER_H
#define CALENDARMANAGER_H

#include <QObject>
#include <qtorganizer.h>
#include <QOrganizerManager>

QTM_USE_NAMESPACE

class CalendarManager : public QObject
{
    Q_OBJECT
private:
    QOrganizerManager *_manager;
public:
    explicit CalendarManager(QObject *parent = 0);
    Q_INVOKABLE void createEvent(QDateTime startTime, QDateTime endTime, QString description);
    Q_INVOKABLE int count();
signals:
    
public slots:
    
};

#endif // CALENDARMANAGER_H
