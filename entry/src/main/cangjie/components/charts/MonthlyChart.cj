package ohos_app_cangjie_entry.components.charts

import std.collection.ArrayList
import std.time.*
import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.data.model.Expense

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

    private func daysInMonth(): Int64 {
        let startDate = DateTime.parse("${this.rangeStart} 00:00:00", "yyyy-MM-dd HH:mm:ss")
        let nextMonth = startDate.addMonths(1)
        let lastDay = nextMonth.addDays(-1)
        lastDay.dayOfMonth
    }

    private func labelForDay(day: Int64, totalDays: Int64): String {
        let _ = totalDays
        day.toString()
    }

    private func points(): ArrayList<LineChartPoint> {
        let items = ArrayList<LineChartPoint>()
        let totalDays = this.daysInMonth()
        for (day in 1..totalDays) {
            items.add(LineChartPoint(id: day.toString(), label: this.labelForDay(day, totalDays), total: this.totalFor(day)))
        }
        items
    }

    public func build(): Unit {
        Column() {
            LineChartCard(
                title: "",
                subtitle: "",
                points: this.points()
            )
        }
    }
}
