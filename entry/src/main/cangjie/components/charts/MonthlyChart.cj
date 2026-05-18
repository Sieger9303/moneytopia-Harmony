package ohos_app_cangjie_entry.components.charts

import std.collection.ArrayList
import std.time.*
import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.data.model.Expense
import ohos_app_cangjie_entry.theme.AppTheme
import ohos_app_cangjie_entry.utils.formatCompactAmount

public class MonthlyChartPoint {
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

@Component
public class MonthlyChart {
    @Prop var expenses: ArrayList<Expense>
    @Prop var rangeStart: String

    private func totalFor(dayOfMonth: Int64): Float64 {
        var total: Float64 = 0.0
        for (expense in this.expenses) {
            let expenseDay = DateTime.parse(expense.dateValue, "yyyy-MM-dd HH:mm:ss")
            if (expenseDay.dayOfMonth == dayOfMonth) {
                total += expense.amount
            }
        }
        total
    }

    private func monthLabel(): String {
        let startDate = DateTime.parse("${this.rangeStart} 00:00:00", "yyyy-MM-dd HH:mm:ss")
        return startDate.format("MMMM yyyy")
    }

    private func points(): ArrayList<MonthlyChartPoint> {
        let items = ArrayList<MonthlyChartPoint>()
        for (day in 1..7) {
            items.add(MonthlyChartPoint(id: day.toString(), label: day.toString(), total: this.totalFor(day)))
        }
        items
    }

    public func build(): Unit {
        Column(space: 10) {
            Text("Monthly spending")
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTheme.textPrimary())
            Text(this.monthLabel())
                .fontSize(12)
                .fontColor(AppTheme.textSecondary())

            Column(space: 8) {
                ForEach(this.points(), itemGeneratorFunc: { point: MonthlyChartPoint, _: Int64 =>
                    Column(space: 4) {
                        Row(space: 8) {
                            Text("Day ${point.label}")
                                .fontSize(12)
                                .fontColor(AppTheme.textSecondary())
                            Text(formatCompactAmount(point.total))
                                .fontSize(13)
                                .fontWeight(FontWeight.Medium)
                                .fontColor(AppTheme.textPrimary())
                        }
                        .width(100.percent)
                        .justifyContent(FlexAlign.SpaceBetween)

                        Row() {
                            Row() {}
                                .width(if (point.total <= 0.0) { 8 } else { 72 })
                                .height(8)
                                .borderRadius(999)
                                .backgroundColor(AppTheme.brandPrimary())
                        }
                        .width(100.percent)
                        .padding(left: 4, right: 4)
                        .alignItems(VerticalAlign.Center)
                    }
                    .width(100.percent)
                }, keyGeneratorFunc: { point: MonthlyChartPoint, _: Int64 => point.id })
            }
            .padding(left: 10, right: 10, top: 12, bottom: 12)
            .width(100.percent)
            .borderRadius(20)
            .backgroundColor(AppTheme.surfaceElevated())
        }
        .padding(left: 16, right: 16, top: 16, bottom: 16)
        .width(100.percent)
        .borderRadius(24)
        .backgroundColor(AppTheme.surfacePrimary())
    }
}