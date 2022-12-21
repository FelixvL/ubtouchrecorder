/*
 * Copyright (C) 2022  TSFL
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * mrs1 is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import QtMultimedia 5.11

import Example 1.0
import AudioRecorder 1.0
import Qt.labs.folderlistmodel 2.1

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'mrs1.mrs1'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('MemoRecorderSetup1')
        }
        MediaPlayer {
            id: player
        }
        Recorder{
            id: recorder
        }
        Audio{
            id: audioPlayer
        }
        FolderListModel{
            id: fileList
            folder: "file://" + recorder.filePath
        }
        ListView{
            id: listFiles
            model: fileList
            delegate: ListItem{
                height: units.gu(3)
                Text {
                    text: ">>>"+model.fileName
                    anchors {
                        left: parent.left
                        leftMargin: units.gu(2)
                        verticalCenter: parent.verticalCenter
                    }
		        }
                onClicked: {
                    audioPlayer.source = "file://" + recorder.filePath + "/" + model.fileName
                    audioPlayer.play()
                }
            }
            height: units.gu(50)      
            anchors{
                top: header.bottom
                left: parent.left
                right: parent.right
                
            }          
        }

        ColumnLayout {
            spacing: units.gu(2)
            anchors {
                margins: units.gu(2)
                top: listFiles.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            Item {
                Layout.fillHeight: true
            }

            Label {
                id: label
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Press the button below and check the logs!')
            }
            Button {
                property var counter : 0
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Start Recording!')
                onClicked: {
                    Example.speak()
                    console.log(counter++)
                    var a = recorder.supportedAudioCodecs()
                    console.log(a)
                    var b = recorder.audioInputDevices()
                    console.log(b)
                    console.log("============")
                    recorder.record()
                    console.log("file://" + recorder.filePath)
                }
            }
            Button {
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Stop !!!')
                onClicked: {
                    console.log("We gaan stoppen")
                    recorder.stop()
                }
            }
            Rectangle {
                id: pressRecordMA
                color:'red' 
                height: units.gu(7)
                width: units.gu(12)

                Layout.alignment: Qt.AlignHCenter
                MouseArea{
                    anchors.fill: parent
                    onPressed: {
                        pressRecordMA.color = 'green'
                        console.log("Onpressed in pressrecording");
                        recorder.record()
                    }
                    onReleased:{
                        pauseDelay.start()
                    }
                }
                Timer{
                    id: pauseDelay
                    interval: 500
                    running: false
                    repeat: false
                    onTriggered:{
                        pressRecordMA.color = 'red'
                        console.log("OnReleased in pressrecording");
                        recorder.pause()
                    }
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}
