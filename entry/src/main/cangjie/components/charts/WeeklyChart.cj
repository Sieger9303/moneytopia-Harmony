package ohos_app_cangjie_entry.components.charts

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import std.collection.ArrayList
import std.time.*
import ohos_app_cangjie_entry.data.model.Expense

public class WeeklyChartPoint {
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
public class WeeklyChart {
    @Prop var expenses: ArrayList<Expense>

    private func totalFor(dayName: String): Float64 {
        var total: Float64 = 0.0
        for (expense in this.expenses) {
            let expenseDay = DateTime.parse(expense.dateValue, "yyyy-MM-dd HH:mm:ss")
            if (expenseDay.dayOfWeek.toString() == dayName) {
                total += expense.amount
            }
        }
        total
    }

    private func points(): ArrayList<WeeklyChartPoint> {
        let items = ArrayList<WeeklyChartPoint>()
        items.add(WeeklyChartPoint(id: "mon", label: "Monday", total: this.totalFor("Monday")))
        items.add(WeeklyChartPoint(id: "tue", label: "Tuesday", total: this.totalFor("Tuesday")))
        items.add(WeeklyChartPoint(id: "wed", label: "Wednesday", total: this.totalFor("Wednesday")))
        items.add(WeeklyChartPoint(id: "thu", label: "Thursday", total: this.totalFor("Thursday")))
        items.add(WeeklyChartPoint(id: "fri", label: "Friday", total: this.totalFor("Friday")))
        items.add(WeeklyChartPoint(id: "sat", label: "Saturday", total: this.totalFor("Saturday")))
        items.add(WeeklyChartPoint(id: "sun", label: "Sunday", total: this.totalFor("Sunday")))
        items
    }

    public func build(): Unit {
        Column(space: 6) {
            Text("Weekly spending")
                .fontSize(16)
            ForEach(this.points(), itemGeneratorFunc: { point: WeeklyChartPoint, _: Int64 =>
                Row(space: 12) {
                    Text(point.label)
                    Text(point.total.toString())
                }
            }, keyGeneratorFunc: { point: WeeklyChartPoint, _: Int64 =>
                point.id
            })
        }
        .padding(12)
    }
}