package ohos_app_cangjie_entry.components.charts

import std.collection.ArrayList
import std.convert.*
import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.theme.AppTheme

public class LineChartPoint {
    public var id: String = ""
    public var label: String = ""
    public var total: Float64 = 0.0

    public init() {}

    public init(id!: String, label!: String, total!: Float64) {
        this.id = id
        this.label = label
        this.total = total
    }
}

public class LineChartSegment {
    public var id: String = ""
    public var startX: Float64 = 0.0
    public var startY: Float64 = 0.0
    public var endX: Float64 = 0.0
    public var endY: Float64 = 0.0

    public init() {}

    public init(id!: String, startX!: Float64, startY!: Float64, endX!: Float64, endY!: Float64) {
        this.id = id
        this.startX = startX
        this.startY = startY
        this.endX = endX
        this.endY = endY
    }
}

public class GridLinePoint {
    public var id: String = ""
    public var y: Float64 = 0.0

    public init() {}

    public init(id!: String, y!: Float64) {
        this.id = id
        this.y = y
    }
}

@Component
public class LineChartCard {
    @Prop var title: String
    @Prop var subtitle: String
    @Prop var pointLabelsKey: String
    @Prop var pointTotalsKey: String
    @Prop var periodKey: String

    private func chartWidth(): Float64 { 320.0 }
    private func chartHeight(): Float64 { 160.0 }
    private func pointSize(): Float64 { 10.0 }
    private func horizontalPadding(): Float64 { 20.0 }
    private func verticalPadding(): Float64 { 16.0 }
    private func drawableWidth(): Float64 { this.chartWidth() - this.horizontalPadding() * 2.0 }
    private func drawableHeight(): Float64 { this.chartHeight() - this.verticalPadding() * 2.0 }

    private func axisLabelWidth(): Float64 {
        this.horizontalPadding() * 2.0
    }

    private func hasVisibleLabels(): Bool {
        let points = this.points()
        var index: Int64 = 0
        while (index < points.size) {
            if (points[index].label != "" && points[index].label != " ") {
                return true
            }
            index += 1
        }
        false
    }

    private func safeParseTotal(text: String): Float64 {
        if (text == "" || text == " ") {
            return 0.0
        }
        Float64.parse(text)
    }

    private func points(): ArrayList<LineChartPoint> {
        let items = ArrayList<LineChartPoint>()
        let labels = this.pointLabelsKey.split(",")
        let totals = this.pointTotalsKey.split(",")
        let count = if (labels.size < totals.size) { labels.size } else { totals.size }

        var index: Int64 = 0
        while (index < count) {
            items.add(LineChartPoint(
                id: "${this.periodKey}-point_${index}",
                label: labels[index],
                total: this.safeParseTotal(totals[index])
            ))
            index += 1
        }

        items
    }

    private func maxTotal(): Float64 {
        var maxValue: Float64 = 0.0
        for (point in this.points()) {
            if (point.total > maxValue) {
                maxValue = point.total
            }
        }
        maxValue
    }

    private func stepWidth(): Float64 {
        let points = this.points()
        if (points.size <= 1) {
            return this.drawableWidth()
        }
        this.drawableWidth() / Float64(points.size - 1)
    }

    private func pointCenterX(index: Int64): Float64 {
        this.horizontalPadding() + this.stepWidth() * Float64(index)
    }

    private func pointCenterY(total: Float64): Float64 {
        let maxValue = this.maxTotal()
        if (maxValue <= 0.0) {
            return this.verticalPadding() + this.drawableHeight()
        }
        this.verticalPadding() + this.drawableHeight() * (1.0 - (total / maxValue))
    }

    private func pointX(index: Int64): Float64 {
        this.pointCenterX(index)
    }

    private func pointY(index: Int64): Float64 {
        let points = this.points()
        this.pointCenterY(points[index].total)
    }

    private func segments(): ArrayList<LineChartSegment> {
        let items = ArrayList<LineChartSegment>()
        let points = this.points()

        var index: Int64 = 0
        while (index + 1 < points.size) {
            let nextIndex = index + 1
            items.add(LineChartSegment(
                id: "${this.periodKey}-segment_${index}",
                startX: this.pointX(index),
                startY: this.pointY(index),
                endX: this.pointX(nextIndex),
                endY: this.pointY(nextIndex)
            ))
            index += 1
        }

        items
    }

    private func gridLines(): ArrayList<GridLinePoint> {
        let items = ArrayList<GridLinePoint>()

        var index: Int64 = 0
        while (index <= 4) {
            let ratio = Float64(index) / 4.0
            items.add(GridLinePoint(
                id: "${this.periodKey}-grid_${index}",
                y: this.verticalPadding() + this.drawableHeight() * ratio
            ))
            index += 1
        }

        items
    }

    public func build(): Unit {
        Column(space: 0) {
            Stack() {
                ForEach(this.gridLines(), itemGeneratorFunc: { gridLine: GridLinePoint, _: Int64 =>
                    Line()
                        .width(this.chartWidth())
                        .height(this.chartHeight())
                        .startPoint((this.horizontalPadding(), gridLine.y))
                        .endPoint((this.chartWidth() - this.horizontalPadding(), gridLine.y))
                        .stroke(AppTheme.surfaceAccentStrong())
                        .strokeWidth(1)
                }, keyGeneratorFunc: { gridLine: GridLinePoint, _: Int64 =>
                    gridLine.id
                })

                ForEach(this.segments(), itemGeneratorFunc: { segment: LineChartSegment, _: Int64 =>
                    Line()
                        .width(this.chartWidth())
                        .height(this.chartHeight())
                        .startPoint((segment.startX, segment.startY))
                        .endPoint((segment.endX, segment.endY))
                        .stroke(AppTheme.brandPrimary())
                        .strokeWidth(3)
                        .strokeLineCap(LineCapStyle.Round)
                }, keyGeneratorFunc: { segment: LineChartSegment, _: Int64 =>
                    segment.id
                })
            }
            .width(this.chartWidth())
            .height(this.chartHeight())

            if (this.hasVisibleLabels()) {
                if (this.points().size <= 7) {
                    Row() {
                        ForEach(this.points(), itemGeneratorFunc: { point: LineChartPoint, _: Int64 =>
                            Text(point.label)
                                .fontSize(10)
                                .fontColor(AppTheme.textSecondary())
                                .textAlign(TextAlign.Center)
                                .width(this.axisLabelWidth())
                        }, keyGeneratorFunc: { point: LineChartPoint, _: Int64 =>
                            point.id
                        })
                    }
                    .width(this.chartWidth())
                    .justifyContent(FlexAlign.SpaceBetween)
                    .margin(top: 8)
                } else {
                    Row() {
                        ForEach(this.points(), itemGeneratorFunc: { point: LineChartPoint, _: Int64 =>
                            Text(point.label)
                                .fontSize(if (this.points().size > 20) { 8 } else { 9 })
                                .fontColor(AppTheme.textSecondary())
                                .textAlign(TextAlign.Center)
                                .layoutWeight(1)
                        }, keyGeneratorFunc: { point: LineChartPoint, _: Int64 =>
                            point.id
                        })
                    }
                    .width(this.chartWidth())
                    .margin(top: 8)
                }
            }
        }
        .padding(left: 0, right: 0, top: 0, bottom: 0)
        .width(100.percent)
        .alignItems(HorizontalAlign.Center)
    }
}
