#include "appliancesdetails.h"
#include <QDebug>

AppliancesDetails::AppliancesDetails(QObject *parent)
    : QObject{parent}
{
    qDebug() << "Appliance Added :: " << m_title;
}

QString AppliancesDetails::title() const
{
    return m_title;
}

void AppliancesDetails::setTitle(const QString &newTitle)
{
    if (m_title == newTitle)
        return;
    m_title = newTitle;
    emit titleChanged();
}

bool AppliancesDetails::onOff() const
{
    return m_onOff;
}

void AppliancesDetails::setOnOff(bool newOnOff)
{
    if (m_onOff == newOnOff)
        return;
    m_onOff = newOnOff;
    emit onOffChanged();
}

bool AppliancesDetails::wifiConnected() const
{
    return m_wifiConnected;
}

void AppliancesDetails::setWifiConnected(bool newWifiConnected)
{
    if (m_wifiConnected == newWifiConnected)
        return;
    m_wifiConnected = newWifiConnected;
    emit wifiConnectedChanged();
}

bool AppliancesDetails::fault() const
{
    return m_fault;
}

void AppliancesDetails::setFault(bool newFault)
{
    if (m_fault == newFault)
        return;
    m_fault = newFault;
    emit faultChanged();
}

bool AppliancesDetails::batteryPowered() const
{
    return m_batteryPowered;
}

void AppliancesDetails::setBatteryPowered(bool newBatteryPowered)
{
    if (m_batteryPowered == newBatteryPowered)
        return;
    m_batteryPowered = newBatteryPowered;
    emit batteryPoweredChanged();
}

QString AppliancesDetails::icon() const
{
    return m_icon;
}

void AppliancesDetails::setIcon(const QString &newIcon)
{
    if (m_icon == newIcon)
        return;
    m_icon = newIcon;
    emit iconChanged();
}

bool AppliancesDetails::wifiOn() const
{
    return m_wifiOn;
}

void AppliancesDetails::setWifiOn(bool newWifiOn)
{
    if (m_wifiOn == newWifiOn)
        return;
    m_wifiOn = newWifiOn;
    emit wifiOnChanged();
}

bool AppliancesDetails::switchOnOff() const
{
    return m_switchOnOff;
}

void AppliancesDetails::setSwitchOnOff(bool newSwitchOnOff)
{
    if (m_switchOnOff == newSwitchOnOff)
        return;
    m_switchOnOff = newSwitchOnOff;
    emit switchOnOffChanged();
}
