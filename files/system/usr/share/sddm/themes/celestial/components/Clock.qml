import QtQuick

Item {
    id: clock
    property string backgroundSource: ""
    property color defaultHoursColor: "#D98A8A"
    property color defaultMinutesColor: "#FFB4AB"
    property string fontFamily: "VictorMono Nerd Font Mono"
    property color baseAccent: config.accentColor
    property color smartHoursColor: defaultHoursColor
    property color smartMinutesColor: defaultMinutesColor
    property string timeStr: Qt.formatTime(new Date(), "HHmm")
    onBaseAccentChanged: updateColors()
    Component.onCompleted: updateColors()
    Row {
        anchors.centerIn: parent
        spacing: 0 // Resetting horizontal gap
        Column {
            spacing: -130 // Ultra-compact vertical overlap
            Text {
                text: clock.timeStr.charAt(0)
                color: clock.smartHoursColor
                font.pixelSize: 200
                font.family: clock.fontFamily
                font.weight: Font.Medium
                width: 130 // Ensures digit 1 and digit 3 are centered in same space
                horizontalAlignment: Text.AlignHCenter
                antialiasing: true
            }
            Text {
                text: clock.timeStr.charAt(2)
                color: clock.smartMinutesColor
                font.pixelSize: 200
                font.family: clock.fontFamily
                font.weight: Font.Medium
                width: 130
                horizontalAlignment: Text.AlignHCenter
                antialiasing: true
            }
        }
        Column {
            spacing: -130
            Text {
                text: clock.timeStr.charAt(1)
                color: clock.smartHoursColor
                font.pixelSize: 200
                font.family: clock.fontFamily
                font.weight: Font.Medium
                width: 130
                horizontalAlignment: Text.AlignHCenter
                antialiasing: true
            }
            Text {
                text: clock.timeStr.charAt(3)
                color: clock.smartMinutesColor
                font.pixelSize: 200
                font.family: clock.fontFamily
                font.weight: Font.Medium
                width: 130
                horizontalAlignment: Text.AlignHCenter
                antialiasing: true
            }
        }
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            clock.timeStr = Qt.formatTime(new Date(), "HHmm")
        }
    }
}
