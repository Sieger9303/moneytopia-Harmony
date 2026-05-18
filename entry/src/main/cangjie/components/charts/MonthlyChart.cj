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
public class MonthlyChart {
    @Prop var page: Int64
    @Prop var recurrenceName: String

    private func recurrence(): Recurrence {
        toRecurrence(this.recurrenceName)
    }

    private func selectedExpenses(): ArrayList<Expense> {
        getChartsSnapshot(this.page, this.recurrence()).expenses
    }

    private func rangeStart(): String {
        getChartsSnapshot(this.page, this.recurrence()).dateStart
    }

    private func periodKey(): String {
        let snapshot = getChartsSnapshot(this.page, this.recurrence())
        "${this.recurrenceName}-${this.page}-${snapshot.dateStart}-${snapshot.dateEnd}-${this.pointTotalsKey()}"
    }

    private func totalFor(dayOfMonth: Int64): Float64 {
        var total: Float64 = 0.0
        for (expense in this.selectedExpenses()) {
            let expenseDay = DateTime.parse(expense.dateValue, "yyyy-MM-dd HH:mm:ss")
            if (expenseDay.dayOfMonth == dayOfMonth) {
                total += expense.amount
            }
        }
        total
    }

    private func daysInMonth(): Int64 {
        let startDate = DateTime.parse("${this.rangeStart()} 00:00:00", "yyyy-MM-dd HH:mm:ss")
        let nextMonth = startDate.addMonths(1)
        let lastDay = nextMonth.addDays(-1)
        lastDay.dayOfMonth
    }

    private func labelForDay(day: Int64, totalDays: Int64): String {
        let _ = totalDays
        day.toString()
    }

    private func encodeParts(parts: ArrayList<String>): String {
        var encoded = ""
        if (parts.size <= 0) {
            return encoded
        }
        for (index in 0..parts.size - 1) {
            if (index > 0) {
                encoded += "|"
            }
            encoded += parts[index]
        }
        encoded
    }

    private func pointLabelsKey(): String {
        let labels = ArrayList<String>()
        let totalDays = this.daysInMonth()
        for (day in 1..totalDays) {
            labels.add(this.labelForDay(day, totalDays))
        }
        this.encodeParts(labels)
    }

    private func pointTotalsKey(): String {
        let totals = ArrayList<String>()
        let totalDays = this.daysInMonth()
        for (day in 1..totalDays) {
            totals.add(this.totalFor(day).toString())
        }
        this.encodeParts(totals)
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
