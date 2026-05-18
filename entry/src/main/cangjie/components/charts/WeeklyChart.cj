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
public class WeeklyChart {
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

    private func totalFor(dayName: String): Float64 {
        var total: Float64 = 0.0
        for (expense in this.selectedExpenses()) {
            let expenseDay = DateTime.parse(expense.dateValue, "yyyy-MM-dd HH:mm:ss")
            if (expenseDay.dayOfWeek.toString() == dayName) {
                total += expense.amount
            }
        }
        total
    }

    private func pointLabelsKey(): String {
        "Mon|Tue|Wed|Thu|Fri|Sat|Sun"
    }

    private func pointTotalsKey(): String {
        "${this.totalFor("Monday")}|${this.totalFor("Tuesday")}|${this.totalFor("Wednesday")}|${this.totalFor("Thursday")}|${this.totalFor("Friday")}|${this.totalFor("Saturday")}|${this.totalFor("Sunday")}"
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
