package ohos_app_cangjie_entry.components.charts

import std.collection.ArrayList
import std.time.*
import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.data.model.Expense

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

    private func points(): ArrayList<LineChartPoint> {
        let items = ArrayList<LineChartPoint>()
        items.add(LineChartPoint(id: "jan", label: "Jan", total: this.totalFor("January")))
        items.add(LineChartPoint(id: "feb", label: "Feb", total: this.totalFor("February")))
        items.add(LineChartPoint(id: "mar", label: "Mar", total: this.totalFor("March")))
        items.add(LineChartPoint(id: "apr", label: "Apr", total: this.totalFor("April")))
        items.add(LineChartPoint(id: "may", label: "May", total: this.totalFor("May")))
        items.add(LineChartPoint(id: "jun", label: "Jun", total: this.totalFor("June")))
        items.add(LineChartPoint(id: "jul", label: "Jul", total: this.totalFor("July")))
        items.add(LineChartPoint(id: "aug", label: "Aug", total: this.totalFor("August")))
        items.add(LineChartPoint(id: "sep", label: "Sep", total: this.totalFor("September")))
        items.add(LineChartPoint(id: "oct", label: "Oct", total: this.totalFor("October")))
        items.add(LineChartPoint(id: "nov", label: "Nov", total: this.totalFor("November")))
        items.add(LineChartPoint(id: "dec", label: "Dec", total: this.totalFor("December")))
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
