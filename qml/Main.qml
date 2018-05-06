import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'primenumbers.christianpauly'
    automaticOrientation: false

    property int currentNum: 1
    property int score: 0
    property int max: 100

    function check( choice ) {
        var remainingTime = progressBar.value
        progressBar.value = 0
        var rightAnswer = isPrime ( currentNum )

        if ( rightAnswer === choice ) {
            choiceCorrectLabel.color = UbuntuColors.green
            choiceCorrectLabel.text = i18n.tr ( 'Correct! 😉')
            if ( rightAnswer ) score += 10
            else score += 5
            score += remainingTime * 5
            if ( currentNum >= max ) {
                currentNum = Math.floor ( ( Math.random () * max ) + 1 )
            }
            else {
                currentNum++
            }
        }
        else {
            choiceCorrectLabel.color = UbuntuColors.red
            choiceCorrectLabel.text = i18n.tr ( 'Failed! 😩 Try again ...')
            score = 0
            currentNum = 1
        }

        number.text = currentNum
        scoreLabel.text = i18n.tr ( 'Your score: ' ) + score
    }

    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: {
            if ( progressBar.value >= 5 ) {
                check ( !isPrime ( currentNum ) )
            }
            else {
                progressBar.value++
            }
        }
    }


    function isPrime(num) {
        for(var i = 2; i < num; i++) {
            if(num % i === 0) return false
        }
        return num !== 1;
    }

    width: units.gu(45)
    height: units.gu(75)

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('Prime numbers')
        }

        Rectangle {
            id: numberRect
            width: parent.height / 3
            height: parent.height / 3
            radius: parent.width
            anchors.top: header.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10
            color: UbuntuColors.silk

            Label {
                id: number
                text: "1"
                Text {
                    font.bold: true
                }
                textSize: Label.XLarge
                anchors.centerIn: parent
            }

            Label {
                id: choiceCorrectLabel
                anchors.top: number.bottom
                anchors.horizontalCenter: number.horizontalCenter
                color: UbuntuColors.green
            }
        }

        Label {
            id: question
            text: i18n.tr('Is this a prime number?')
            textSize: Label.XLarge
            anchors.top: numberRect.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10
        }

        Label {
            id: scoreLabel
            text: i18n.tr('Your score: 0')
            textSize: Label.Large
            anchors.top: question.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10
        }

        ProgressBar {
            id: progressBar
            value: 0
            minimumValue: 0
            maximumValue: 5
            anchors.top: scoreLabel.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10
        }

        Button {
            id: noButton
            text: i18n.tr('No')
            color: UbuntuColors.red
            width: units.gu(15)
            height: units.gu(15)
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: units.gu(5)

            onClicked: {
                check ( false )
            }
        }


        Button {
            id: yesButton
            text: i18n.tr('Yes')
            color: UbuntuColors.green
            width: units.gu(15)
            height: units.gu(15)
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: units.gu(5)

            onClicked: {
                check ( true )
            }
        }
    }
}
