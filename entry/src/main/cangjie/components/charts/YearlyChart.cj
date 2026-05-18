package ohos_app_cangjie_entry.components.charts

import std.collection.ArrayList
import std.time.*
import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.data.model.Expense
import ohos_app_cangjie_entry.data.model.Recurrence
import ohos_app_cangjie_entry.data.model.toRecurrence
import ohos_app_cangjie_entry.state.getChartsSnapshot

@Component
public class YearlyChart {
    @Prop var page: Int64
    @Prop var recurrenceName: String

    private func recurrence(): Recurrence {
        toRecurrence(this.recurrenceName)
    }

    private func selectedExpenses(): ArrayList<Expense> {
        getChartsSnapshot(this.page, this.recurrence()).expenses
    }

    private func periodKey(): String {
        "${this.recurrenceName}-${this.page}-${this.pointTotalsKey()}"
    }

    private func totalFor(monthName: String): Float64 {
        var total: Float64 = 0.0
        for (expense in this.selectedExpenses()) {
            let expenseDay = DateTime.parse(expense.dateValue, "yyyy-MM-dd HH:mm:ss")
            if (expenseDay.month.toString() == monthName) {
                total += expense.amount
            }
        }
        total
    }

    private func pointLabelsKey(): String {
        "Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec"
    }

    private func pointTotalsKey(): String {
        "${this.totalFor("January")}|${this.totalFor("February")}|${this.totalFor("March")}|${this.totalFor("April")}|${this.totalFor("May")}|${this.totalFor("June")}|${this.totalFor("July")}|${this.totalFor("August")}|${this.totalFor("September")}|${this.totalFor("October")}|${this.totalFor("November")}|${this.totalFor("December")}"
    }

    public func build(): Unit {
        Column() {
            LineChartCard(
                title: "",
                subtitle: "",
                pointLabelsKey: this.pointLabelsKey(),
                pointTotalsKey: this.pointTotalsKey(),
                periodKey: this.periodKey()
            )
        }
    }
}
