import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import QtMultimedia 5.11

import Example 1.0
import Qt.labs.folderlistmodel 2.1

Page {
    id: videoRecordPage
    anchors.fill: parent

    header: PageHeader {
        id: header
        title: i18n.tr('MemoRecorderSetup1')
    }
    FolderListModel{
        id: fileList
        folder: "file://"// + recorder.filePath
    }
    ListView{
        id: listFiles
        model: fileList
        delegate: ListItem{
            height: units.gu(3)
            Text {
                text: ">>>"//+model.fileName
                anchors {
                    left: parent.left
                    leftMargin: units.gu(2)
                    verticalCenter: parent.verticalCenter
                }
            }
            onClicked: {
                // audioPlayer.source = "file://" + recorder.filePath + "/" + model.fileName
                // audioPlayer.play()
                console.log("Klik op lijst")
            }
        }
        height: units.gu(50)      
        anchors{
            top: header.bottom
            left: parent.left
            right: parent.right
            
        }          
    }
    Camera{
        id: camera
      //  captureMode: Camera.CaptureVideo
//        videoRecorder.mediaContainer: 'mp4'
//        videoRecorder.outputLocation: "file://" + recorder.filePath 
        captureMode: Camera.CaptureStillImage
        position: Camera.BackFace

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
        Button {
            Layout.alignment: Qt.AlignHCenter
            text: i18n.tr('FOTO TEMP !!!')
            onClicked: {
                console.log("start recording")
               camera.imageCapture.captureToLocation("file://" + recorder.filePath) 
                camera.imageCapture.capture()
 //               camera.videoRecorder.record()
            }
        }
        Button {
            Layout.alignment: Qt.AlignHCenter
            text: i18n.tr('Stop !!!')
            onClicked: {
                console.log("stop recording");
                camera.videoRecorder.stop()
            }
        }
        Item {
            Layout.fillHeight: true
        }
    }
}
