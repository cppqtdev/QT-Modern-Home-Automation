import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Style
import Qt5Compat.GraphicalEffects
import "Components"

ApplicationWindow {
    id: root
    width: 1680
    height: 1050
    visible: true
    color: Style.background
    title: qsTr("Home Automation")

    property string temperatureInfo
    property string humidityInfo
    property string visibilityInfo
    property string windSpeedInfo
    property string cityInfo
    property string uvInfo
    property string minTempInfo
    property string maxTempInfo
    property int weatherID



    //999b74fac224c0ad7a977d91ecdf0e68
    //https://api.openweathermap.org/data/2.5/weather?lat=28.4595&lon=77.0266&appid=999b74fac224c0ad7a977d91ecdf0e68


    function makeHttpRequest() {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    let response = JSON.parse(xhr.responseText);
                    console.log(JSON.stringify(response));

                    let cityName = response.name;
                    let temperatureKelvin = response.main.temp;
                    let temperatureCelsius = temperatureKelvin - 273.15; // Conversion from Kelvin to Celsius
                    let humidity = response.main.humidity;
                    let windSpeed = response.wind.speed;
                    let visibilityMeters = response.visibility;
                    let visibilityKm = visibilityMeters / 1000; // Conversion from meters to kilometers

                    let weatherId = response.weather[0].id;
                    // Assuming UV index is not directly provided by the API, you may need to calculate it based on other parameters

                    // Example calculation of UV index (just for demonstration purposes, you may need to adjust this based on actual data)
                    let uvIndex = calculateUVIndex(temperatureCelsius, windSpeed, humidity);

                    // Do whatever you want with the extracted information
                    console.log("City Name: " + cityName);
                    console.log("Temperature: " + temperatureCelsius.toFixed(2) + " °C"); // Limiting to 2 decimal places
                    console.log("Humidity: " + humidity + "%");
                    console.log("Wind Speed: " + windSpeed + " m/s");
                    console.log("Visibility: " + visibilityKm.toFixed(2) + " km"); // Limiting to 2 decimal places
                    console.log("UV Index: " + uvIndex.toFixed(2));


                    var minTemperatureKelvin = response.main.temp_min;
                    var minTemperatureCelsius = minTemperatureKelvin - 273.15; // Conversion from Kelvin to Celsius
                    var maxTemperatureKelvin = response.main.temp_max;
                    var maxTemperatureCelsius = maxTemperatureKelvin - 273.15;

                    minTempInfo = minTemperatureCelsius.toFixed(0)
                    maxTempInfo = maxTemperatureCelsius.toFixed(0)

                    temperatureInfo = temperatureCelsius.toFixed(2) + " °C"
                    humidityInfo = humidity + "%"
                    visibilityInfo = visibilityKm.toFixed(2) + " km"
                    windSpeedInfo = windSpeed + " m/s"
                    cityInfo = cityName
                    uvInfo = uvIndex.toFixed(2)
                    weatherID = weatherId

                } else {
                    console.error('Request failed with status:', xhr.status);
                }
            }
        };

        var url = "https://api.openweathermap.org/data/2.5/weather?lat=28.4595&lon=77.0266&appid=999b74fac224c0ad7a977d91ecdf0e68";
        xhr.open("GET", url, true);
        xhr.send();
    }
    // Function to calculate UV index (example implementation)
    function calculateUVIndex(temperature, windSpeed, humidity) {
        // Example calculation based on temperature, wind speed, and humidity
        // This is just a placeholder, you may need to replace it with a more accurate calculation based on available data
        var uvIndex = (temperature * humidity) / windSpeed; // Example formula, adjust according to actual data
        return uvIndex / 100;
    }

    function getFontAwesomeIconCode(weatherId) {
        const iconMap = {
            200: "\uf01e", // Thunderstorm
            300: "\uf01c", // Drizzle
            500: "\uf019", // Rain
            600: "\uf01b", // Snow
            700: "\uf014", // Atmosphere
            800: "\uf00d", // Clear
            801: "\uf002", // Few clouds
            802: "\uf002", // Scattered clouds
            803: "\uf002", // Broken clouds
            804: "\uf013", // Overcast clouds
            721: "\uf0c2"  // Haze
            // Add more mappings as needed
        };

        return iconMap[weatherId] || "\uf07b"; // Default icon if no match found
    }

    function getWeatherColorCode(weatherId) {
        const colorMap = {
            200: "#2E3192", // Thunderstorm
            300: "#005AA7", // Drizzle
            500: "#0081CF", // Rain
            600: "#00A4E4", // Snow
            700: "#66CCCC", // Atmosphere
            800: "#FFD662", // Clear
            801: "#FFA733", // Few clouds
            802: "#FF7F00", // Scattered clouds
            803: "#FF5500", // Broken clouds
            804: "#AACCFF", // Overcast clouds
            721: "#AA6633"  // Haze
            // Add more mappings as needed
        };

        return colorMap[weatherId] || "#808080"; // Default color if no match found
    }

    function getCurrentDate() {
        const months = [
                         "January", "February", "March", "April", "May", "June",
                         "July", "August", "September", "October", "November", "December"
                     ];

        const days = [
                       "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
                   ];

        const currentDate = new Date();
        const monthName = months[currentDate.getMonth()];
        const date = currentDate.getDate();
        const dayName = days[currentDate.getDay()];

        return `${monthName} ${date} ${dayName}`;
    }

    Component.onCompleted: {
        makeHttpRequest()
    }
    QtObject {
        id: sliderProperties

        property int trackWidth: 18
        property int progressWidth: 18
        property int handleWidth: 28
        property int handleHeight: 28
        property int handleRadius: 14
        property int handleVerticalOffset: 0

        property real startAngle: -130
        property real endAngle: 130
        property real minValue: 16
        property real maxValue: 32

        property color trackColor: "#505050"
        property color progressColor: Style.blue
        property color handleColor: "#fefefe"

        property bool snap: false
        property real stepSize: 1
        property bool hideTrack: false
        property bool hideProgress: false
    }


    ColumnLayout {
        width: parent.width * 0.4
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 10

        Item{ Layout.preferredHeight: 10}

        ShadowRectangle {
            Layout.preferredWidth: 300
            Layout.preferredHeight: 65
            radius: height / 2

            RowLayout {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter

                OutlinedLabel {
                    Layout.alignment: Qt.AlignLeft
                    textIcon: "\uf007"
                    iconSize: 18
                    radius: implicitHeight /2
                    borderColor: Style.alphaColor("#00000000",0.2)
                    color: Style.iconColor
                    backgroundColor: "#00000000"
                    implicitHeight: 45
                    implicitWidth: 45
                }

                ColumnLayout {
                    Layout.alignment: Qt.AlignLeft
                    Text {
                        Layout.alignment: Qt.AlignLeft
                        font.pixelSize: 16
                        text: qsTr("Adesh Singh")
                        font.bold: Font.Bold
                        color: Style.alphaColor("#000000",0.8)
                    }
                    Text {
                        Layout.alignment: Qt.AlignLeft
                        font.pixelSize: 12
                        text: qsTr("adeshworkmail@gmail.com")
                        color: Style.alphaColor("#000000",0.8)
                    }
                }


                OutlinedLabel {
                    Layout.alignment: Qt.AlignRight
                    textIcon: "\uf078"
                    iconSize: 18
                    radius: implicitHeight /2
                    borderColor: Style.alphaColor("#00000000",0.2)
                    color: Style.iconColor
                    backgroundColor: "#00000000"
                    implicitHeight: 45
                    implicitWidth: 45
                }
            }
        }

        Item{ Layout.preferredHeight: 10}

        RowLayout {
            width: parent.width
            ColumnLayout {
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Text {
                    font.pixelSize: 24
                    font.bold: Font.Bold
                    font.weight: Font.Medium
                    text: qsTr("Good Morning, %1").arg("Adesh!")
                }

                Text {
                    width: parent * 0.5
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    font.pixelSize: 12
                    text: qsTr("Living Room Lamp is opening. Speaker is playing.")
                    color: Style.alphaColor("#000000",0.2)
                }

                Text {
                    font.pixelSize: 14
                    text: qsTr("and 2 more >")
                    font.bold: Font.Bold
                    font.weight: Font.Medium
                    color: Style.alphaColor("#000000",0.5)
                }
            }

            Item{ Layout.fillWidth: true }

            ShadowRectangle {
                radius: 30
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                width: 350
                Layout.preferredHeight: 150

                Rectangle {
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.horizontalCenter: parent.horizontalCenter

                    width: parent.width * 0.95
                    height: 70
                    radius: 20
                    color: "#00000000"
                    border.width: 2
                    border.color: Style.alphaColor("#000000",0.4)

                    RowLayout {
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter

                        IconLabel {
                            icon: getFontAwesomeIconCode(weatherID)
                            color: getWeatherColorCode(weatherID)
                            size: 18
                        }

                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            font.pixelSize: 16
                            text: getCurrentDate();
                            color: Style.alphaColor("#000000",0.6)
                        }
                    }

                    RowLayout {
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 0
                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            font.pixelSize: 16
                            text: maxTempInfo
                            color: Style.black
                        }
                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            font.pixelSize: 16
                            text: " /" + temperatureInfo
                            color: Style.alphaColor("#000000",0.6)
                        }
                    }

                    Rectangle {
                        height: 4
                        width: 40
                        radius: 2
                        color: "#bfbfbfd9"
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 5
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                RowLayout {
                    width: parent.width
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter
                        Layout.leftMargin: (parent.width * 0.1) /2
                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            font.pixelSize: 12
                            text: windSpeedInfo
                            color: Style.alphaColor("#000000",0.8)
                        }
                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            font.pixelSize: 12
                            text: qsTr("Wind")
                            color: Style.alphaColor("#000000",0.8)
                        }
                    }
                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter
                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            font.pixelSize: 12
                            text: visibilityInfo
                            color: Style.alphaColor("#000000",0.8)
                        }
                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            font.pixelSize: 12
                            text: qsTr("Visibility")
                            color: Style.alphaColor("#000000",0.8)
                        }
                    }
                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter
                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            font.pixelSize: 12
                            text: uvInfo
                            color: Style.alphaColor("#000000",0.8)
                        }
                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            font.pixelSize: 12
                            text: qsTr("UV")
                            color: Style.alphaColor("#000000",0.8)
                        }
                    }
                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter
                        Layout.rightMargin: (parent.width * 0.1) /2
                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            font.pixelSize: 12
                            text: humidityInfo
                            color: Style.alphaColor("#000000",0.8)
                        }
                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            font.pixelSize: 12
                            text: qsTr("Humidity")
                            color: Style.alphaColor("#000000",0.8)
                        }
                    }
                }
            }
        }

        Item{ Layout.preferredHeight: 20}

        ShadowRectangle {
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 170
            RowLayout {
                width: parent.width
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    Layout.leftMargin: 10
                    font.pixelSize: 18
                    font.bold: Font.Bold
                    font.weight: Font.Medium
                    text: qsTr("Scenes")
                }

                Item {Layout.fillWidth: true }

                IconLabel {
                    icon: "\uf142"
                    size: 18
                    color: Style.iconColor
                    Layout.rightMargin: 10
                }
            }

            TabBar {
                id: bar
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 10
                background: null
                spacing: 20

                PrefsTabButton {
                    title: "Music"
                    textIcon: "\uf001"
                    iconColor: Style.red
                }

                PrefsTabButton {
                    title: "Walking"
                    textIcon: "\uf29d"
                    iconColor: Style.blue
                }

                PrefsTabButton {
                    title: "Night"
                    textIcon: "\uf186"
                    iconColor: Style.blueGreen
                }

                PrefsTabButton {
                    title: "Movie"
                    textIcon: "\uf008"
                    iconColor: Style.green
                }

                PrefsTabButton {
                    title: "Sleep"
                    textIcon: "\uf236"
                    iconColor: Style.yello
                }

                PrefsTabButton {
                    title: "Arrive"
                    textIcon: "\uf5af"
                    iconColor: Style.blueGreen
                }

                PrefsTabButton {
                    title: "Morning"
                    textIcon: "\uf185"
                    iconColor: Style.yellowLight
                }
            }

            Rectangle {
                height: 4
                width: 40
                radius: 2
                color: "#bfbfbfd9"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Item{ Layout.preferredHeight: 10}

        RowLayout {
            width: parent.width
            ColumnLayout {
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Text {
                    font.pixelSize: 16
                    font.bold: Font.Bold
                    font.weight: Font.Medium
                    text: qsTr("Living Room")
                }
                Text {
                    font.pixelSize: 12
                    text: qsTr("11 Devices")
                    color: Style.alphaColor("#000000",0.5)
                }
            }

            Item{ Layout.fillWidth: true }

            OutlinedButtonWithicon {
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                textIcon: "\uf304"
                spacing: 10
                iconSize: 14
                font.pixelSize: 14
                implicitHeight: 38
                text: qsTr("EDIT")
                color: Style.alphaColor("#000000",0.4)
                borderColor: Style.alphaColor("#000000",0.6)
                backgroundColor: "#00000000"
            }
        }

        Item{ Layout.preferredHeight: 10}

        RowLayout {
            width: parent.width
            spacing: 20
            ShadowRectangle {
                Layout.preferredWidth: parent.width * 0.315
                Layout.preferredHeight: 150
                contentItem: Item {
                    anchors.fill: parent
                    RowLayout {
                        width: parent.width
                        anchors.top: parent.top
                        anchors.topMargin: 8
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 10

                        ShadowRectangle {
                            Layout.leftMargin: 10
                            Layout.alignment: Qt.AlignVCenter
                            implicitHeight: 52
                            implicitWidth: 52
                            radius: implicitHeight / 2
                            OutlinedLabel {
                                anchors.centerIn: parent
                                textIcon: "\uf1eb"
                                iconSize: 18
                                radius: implicitHeight /2
                                color: Style.blue
                                backgroundColor: Style.alphaColor(Style.blue,0.1)
                                implicitHeight: 42
                                implicitWidth: 42
                            }
                        }

                        ColumnLayout {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            Text {
                                font.pixelSize: 16
                                font.bold: Font.Bold
                                font.weight: Font.Medium
                                text: "Nest WiFi"
                            }
                            Text {
                                property bool isAvaible: true
                                property bool isOpen: true

                                font.pixelSize: 12
                                text: isAvaible ? isOpen ? qsTr("Connected") : qsTr("Disconnected") : qsTr("Unavaible")
                                color: Style.alphaColor("#000000",0.5)
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                        }
                    }
                    //
                    RowLayout {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 30
                        spacing: 20


                        Rectangle {
                            radius: 6
                            Layout.preferredWidth: 120
                            height: 45
                            color: Style.alphaColor("#000000",0.1)

                            RowLayout {
                                anchors.top: parent.top
                                anchors.topMargin: 5
                                anchors.horizontalCenter: parent.horizontalCenter
                                IconLabel {
                                    size: 12
                                    text: "\uf063"
                                    color: Style.alphaColor("#000000",0.5)
                                }

                                Text {
                                    font.pixelSize: 12
                                    color: Style.alphaColor("#000000",0.5)
                                    text: qsTr("97")
                                }
                            }

                            Text {
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 5
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.pixelSize: 12
                                color: Style.alphaColor("#000000",0.5)
                                text: qsTr("Mbps Download")
                            }
                        }

                        ShadowRectangle {
                            Layout.leftMargin: 10
                            Layout.alignment: Qt.AlignVCenter
                            implicitHeight: 52
                            implicitWidth: 52
                            radius: implicitHeight / 2
                            OutlinedLabel {
                                anchors.centerIn: parent
                                textIcon: "\uf062"
                                iconSize: 18
                                radius: 24
                                color: Style.alphaColor("#000000",0.5)
                                backgroundColor: Style.alphaColor("#000000",0.1)
                                borderColor: backgroundColor
                                implicitHeight: 42
                                implicitWidth: 42
                            }
                        }
                    }
                }
            }

            ShadowRectangle {
                color: Style.blue
                Layout.preferredWidth: parent.width * 0.315
                Layout.preferredHeight: 150
                contentItem: Item {
                    anchors.fill: parent
                    RowLayout {
                        width: parent.width
                        anchors.top: parent.top
                        anchors.topMargin: 8
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 10

                        OutlinedLabel {
                            Layout.leftMargin: 10
                            Layout.alignment: Qt.AlignVCenter
                            textIcon: "\uf0eb"
                            iconSize: 18
                            radius: 24
                            color: Style.white
                            backgroundColor: Style.alphaColor("#000000",0.1)
                            borderColor: backgroundColor
                            implicitHeight: 45
                            implicitWidth: 45
                        }

                        ColumnLayout {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            Text {
                                font.pixelSize: 16
                                font.bold: Font.Bold
                                font.weight: Font.Medium
                                text: "Study Lamp"
                                color: Style.white
                            }
                            Text {
                                property bool isAvaible: true
                                property bool isOpen: false

                                font.pixelSize: 12
                                text: isAvaible ? isOpen ? qsTr("Opened") : qsTr("Closed") : qsTr("Unavaible")
                                color: Style.white
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                        }
                    }

                    Slider {
                        id: bulb
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 30
                        implicitWidth: parent.width * 0.8
                        implicitHeight: 45
                        orientation: Qt.Horizontal
                        handle: null

                        from: 0
                        to: 100
                        value: 65

                        background: Rectangle {
                            x: bulb.leftPadding + (bulb.horizontal ? 0 : (bulb.availableWidth - width) / 2)
                            y: bulb.topPadding + (bulb.horizontal ? (bulb.availableHeight - height) / 2 : 0)
                            implicitWidth: bulb.horizontal ? 200 : 6
                            implicitHeight: 45
                            width: bulb.horizontal ? bulb.availableWidth : implicitWidth
                            height: bulb.horizontal ? implicitHeight : bulb.availableHeight
                            radius: 16
                            color: Style.alphaColor("#000000",0.1)

                            Rectangle {
                                y: bulb.horizontal ? 0 : bulb.visualPosition * parent.height
                                width: bulb.horizontal ? bulb.position * parent.width : 6
                                height: bulb.horizontal ? 45 : bulb.position * parent.height

                                radius: 16
                                color: Style.white
                            }
                        }
                    }
                }
            }
            ShadowRectangle {
                color: Style.blue
                Layout.preferredWidth: parent.width * 0.315
                Layout.preferredHeight: 150
                contentItem: Item {
                    anchors.fill: parent
                    RowLayout {
                        width: parent.width
                        anchors.top: parent.top
                        anchors.topMargin: 8
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 10

                        OutlinedLabel {
                            Layout.leftMargin: 10
                            Layout.alignment: Qt.AlignVCenter
                            textIcon: "\uf2dc"
                            iconSize: 18
                            radius: 24
                            color: Style.white
                            backgroundColor: Style.alphaColor("#000000",0.1)
                            borderColor: backgroundColor
                            implicitHeight: 45
                            implicitWidth: 45
                        }

                        ColumnLayout {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            Text {
                                font.pixelSize: 16
                                font.bold: Font.Bold
                                font.weight: Font.Medium
                                text: "Air Conditioner"
                                color: Style.white
                            }
                            Text {
                                property bool isAvaible: true
                                property bool isOpen: false

                                font.pixelSize: 12
                                text: isAvaible ? isOpen ? qsTr("Opened") : qsTr("Closed") : qsTr("Unavaible")
                                color: Style.white
                            }
                        }

                        Item {
                            Layout.fillWidth: true
                        }
                    }

                    RowLayout {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 30
                        spacing: 25

                        OutlinedLabel {
                            Layout.leftMargin: 10
                            Layout.alignment: Qt.AlignVCenter
                            textIcon: "\uf067"
                            iconSize: 18
                            radius: 24
                            color: Style.blue
                            backgroundColor: Style.white
                            borderColor: backgroundColor
                            implicitHeight: 45
                            implicitWidth: 45
                        }
                        ColumnLayout {
                            Layout.alignment: Qt.AlignVCenter
                            Layout.fillHeight: false
                            spacing: 5
                            Text {
                                font.pixelSize: 26
                                font.bold: Font.Bold
                                font.weight: Font.Medium
                                text: qsTr("36")
                                color: Style.white
                            }
                            Text {
                                font.pixelSize: 18
                                text: qsTr("°C")
                                color: Style.alphaColor("#FFFFFF",0.4)
                            }
                        }

                        OutlinedLabel {
                            Layout.leftMargin: 10
                            Layout.alignment: Qt.AlignVCenter
                            textIcon: "\uf068"
                            iconSize: 18
                            radius: 24
                            color: Style.blue
                            backgroundColor: Style.white
                            borderColor: backgroundColor
                            implicitHeight: 45
                            implicitWidth: 45
                        }
                    }

                }
            }
        }

        Item{ Layout.preferredHeight: 10}

        RowLayout {
            width: parent.width
            spacing: 20
            ShadowRectangle {
                Layout.preferredWidth: parent.width * 0.32
                Layout.fillHeight: true
                gradient: Gradient {
                    orientation: Gradient.Vertical
                    GradientStop { position: 0.0; color: "#273b49" }
                    GradientStop { position: 1.0; color: "#412721" }
                }

                ColumnLayout {
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.leftMargin: 10
                    spacing: 10
                    RowLayout {
                        Layout.alignment: Qt.AlignLeft
                        spacing: 10
                        OutlinedLabel {
                            Layout.alignment: Qt.AlignLeft
                            textIcon: "\uf028"
                            iconSize: 18
                            radius: implicitHeight /2
                            borderColor: "#00000000"
                            color: Style.white
                            backgroundColor: Style.alphaColor("#00000000",0.2)
                            implicitHeight: 55
                            implicitWidth: 55
                        }

                        ColumnLayout {
                            Layout.alignment: Qt.AlignLeft
                            Text {
                                Layout.alignment: Qt.AlignLeft
                                font.pixelSize: 16
                                font.bold: Font.Bold
                                text: qsTr("Speaker")
                                color: Style.white
                            }
                            Text {
                                Layout.alignment: Qt.AlignLeft
                                font.pixelSize: 12
                                text: qsTr("Opening")
                                color: Style.alphaColor("#FFFFFF",0.6)
                            }
                        }
                    }
                    RowLayout {
                        spacing: 10
                        Layout.alignment: Qt.AlignLeft
                        OutlinedLabel {
                            Layout.alignment: Qt.AlignLeft
                            textIcon: "\uf58f"
                            iconSize: 18
                            radius: implicitHeight /2
                            borderColor: Style.alphaColor("#FFFFFF",0.6)
                            color: Style.white
                            backgroundColor: Style.alphaColor("#00000000",0.2)
                            implicitHeight: 55
                            implicitWidth: 55
                        }

                        ColumnLayout {
                            Layout.alignment: Qt.AlignLeft
                            Text {
                                Layout.alignment: Qt.AlignLeft
                                font.pixelSize: 16
                                text: qsTr("Light On")
                                font.bold: Font.Bold
                                color: Style.white
                            }
                            Text {
                                Layout.alignment: Qt.AlignLeft
                                font.pixelSize: 12
                                text: qsTr("Maggie Rogers")
                                color: Style.alphaColor("#FFFFFF",0.6)
                            }
                        }
                    }

                    ColumnLayout {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.rightMargin: 10
                        spacing: 0
                        Slider {
                            id: sliderControl
                            Layout.fillWidth: true
                            value: 40
                            from: 0
                            to: 100
                            handle: Rectangle {
                                x: sliderControl.leftPadding + (sliderControl.horizontal ? sliderControl.visualPosition * (sliderControl.availableWidth - width) : (sliderControl.availableWidth - width) / 2)
                                y: sliderControl.topPadding + (sliderControl.horizontal ? (sliderControl.availableHeight - height) / 2 : sliderControl.visualPosition * (sliderControl.availableHeight - height))
                                implicitWidth: 18
                                implicitHeight: 18
                                radius: width / 2
                                color: sliderControl.pressed ? sliderControl.palette.light : sliderControl.palette.window
                                border.width: sliderControl.visualFocus ? 2 : 1
                                border.color: sliderControl.visualFocus ? sliderControl.palette.highlight : sliderControl.enabled ? sliderControl.palette.mid : sliderControl.palette.midlight
                            }
                            background: Rectangle {
                                x: sliderControl.leftPadding + (sliderControl.horizontal ? 0 : (sliderControl.availableWidth - width) / 2)
                                y: sliderControl.topPadding + (sliderControl.horizontal ? (sliderControl.availableHeight - height) / 2 : 0)
                                implicitWidth: sliderControl.horizontal ? 200 : 6
                                implicitHeight: sliderControl.horizontal ? 6 : 200
                                width: sliderControl.horizontal ? sliderControl.availableWidth : implicitWidth
                                height: sliderControl.horizontal ? implicitHeight : sliderControl.availableHeight
                                radius: 3
                                color: Style.alphaColor("#00000000",0.2)
                                scale: sliderControl.horizontal && sliderControl.mirrored ? -1 : 1

                                Rectangle {
                                    y: sliderControl.horizontal ? 0 : sliderControl.visualPosition * parent.height
                                    width: sliderControl.horizontal ? sliderControl.position * parent.width : 6
                                    height: sliderControl.horizontal ? 6 : sliderControl.position * parent.height

                                    radius: 3
                                    color: sliderControl.palette.midlight
                                }
                            }
                        }

                        RowLayout {
                            width: parent.width
                            Text {
                                Layout.alignment: Qt.AlignLeft
                                Layout.leftMargin: 5
                                font.pixelSize: 12
                                text: qsTr("2:35")
                                color: Style.alphaColor("#FFFFFF",0.6)
                            }

                            Item{ Layout.fillWidth: true }

                            Text {
                                Layout.alignment: Qt.AlignRight
                                Layout.rightMargin: 5
                                font.pixelSize: 12
                                text: qsTr("3:54")
                                color: Style.alphaColor("#FFFFFF",0.6)
                            }
                        }
                    }
                    Item{ Layout.fillHeight: true }
                }
            }
            ColumnLayout  {
                spacing: 10
                RowLayout {
                    spacing: 20
                    LabDelegate {
                        showInfo: true
                        icon: "\uf0eb"
                        title: "Study Lamp"
                        isAvaible: false
                        isOpen: false
                    }
                    LabDelegate {
                        showInfo: false
                        icon: "\uf0eb"
                        title: "Bedroom Lamp"
                        isAvaible: true
                        isOpen: false
                    }
                }
                RowLayout {
                    spacing: 20
                    LabDelegate {
                        showInfo: false
                        icon: "\uf0eb"
                        title: "kitchen Lamp"
                        isAvaible: true
                        isOpen: false
                    }
                    LabDelegate {
                        showInfo: false
                        icon: "\uf0eb"
                        title: "Bathroom Lamp"
                        isAvaible: true
                        isOpen: false
                    }
                }
                RowLayout {
                    spacing: 20
                    LabDelegate {
                        showInfo: false
                        icon: "\uf0eb"
                        title: "Table Lamp"
                        isAvaible: true
                        isOpen: true
                    }
                    LabDelegate {
                        showInfo: false
                        icon: "\uf03d"
                        title: "Camera"
                        isAvaible: true
                        isOpen: false
                    }
                }
            }
        }
    }

    StackLayout {
        width: parent.width * 0.5
        height: parent.height
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 10

        StackLayout {
            width: parent.width
            currentIndex: bar.currentIndex
            Item {
                id: homeTab
                ColumnLayout {
                    width: parent.width
                    height: parent.height
                    spacing: 20

                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        source: "qrc:/assets/new icons/AC.png"
                    }

                    Item { Layout.fillHeight: true }

                    CircularSlider {
                        id: circularSlider
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        width: 350
                        height: 350

                        trackWidth: sliderProperties.trackWidth
                        progressWidth: sliderProperties.progressWidth
                        handleWidth: sliderProperties.handleWidth
                        handleHeight: sliderProperties.handleHeight
                        handleRadius: sliderProperties.handleRadius
                        handleVerticalOffset: sliderProperties.handleVerticalOffset

                        startAngle: sliderProperties.startAngle
                        endAngle: sliderProperties.endAngle
                        minValue: sliderProperties.minValue
                        maxValue: sliderProperties.maxValue
                        snap: sliderProperties.snap
                        stepSize: 1
                        value: 23

                        handleColor: sliderProperties.handleColor
                        trackColor: sliderProperties.trackColor
                        progressColor: sliderProperties.progressColor

                        hideTrack: sliderProperties.hideTrack
                        hideProgress: sliderProperties.hideProgress

                        ColumnLayout {
                            id: infoLabel
                            anchors.verticalCenterOffset: -20
                            anchors.centerIn: parent
                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                font.pixelSize: 18
                                text: qsTr("COOL")
                                color: Style.alphaColor(Style.black,0.4)
                            }
                            RowLayout {
                                spacing: 20
                                Layout.alignment: Qt.AlignHCenter
                                OutlinedLabel {
                                    Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                                    textIcon: "\uf068"
                                    iconSize: 18
                                    radius: 24
                                    color: Style.black
                                    backgroundColor: Style.white
                                    borderColor: backgroundColor
                                    implicitHeight: 45
                                    implicitWidth: 45
                                }
                                ColumnLayout {
                                    Layout.alignment: Qt.AlignHCenter
                                    Layout.fillHeight: false
                                    spacing: 0
                                    Text {
                                        Layout.alignment: Qt.AlignHCenter
                                        font.pixelSize: 26
                                        font.bold: Font.Bold
                                        font.weight: Font.Medium
                                        text: Number(circularSlider.value).toFixed()
                                        rotation: -circularSlider.rotation
                                        color: Style.black
                                    }
                                    Text {
                                        Layout.alignment: Qt.AlignHCenter
                                        font.pixelSize: 18
                                        text: qsTr("°C")
                                        color: Style.alphaColor(Style.black,0.4)
                                    }
                                }

                                OutlinedLabel {
                                    Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                                    textIcon: "\uf067"
                                    iconSize: 18
                                    radius: 24
                                    color: Style.black
                                    backgroundColor: Style.white
                                    borderColor: backgroundColor
                                    implicitHeight: 45
                                    implicitWidth: 45
                                }
                            }
                        }


                        OutlinedLabel {
                            anchors.top: infoLabel.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.topMargin: 10
                            textIcon: qsTr("Auto Adjust")
                            iconSize: 16
                            color: Style.blue
                            implicitHeight: 38
                            implicitWidth: 120
                            appicon: false
                            backgroundColor: Style.alphaColor(Style.blue,0.1)
                        }


                        Text {
                            font.pixelSize: 18
                            text: qsTr("16°C")
                            color: Style.alphaColor(Style.black,0.4)

                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                        }

                        Text {
                            font.pixelSize: 18
                            text: qsTr("32°C")
                            color: Style.alphaColor(Style.black,0.4)
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                        }
                    }
//                    PrefsLabelSelector {
//                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
//                        lableList: ["\uf2dc","\uf043","\uf185","\uf544"]
//                    }

                    CustumPrefsLabelSelector {
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        lableList: ["qrc:/assets/icons/sun.svg","qrc:/assets/icons/flash.svg","qrc:/assets/icons/wind.svg","qrc:/assets/icons/drop.svg","qrc:/assets/icons/moon.svg"]
                    }

                    RowLayout {
                        Layout.preferredWidth: parent.width * 0.7
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        spacing: 30

                        Item { Layout.fillWidth: true }

                        PrefsTabButton {
                            title: "Rotate"
                            textIcon: "\uf2f1"
                            iconColor: Style.blue
                        }

                        PrefsTabButton {
                            title: "Time"
                            textIcon: "\uf017"
                            iconColor: Style.blueGreen
                        }

                        PrefsTabButton {
                            title: "Scenes"
                            textIcon: "\uf008"
                            iconColor: Style.green
                        }

                        PrefsTabButton {
                            title: "Morning"
                            textIcon: "\uf185"
                            iconColor: Style.yellowLight
                        }

                        Item { Layout.fillWidth: true }
                    }


                    Item { Layout.fillHeight: true }

                    PrefsLabelSelector {
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                        lableList: ["\uf011","\uf013"]
                    }

                    Item { Layout.preferredHeight: 50 }
                }
            }
            Item {
                id: discoverTab
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 20

                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        source: "qrc:/assets/new icons/AC.png"
                    }

                    ShadowRectangle {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: parent.width * 0.6
                        Layout.preferredHeight: 250
                        Layout.topMargin: 30
                        PrefsSwitch {
                            anchors.right: parent.right
                            anchors.rightMargin: 20
                            anchors.top: parent.top
                            anchors.topMargin: 20
                            checked: true
                        }

                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.top: parent.top
                            anchors.topMargin: 20
                            font.family: "Inter"
                            font.bold: Font.DemiBold
                            font.pixelSize: 21
                            color: "#505050"
                            text: qsTr("Air Conditioner")
                        }

                        Text {
                            id: temparature
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: -40
                            font.family: "Inter"
                            font.bold: Font.DemiBold
                            font.pixelSize: 40
                            text: sliderCon.value.toFixed() + "°C"
                            color: "#505050"
                        }

                        PrefsSlider {
                            id: sliderCon
                            anchors.top: temparature.bottom
                            anchors.topMargin: 10
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.8
                            from: 16
                            to: 32
                            value: 24
                        }
                        RowLayout {
                            anchors.top: sliderCon.bottom
                            anchors.topMargin: 5
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.8

                            Text {
                                Layout.alignment: Qt.AlignLeft
                                font.family: "Inter"
                                font.bold: Font.DemiBold
                                font.pixelSize: 12
                                text: "16°C"
                                color: "#7A7A7A"
                            }

                            Repeater {
                                Layout.alignment: Qt.AlignHCenter
                                model: 7
                                delegate: Rectangle {
                                    width: 2
                                    height: index %2 == 0 ? 4 : 8
                                    color: "#7A7A7A"
                                }
                            }

                            Text {
                                Layout.alignment: Qt.AlignRight
                                font.family: "Inter"
                                font.bold: Font.DemiBold
                                font.pixelSize: 12
                                text: "32°C"
                                color: "#7A7A7A"
                            }
                        }

                        RowLayout {
                            width: parent.width
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                            anchors.horizontalCenter: parent.horizontalCenter
                            ShadowRectangle {
                                Layout.alignment: Qt.AlignHCenter
                                implicitHeight: 52
                                implicitWidth: 52
                                radius: implicitHeight / 2
                                ImageButton {
                                    anchors.centerIn: parent
                                    iconImage: "qrc:/assets/icons/sun.svg"
                                    iconWidth: 24
                                    iconHeight: 24
                                    color: Style.blue
                                    backgroundColor: Style.alphaColor(color,0.1)
                                }
                            }

                            ShadowRectangle {
                                Layout.alignment: Qt.AlignHCenter
                                implicitHeight: 52
                                implicitWidth: 52
                                radius: implicitHeight / 2
                                ImageButton {
                                    anchors.centerIn: parent
                                    iconImage: "qrc:/assets/icons/flash.svg"
                                    iconWidth: 24
                                    iconHeight: 24
                                    color: Style.red
                                    backgroundColor: Style.alphaColor(color,0.1)
                                }
                            }

                            ShadowRectangle {
                                Layout.alignment: Qt.AlignHCenter
                                implicitHeight: 52
                                implicitWidth: 52
                                radius: implicitHeight / 2
                                ImageButton {
                                    anchors.centerIn: parent
                                    iconImage: "qrc:/assets/icons/wind.svg"
                                    iconWidth: 24
                                    iconHeight: 24
                                    color: Style.blueGreen
                                    backgroundColor: Style.alphaColor(color,0.1)
                                }
                            }

                            ShadowRectangle {
                                Layout.alignment: Qt.AlignHCenter
                                implicitHeight: 52
                                implicitWidth: 52
                                radius: implicitHeight / 2
                                ImageButton {
                                    anchors.centerIn: parent
                                    iconImage: "qrc:/assets/icons/drop.svg"
                                    iconWidth: 24
                                    iconHeight: 24
                                    color: Style.green
                                    backgroundColor: Style.alphaColor(color,0.1)
                                }
                            }

                            ShadowRectangle {
                                Layout.alignment: Qt.AlignHCenter
                                implicitHeight: 52
                                implicitWidth: 52
                                radius: implicitHeight / 2
                                ImageButton {
                                    anchors.centerIn: parent
                                    iconImage: "qrc:/assets/icons/moon.svg"
                                    iconWidth: 24
                                    iconHeight: 24
                                    color: Style.yellowLight
                                    backgroundColor: Style.alphaColor(color,0.1)
                                }
                            }
                        }
                    }

                     Item { Layout.preferredHeight: 20 }

                    RowLayout {
                        Layout.preferredWidth: parent.width * 0.7
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        spacing: 30

                        Item { Layout.fillWidth: true }

                        PrefsTabButton {
                            title: "Rotate"
                            textIcon: "\uf2f1"
                            iconColor: Style.blue
                        }

                        PrefsTabButton {
                            title: "Time"
                            textIcon: "\uf017"
                            iconColor: Style.blueGreen
                        }

                        PrefsTabButton {
                            title: "Scenes"
                            textIcon: "\uf008"
                            iconColor: Style.green
                        }

                        PrefsTabButton {
                            title: "Morning"
                            textIcon: "\uf185"
                            iconColor: Style.yellowLight
                        }

                        Item { Layout.fillWidth: true }
                    }


                    Item { Layout.fillHeight: true }

                    PrefsLabelSelector {
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                        lableList: ["\uf011","\uf013"]
                    }

                    Item { Layout.preferredHeight: 50 }
                }
            }
            Item {
                id: devicesTab

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 10

                    Text {
                        font.pixelSize: 24
                        text: qsTr("My Devices: ")
                        color: Style.black
                        Layout.alignment: Qt.AlignLeft
                        Layout.leftMargin: 20
                    }

                    GridLayout {
                        rowSpacing: 20
                        columnSpacing: 20
                        uniformCellHeights: true
                        uniformCellWidths: true
                        layoutDirection: Qt.LeftToRight
                        columns: 4
                        DevicesTile{
                            on: false
                            icon: '\uf1eb'
                            iconColor: "#e7e7e9"
                            title: qsTr("Smart TV")
                            subTitle: qsTr("%1 for 3 hours").arg(on ? qsTr("Active") : qsTr("Inactive"))
                            tag: qsTr("Wi-Fi")
                            iconImage: "qrc:/assets/icons/monitor.svg"
                        }
                        DevicesTile{
                            on: false
                            icon: '\uf1eb'
                            iconColor: "#e7e7e9"
                            title: qsTr("Speaker")
                            subTitle: qsTr("%1 for 3 hours").arg(on ? qsTr("Active") : qsTr("Inactive"))
                            tag: qsTr("Wi-Fi")
                            iconImage: "qrc:/assets/icons/speaker.svg"
                        }
                        DevicesTile{
                            on: false
                            icon: '\uf1eb'
                            iconColor: "#e7e7e9"
                            title: qsTr("Router")
                            subTitle: qsTr("%1 for 3 hours").arg(on ? qsTr("Active") : qsTr("Inactive"))
                            tag: qsTr("Wi-Fi")
                            iconImage: "qrc:/assets/icons/keyboard-open.svg"
                        }
                        DevicesTile{
                            on: false
                            icon: '\uf1eb'
                            iconColor: "#e7e7e9"
                            title: qsTr("Wifi")
                            subTitle: qsTr("%1 for 3 hours").arg(on ? qsTr("Active") : qsTr("Inactive"))
                            tag: qsTr("Wi-Fi")
                            iconImage: "qrc:/assets/icons/airdrop.svg"
                        }
                        DevicesTile{
                            inActive: true
                            on: false
                            icon: '\uf1eb'
                            iconColor: "#e7e7e9"
                            title: qsTr("Heater")
                            subTitle: qsTr("%1 for 3 hours").arg(on ? qsTr("Active") : qsTr("Inactive"))
                            tag: qsTr("Wi-Fi")
                            iconImage: "qrc:/assets/icons/keyboard.svg"
                        }
                        DevicesTile{
                            on: false
                            icon: '\uf1eb'
                            iconColor: "#e7e7e9"
                            title: qsTr("Socket")
                            subTitle: qsTr("%1 for 3 hours").arg(on ? qsTr("Active") : qsTr("Inactive"))
                            tag: qsTr("Wi-Fi")
                            iconImage: "qrc:/assets/icons/electricity.svg"
                        }
                    }


                    Text {
                        font.pixelSize: 24
                        text: qsTr("Lights: ")
                        color: Style.black
                        Layout.alignment: Qt.AlignLeft
                        Layout.leftMargin: 20
                    }

                    GridLayout {
                        rowSpacing: 20
                        columnSpacing: 20
                        uniformCellHeights: true
                        uniformCellWidths: true
                        layoutDirection: Qt.LeftToRight
                        columns: 4
                        DevicesTile{
                            on: false
                            icon: '\uf1eb'
                            iconColor: "#e7e7e9"
                            title: qsTr("Light 1")
                            subTitle: qsTr("%1 for 1.5 hours").arg(on ? qsTr("Active") : qsTr("Inactive"))
                            tag: qsTr("Wi-Fi")
                            iconImage: "qrc:/assets/icons/sun 2.svg"
                        }
                        DevicesTile{
                            on: false
                            icon: '\uf1eb'
                            iconColor: "#e7e7e9"
                            title: qsTr("Light 2")
                            subTitle: qsTr("%1 for 2 hours").arg(on ? qsTr("Active") : qsTr("Inactive"))
                            tag: qsTr("Wi-Fi")
                            iconImage: "qrc:/assets/icons/sun 2.svg"
                        }
                        DevicesTile{
                            inActive: true
                            on: false
                            icon: '\uf1eb'
                            iconColor: "#e7e7e9"
                            title: qsTr("Light 3")
                            subTitle: qsTr("%1 for 1 hours").arg(on ? qsTr("Active") : qsTr("Inactive"))
                            tag: qsTr("Wi-Fi")
                            iconImage: "qrc:/assets/icons/sun 2.svg"
                        }
                        DevicesTile{
                            on: false
                            icon: '\uf1eb'
                            iconColor: "#e7e7e9"
                            title: qsTr("Light 4")
                            subTitle: qsTr("%1 for 4 hours").arg(on ? qsTr("Active") : qsTr("Inactive"))
                            tag: qsTr("Wi-Fi")
                            iconImage: "qrc:/assets/icons/sun 2.svg"
                        }
                        DevicesTile{
                            on: false
                            icon: '\uf1eb'
                            iconColor: "#e7e7e9"
                            title: qsTr("Light 5")
                            subTitle: qsTr("%1 for 1 hours").arg(on ? qsTr("Active") : qsTr("Inactive"))
                            tag: qsTr("Wi-Fi")
                            iconImage: "qrc:/assets/icons/sun 2.svg"
                        }
                        DevicesTile{
                            on: false
                            icon: '\uf1eb'
                            iconColor: "#e7e7e9"
                            title: qsTr("Light 6")
                            subTitle: qsTr("%1 for 3 hours").arg(on ? qsTr("Active") : qsTr("Inactive"))
                            tag: qsTr("Wi-Fi")
                            iconImage: "qrc:/assets/icons/sun 2.svg"
                        }
                    }
                }
            }
            Item {
                id: lightsTab


            }
            Item {
                id: activityTab


            }
        }

    }

    RightDrawer {
        id: com_rightDrawer
    }

    BottomDrawer {
        id: com_bottomDrawer
    }
}
