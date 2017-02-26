#include <QBrush>

#include "polygon.h"

Polygon::Polygon(QQuickItem* parent)
    : QQuickPaintedItem(parent)
    , mColor("#ffffff")
{
}

void Polygon::paint(QPainter* painter)
{
    QBrush brush(mColor);
    painter->setBrush(brush);
    painter->setPen(Qt::NoPen);
    painter->setRenderHint(QPainter::Antialiasing);

    QVector<QPoint> pointsVector;
    for (QVariant vertice : mVertices)
    {
        pointsVector << vertice.toPoint();
    }
    QPolygon polygon(pointsVector);
    painter->drawConvexPolygon(polygon);
}

void Polygon::setColor(const QColor& color)
{
    if (color != mColor)
    {
        mColor = color;
        update();
        emit colorChanged();
    }
}

void Polygon::setVertices(const QVariantList& vertices)
{
    if (vertices != mVertices)
    {
        mVertices = vertices;
        update();
        emit verticesChanged();
    }
}
