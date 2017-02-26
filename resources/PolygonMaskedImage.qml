import QtGraphicalEffects 1.0
import QtQuick 2.7

import SMExtensions 1.0

Item {
    id: polygonMaskedImage

    property url imageSource
    property var maskVertices
    property bool cached: true

    Image {
        id: image

        anchors.fill: parent

        source: polygonMaskedImage.imageSource
        visible: false
    }

    Polygon {
        id: mask

        anchors.fill: parent

        vertices: polygonMaskedImage.maskVertices
        visible: false
    }

    ShaderEffectSource {
        id: cachedItem

        anchors.fill: parent

        hideSource: visible
        live: true
        smooth: true
        sourceItem: shaderItem
        visible: polygonMaskedImage.cached
    }

    ShaderEffect {
        id: shaderItem

        property Image source: image
        property Polygon mask: mask

        anchors.fill: parent

        fragmentShader: "
            varying highp vec2 qt_TexCoord0;
            uniform highp float qt_Opacity;
            uniform lowp sampler2D source;
            uniform lowp sampler2D mask;

            void main() {
                gl_FragColor = texture2D(source, qt_TexCoord0.xy) *
                    texture2D(mask, qt_TexCoord0.xy).a *
                    qt_Opacity;
            }
        "
    }
}
