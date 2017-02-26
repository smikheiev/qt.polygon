import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import QtQuick 2.7

Window {
    id: rootWindow

    maximumWidth: 800
    maximumHeight: 650
    minimumWidth: maximumWidth
    minimumHeight: maximumHeight
    width: minimumWidth
    height: minimumHeight

    visible: true
    title: qsTr("Polygon masked image with border")

    property var images: ["kingfisher.jpg", "owl.jpg"]
    property int imageIndex: 0

    property int minContentWidth: 100
    property int maxContentWidth: width / 2
    property int minContentHeight: 100
    property int maxContentHeight: height

    property var maskVertices: []
    property var borderVertices: []

    Item {
        id: controls

        width: parent.width / 2 - 30
        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }

        ColumnLayout {
            anchors.fill: parent
            spacing: 10

            Row {
                id: selectImageButtonsContainer

                Layout.fillWidth: true

                RadioButton {
                    id: kingfisherButton

                    text: "Kingfisher"
                    checked: imageIndex == 0
                    onClicked: imageIndex = 0
                }
                RadioButton {
                    id: owlButton

                    text: "Owl"
                    checked: imageIndex == 1
                    onClicked: imageIndex = 1
                }
            }

            CheckBox {
                id: showBackgroundCheckbox

                Layout.fillWidth: true

                text: "Show background"
                checked: true
            }

            Column {
                id: contentSizeSlidersContainer

                Layout.fillWidth: true

                Label {
                    width: parent.width
                    text: "Content size:"
                }
                RowLayout {
                    width: parent.width

                    Slider {
                        id: contentWidthSlider

                        property int currentValue: value

                        Layout.fillWidth: true

                        from: minContentWidth
                        to: maxContentWidth
                        value: to
                        stepSize: 1

                        onPositionChanged: {
                            currentValue = from + (to - from) * position;
                        }

                        Text {
                            anchors.centerIn: parent

                            text: contentWidthSlider.currentValue
                            font.pixelSize: parent.height * 0.5
                        }
                    }
                    Slider {
                        id: contentHeightSlider

                        property int currentValue: value

                        Layout.fillWidth: true

                        from: minContentHeight
                        to: maxContentHeight
                        value: to
                        stepSize: 1

                        onPositionChanged: {
                            currentValue = from + (to - from) * position;
                        }

                        Text {
                            anchors.centerIn: parent

                            text: contentHeightSlider.currentValue
                            font.pixelSize: parent.height * 0.5
                        }
                    }
                }
            }

            ColumnLayout {
                id: maskVerticesSlidersContainer

                Layout.fillWidth: true
                Layout.fillHeight: true

                Label {
                    Layout.fillWidth: true
                    text: "Mask vertices:"
                }
                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    clip: true
                    model: maskVertices

                    delegate: RowLayout {
                        width: parent.width

                        Slider {
                            id: maskVerticeXSlider

                            property int currentValue: value

                            Layout.fillWidth: true

                            from: 0
                            to: polygonMaskedImageWithBorder.width
                            value: modelData.x
                            stepSize: 1

                            onPositionChanged: {
                                currentValue = from + (to - from) * position;
                                maskVertices[index].x = currentValue;
                                polygonMaskedImageWithBorder.maskVertices = maskVertices;
                            }

                            Text {
                                anchors.centerIn: parent

                                text: maskVerticeXSlider.currentValue
                                font.pixelSize: parent.height * 0.5
                            }
                        }
                        Slider {
                            id: maskVerticeYSlider

                            property int currentValue: value

                            Layout.fillWidth: true

                            from: 0
                            to: polygonMaskedImageWithBorder.height
                            value: modelData.y
                            stepSize: 1

                            onPositionChanged: {
                                currentValue = from + (to - from) * position;
                                maskVertices[index].y = currentValue;
                                polygonMaskedImageWithBorder.maskVertices = maskVertices;
                            }

                            Text {
                                anchors.centerIn: parent

                                text: maskVerticeYSlider.currentValue
                                font.pixelSize: parent.height * 0.5
                            }
                        }
                    }
                }
            }

            ColumnLayout {
                id: borderVerticesSlidersContainer

                Layout.fillWidth: true
                Layout.fillHeight: true

                Label {
                    Layout.fillWidth: true
                    text: "Border vertices:"
                }
                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    clip: true
                    model: borderVertices

                    delegate: RowLayout {
                        width: parent.width

                        Slider {
                            id: borderVerticeXSlider

                            property int currentValue: value

                            Layout.fillWidth: true

                            from: 0
                            to: polygonMaskedImageWithBorder.width
                            value: modelData.x
                            stepSize: 1

                            onPositionChanged: {
                                currentValue = from + (to - from) * position;
                                borderVertices[index].x = currentValue;
                                polygonMaskedImageWithBorder.borderVertices = borderVertices;
                            }

                            Text {
                                anchors.centerIn: parent

                                text: borderVerticeXSlider.currentValue
                                font.pixelSize: parent.height * 0.5
                            }
                        }
                        Slider {
                            id: borderVerticeYSlider

                            property int currentValue: value

                            Layout.fillWidth: true

                            from: 0
                            to: polygonMaskedImageWithBorder.height
                            value: modelData.y
                            stepSize: 1

                            onPositionChanged: {
                                currentValue = from + (to - from) * position;
                                borderVertices[index].y = currentValue;
                                polygonMaskedImageWithBorder.borderVertices = borderVertices;
                            }

                            Text {
                                anchors.centerIn: parent

                                text: borderVerticeYSlider.currentValue
                                font.pixelSize: parent.height * 0.5
                            }
                        }
                    }
                }
            }
        }
    }

    Item {
        id: background

        width: polygonMaskedImageWithBorder.width
        height: polygonMaskedImageWithBorder.height

        visible: showBackgroundCheckbox.checked

        Rectangle {
            anchors.fill: parent
            color: "Green"
        }
    }

    PolygonMaskedImageWithBorder {
        id: polygonMaskedImageWithBorder

        width: contentWidthSlider.currentValue
        height: contentHeightSlider.currentValue

        imageSource: imageUrl()
        maskVertices: rootWindow.maskVertices
        borderVertices: rootWindow.borderVertices
        borderColor: "red"
        cached: true
    }

    function imageUrl() {
        if (images.length > 0 && imageIndex >= 0 && imageIndex < images.length) {
            return "qrc:/image/" + images[imageIndex];
        }

        return "";
    }

    function init() {
        var maskVertices = [
            Qt.point(40, 30),
            Qt.point(polygonMaskedImageWithBorder.width - 70, 15),
            Qt.point(polygonMaskedImageWithBorder.width - 5, polygonMaskedImageWithBorder.height - 150),
            Qt.point(polygonMaskedImageWithBorder.width - 50, polygonMaskedImageWithBorder.height - 10),
            Qt.point(10, polygonMaskedImageWithBorder.height - 80)
        ];
        rootWindow.maskVertices = maskVertices;
        polygonMaskedImageWithBorder.maskVertices = rootWindow.maskVertices;

        var borderVertices = [
            Qt.point(20, 20),
            Qt.point(polygonMaskedImageWithBorder.width - 60, 0),
            Qt.point(polygonMaskedImageWithBorder.width, polygonMaskedImageWithBorder.height - 150),
            Qt.point(polygonMaskedImageWithBorder.width - 40, polygonMaskedImageWithBorder.height),
            Qt.point(0, polygonMaskedImageWithBorder.height - 65)
        ];
        rootWindow.borderVertices = borderVertices;
        polygonMaskedImageWithBorder.borderVertices = rootWindow.borderVertices;
    }

    Component.onCompleted: {
        init();
    }
}
