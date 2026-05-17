package ohos_app_cangjie_entry.components.charts

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import std.collection.ArrayList
import std.time.*
import ohos_app_cangjie_entry.data.model.Expense
import ohos_app_cangjie_entry.theme.AppTheme

public class YearlyChartPoint {
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
public class YearlyChart {
    @Prop var expenses: ArrayList<Expense>

    private func totalFor(monthName: String): Float64 {
        var total: Float64 = 0.0
        for (expense in this.expenses) {
            let expenseDay = DateTime.parse(expense.dateValue, "yyyy-MM-dd HH:mm:ss")
            if (expenseDay.month.toString() == monthName) {
                total += expense.amount
            }
        }
        total
    }

    private func points(): ArrayList<YearlyChartPoint> {
        let items = ArrayList<YearlyChartPoint>()
        items.add(YearlyChartPoint(id: "jan", label: "January", total: this.totalFor("January")))
        items.add(YearlyChartPoint(id: "feb", label: "February", total: this.totalFor("February")))
        items.add(YearlyChartPoint(id: "mar", label: "March", total: this.totalFor("March")))
        items.add(YearlyChartPoint(id: "apr", label: "April", total: this.totalFor("April")))
        items.add(YearlyChartPoint(id: "may", label: "May", total: this.totalFor("May")))
        items.add(YearlyChartPoint(id: "jun", label: "June", total: this.totalFor("June")))
        items.add(YearlyChartPoint(id: "jul", label: "July", total: this.totalFor("July")))
        items.add(YearlyChartPoint(id: "aug", label: "August", total: this.totalFor("August")))
        items.add(YearlyChartPoint(id: "sep", label: "September", total: this.totalFor("September")))
        items.add(YearlyChartPoint(id: "oct", label: "October", total: this.totalFor("October")))
        items.add(YearlyChartPoint(id: "nov", label: "November", total: this.totalFor("November")))
        items.add(YearlyChartPoint(id: "dec", label: "December", total: this.totalFor("December")))
        items
    }

    public func build(): Unit {
        Column(space: 10) {
            Text("Yearly spending")
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTheme.textPrimary())
            ForEach(this.points(), itemGeneratorFunc: { point: YearlyChartPoint, _: Int64 =>
                Column(space: 4) {
                    Row(space: 8) {
                        Text(point.label)
                            .fontSize(13)
                            .fontColor(AppTheme.textSecondary())
                        Text(point.total.toString())
                            .fontSize(13)
                            .fontWeight(FontWeight.Medium)
                            .fontColor(AppTheme.textPrimary())
                    }
                    .width(100.percent)
                    .justifyContent(FlexAlign.SpaceBetween)
                    Row() {}
                        .width(100.percent)
                        .height(8)
                        .borderRadius(999)
                        .backgroundColor(AppTheme.brandPrimary())
                }
                .width(100.percent)
            }, keyGeneratorFunc: { point: YearlyChartPoint, _: Int64 =>
                point.id
            })
        }
        .padding(left: 16, right: 16, top: 16, bottom: 16)
        .width(100.percent)
        .borderRadius(24)
        .backgroundColor(AppTheme.surfacePrimary())
    }
}