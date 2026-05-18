package ohos_app_cangjie_entry.components.charts

import std.collection.ArrayList
import std.time.*
import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.data.model.Expense

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

    private func points(): ArrayList<LineChartPoint> {
        let items = ArrayList<LineChartPoint>()
        items.add(LineChartPoint(id: "mon", label: "Mon", total: this.totalFor("Monday")))
        items.add(LineChartPoint(id: "tue", label: "Tue", total: this.totalFor("Tuesday")))
        items.add(LineChartPoint(id: "wed", label: "Wed", total: this.totalFor("Wednesday")))
        items.add(LineChartPoint(id: "thu", label: "Thu", total: this.totalFor("Thursday")))
        items.add(LineChartPoint(id: "fri", label: "Fri", total: this.totalFor("Friday")))
        items.add(LineChartPoint(id: "sat", label: "Sat", total: this.totalFor("Saturday")))
        items.add(LineChartPoint(id: "sun", label: "Sun", total: this.totalFor("Sunday")))
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
