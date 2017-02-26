#ifndef POLYGON_H
#define POLYGON_H

#include <QQuickPaintedItem>
#include <QPainter>

class Polygon : public QQuickPaintedItem
{
    Q_OBJECT

    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(QVariantList vertices READ vertices WRITE setVertices NOTIFY verticesChanged)

public:
    Polygon(QQuickItem* parent = 0);

    virtual void paint(QPainter* painter) override;

    QColor color() const { return mColor; }
    void setColor(const QColor& color);

    QVariantList vertices() const { return mVertices; }
    void setVertices(const QVariantList& vertices);

private:
    QColor mColor;
    QVariantList mVertices;

signals:
    void colorChanged();
    void verticesChanged();
};

#endif // POLYGON_H
