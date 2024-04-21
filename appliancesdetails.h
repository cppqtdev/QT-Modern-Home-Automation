#ifndef APPLIANCESDETAILS_H
#define APPLIANCESDETAILS_H

#include <QObject>

class AppliancesDetails : public QObject
{
    Q_OBJECT
public:
    explicit AppliancesDetails(QObject *parent = nullptr);
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged FINAL)
    Q_PROPERTY(bool onOff READ onOff WRITE setOnOff NOTIFY onOffChanged FINAL)
    Q_PROPERTY(bool wifiConnected READ wifiConnected WRITE setWifiConnected NOTIFY
                   wifiConnectedChanged FINAL)
    Q_PROPERTY(bool wifiOn READ wifiOn WRITE setWifiOn NOTIFY wifiOnChanged FINAL)
    Q_PROPERTY(bool fault READ fault WRITE setFault NOTIFY faultChanged FINAL)
    Q_PROPERTY(bool batteryPowered READ batteryPowered WRITE setBatteryPowered NOTIFY
                   batteryPoweredChanged FINAL)
    Q_PROPERTY(QString icon READ icon WRITE setIcon NOTIFY iconChanged FINAL)
    Q_PROPERTY(bool switchOnOff READ switchOnOff WRITE setSwitchOnOff NOTIFY switchOnOffChanged FINAL)

    QString title() const;
    bool onOff() const;
    bool wifiConnected() const;
    bool fault() const;
    bool batteryPowered() const;
    QString icon() const;
    bool wifiOn() const;
    bool switchOnOff() const;

public slots:
    void setTitle(const QString &newTitle);
    void setOnOff(bool newOnOff);
    void setWifiConnected(bool newWifiConnected);
    void setWifiOn(bool newWifiOn);
    void setFault(bool newFault);
    void setBatteryPowered(bool newBatteryPowered);
    void setIcon(const QString &newIcon);
    void setSwitchOnOff(bool newSwitchOnOff);

signals:
    void titleChanged();
    void onOffChanged();
    void wifiConnectedChanged();
    void faultChanged();
    void batteryPoweredChanged();
    void iconChanged();
    void wifiOnChanged();

    void switchOnOffChanged();

private:
    QString m_title;
    bool m_onOff;
    bool m_wifiConnected;
    bool m_fault;
    bool m_batteryPowered;
    QString m_icon;
    bool m_wifiOn;
    bool m_switchOnOff;
};

#endif // APPLIANCESDETAILS_H
