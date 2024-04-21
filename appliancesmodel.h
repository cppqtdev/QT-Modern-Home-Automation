#ifndef APPLIANCESMODEL_H
#define APPLIANCESMODEL_H

#include <QAbstractItemModel>
#include <QList>
#include <QObject>

class AppliancesDetails;
class AppliancesModel : public QAbstractListModel
{
public:
    enum AppliancesRoles {
        NameRole = Qt::DisplayRole + 1,
        AppliancesRole,
        OpenCloseRole,
        WifiConnectedRole,
        WifiOnOffRole,
        SwitchOnRole,
        BatteryPowerRole,
        WarningRole
    };

    explicit AppliancesModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;

    void addAppliances(AppliancesDetails *appliances);
    void deleteAppliances(int index);

private:
    QList<AppliancesDetails *> mAppliancesList;
};

#endif // APPLIANCESMODEL_H
