package ohos_app_cangjie_entry.components.charts

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import std.collection.ArrayList
import std.time.*
import ohos_app_cangjie_entry.data.model.Expense
import ohos_app_cangjie_entry.theme.AppTheme

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
    @Prop var daysInRange: Int64

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

    private func points(): ArrayList<MonthlyChartPoint> {
        let items = ArrayList<MonthlyChartPoint>()
        for (day in 1..this.daysInRange) {
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
            Text(DateTime.parse(" 00:00:00", "yyyy-MM-dd HH:mm:ss").format("MMMM yyyy"))
                .fontSize(12)
                .fontColor(AppTheme.textSecondary())
            ForEach(this.points(), itemGeneratorFunc: { point: MonthlyChartPoint, _: Int64 =>
                Row(space: 12) {
                    Text(point.label)
                        .fontSize(13)
                        .fontColor(AppTheme.textSecondary())
                        .width(52.percent)
                    Text(point.total.toString())
                        .fontSize(14)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppTheme.brandPrimary())
                }
                .width(100.percent)
                .justifyContent(FlexAlign.SpaceBetween)
            }, keyGeneratorFunc: { point: MonthlyChartPoint, _: Int64 =>
                point.id
            })
        }
        .padding(left: 16, right: 16, top: 16, bottom: 16)
        .width(100.percent)
        .borderRadius(24)
        .backgroundColor(AppTheme.surfacePrimary())
    }
}