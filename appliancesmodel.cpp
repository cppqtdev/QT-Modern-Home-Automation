#include "appliancesmodel.h"
#include "appliancesdetails.h"

AppliancesModel::AppliancesModel(QObject *parent)
    : QAbstractListModel(parent)
{}

int AppliancesModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return mAppliancesList.size();
}

QHash<int, QByteArray> AppliancesModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[NameRole] = "title";
    roles[AppliancesRole] = "icon";
    roles[OpenCloseRole] = "isOpen";
    roles[WifiConnectedRole] = "isWifiConnected";
    roles[WifiOnOffRole] = "isWifiOn";
    roles[SwitchOnRole] = "isOn";
    roles[BatteryPowerRole] = "isBatteryPowered";
    roles[WarningRole] = "isWarning";

    return roles;
}

QVariant AppliancesModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() > mAppliancesList.size()) {
        return {};
    }

    AppliancesDetails *appliance = mAppliancesList[index.row()];

    switch (role) {
    case NameRole:
        return appliance->title();
        break;
    case AppliancesRole:
        return appliance->icon();
        break;
    case OpenCloseRole:
        return appliance->onOff();
        break;
    case WifiConnectedRole:
        return appliance->wifiConnected();
        break;
    case WifiOnOffRole:
        return appliance->wifiOn();
        break;
    case SwitchOnRole:
        return appliance->switchOnOff();
        break;
    case BatteryPowerRole:
        return appliance->batteryPowered();
        break;
    case WarningRole:
        return appliance->fault();
        break;
    default:
        break;
    }

    return {};
}

bool AppliancesModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    bool isChanged = false;
    if (!index.isValid() || index.row() > mAppliancesList.size()) {
        return isChanged;
    }

    AppliancesDetails *appliance = mAppliancesList[index.row()];

    switch (role) {
    case NameRole:
        if (appliance->title() != value.toString()) {
            appliance->setTitle(value.toString());
            isChanged = true;
        }
        break;
    case AppliancesRole:
        if (appliance->title() != value.toString()) {
            appliance->setIcon(value.toString());
            isChanged = true;
        }
        break;
    case OpenCloseRole:
        if (appliance->onOff() != value.toBool()) {
            appliance->setOnOff(value.toBool());
            isChanged = true;
        }
        break;
    case WifiConnectedRole:
        if (appliance->wifiConnected() != value.toBool()) {
            appliance->setWifiConnected(value.toBool());
            isChanged = true;
        }
        break;
    case WifiOnOffRole:
        if (appliance->wifiOn() != value.toBool()) {
            appliance->setWifiOn(value.toBool());
            isChanged = true;
        }
        break;
    case SwitchOnRole:
        if (appliance->switchOnOff() != value.toBool()) {
            appliance->setSwitchOnOff(value.toBool());
            isChanged = true;
        }
        break;
    case BatteryPowerRole:
        if (appliance->batteryPowered() != value.toBool()) {
            appliance->setBatteryPowered(value.toBool());
            isChanged = true;
        }
        break;
    case WarningRole:
        if (appliance->fault() != value.toBool()) {
            appliance->setFault(value.toBool());
            isChanged = true;
        }
        break;
    default:
        break;
    }

    if (isChanged) {
        emit dataChanged(index, index, QVector<int>() << role);
    }

    return isChanged;
}

Qt::ItemFlags AppliancesModel::flags(const QModelIndex &index) const
{
    if (index.isValid()) {
        return Qt::ItemIsEditable;
    }
    return Qt::NoItemFlags;
}

void AppliancesModel::addAppliances(AppliancesDetails *appliances)
{
    const int size = mAppliancesList.size();
    beginInsertRows(QModelIndex(), size, size);
    mAppliancesList.append(appliances);
    endInsertRows();
}

void AppliancesModel::deleteAppliances(int index)
{
    const int size = mAppliancesList.size();
    beginRemoveRows(QModelIndex(), size, size);
    mAppliancesList.removeAt(index);
    endRemoveRows();
}
