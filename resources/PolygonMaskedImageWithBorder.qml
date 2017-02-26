import QtQuick 2.7

import SMExtensions 1.0

Item {
    id: polygonMaskedImageWithBorder

    property alias imageSource: polygonMaskedImage.imageSource
    property alias maskVertices: polygonMaskedImage.maskVertices
    property alias cached: polygonMaskedImage.cached

    property var borderVertices: []
    property color borderColor: "#ffffff"

    Polygon {
        id: borderPolygon

        anchors.fill: parent

        color: polygonMaskedImageWithBorder.borderColor
        vertices: polygonMaskedImageWithBorder.borderVertices
    }

    PolygonMaskedImage {
        id: polygonMaskedImage

        anchors.fill: parent
    }
}
