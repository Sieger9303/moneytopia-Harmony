package ohos_app_cangjie_entry.components.charts

import std.collection.ArrayList
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
    @Prop var points: ArrayList<LineChartPoint>

    private func chartWidth(): Float64 { 320.0 }
    private func chartHeight(): Float64 { 160.0 }
    private func pointSize(): Float64 { 10.0 }
    private func horizontalPadding(): Float64 { 20.0 }
    private func verticalPadding(): Float64 { 16.0 }
    private func drawableWidth(): Float64 { this.chartWidth() - this.horizontalPadding() * 2.0 }
    private func drawableHeight(): Float64 { this.chartHeight() - this.verticalPadding() * 2.0 }

    private func hasVisibleLabels(): Bool {
        for (point in this.points) {
            if (point.label != "") {
                return true
            }
        }
        false
    }

    private func maxTotal(): Float64 {
        var maxValue: Float64 = 0.0
        for (point in this.points) {
            if (point.total > maxValue) {
                maxValue = point.total
            }
        }
        maxValue
    }

    private func stepWidth(): Float64 {
        if (this.points.size <= 1) {
            return this.drawableWidth()
        }
        this.drawableWidth() / Float64(this.points.size - 1)
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
        this.pointCenterY(this.points[index].total)
    }

    private func segments(): ArrayList<LineChartSegment> {
        let items = ArrayList<LineChartSegment>()
        if (this.points.size <= 1) {
            return items
        }
        for (index in 0..this.points.size - 2) {
            let nextIndex = index + 1
            items.add(LineChartSegment(
                id: "segment_${index}",
                startX: this.pointX(index),
                startY: this.pointY(index),
                endX: this.pointX(nextIndex),
                endY: this.pointY(nextIndex)
            ))
        }
        items
    }

    private func gridLines(): ArrayList<GridLinePoint> {
        let items = ArrayList<GridLinePoint>()
        for (index in 0..4) {
            let ratio = Float64(index) / 4.0
            items.add(GridLinePoint(
                id: "grid_${index}",
                y: this.verticalPadding() + this.drawableHeight() * ratio
            ))
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
                }, keyGeneratorFunc: { gridLine: GridLinePoint, _: Int64 => gridLine.id })

                ForEach(this.segments(), itemGeneratorFunc: { segment: LineChartSegment, _: Int64 =>
                    Line()
                        .width(this.chartWidth())
                        .height(this.chartHeight())
                        .startPoint((segment.startX, segment.startY))
                        .endPoint((segment.endX, segment.endY))
                        .stroke(AppTheme.brandPrimary())
                        .strokeWidth(3)
                        .strokeLineCap(LineCapStyle.Round)
                }, keyGeneratorFunc: { segment: LineChartSegment, _: Int64 => segment.id })
            }
            .width(this.chartWidth())
            .height(this.chartHeight())

            if (this.hasVisibleLabels()) {
                Row() {
                    ForEach(this.points, itemGeneratorFunc: { point: LineChartPoint, _: Int64 =>
                        Text(point.label)
                            .fontSize(10)
                            .fontColor(AppTheme.textSecondary())
                            .layoutWeight(1)
                    }, keyGeneratorFunc: { point: LineChartPoint, _: Int64 => point.id })
                }
                .width(100.percent)
                .margin(top: 8)
            }
        }
        .padding(left: 0, right: 0, top: 0, bottom: 0)
        .width(100.percent)
    }
}
