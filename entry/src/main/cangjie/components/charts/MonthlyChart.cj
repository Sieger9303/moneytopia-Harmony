package ohos_app_cangjie_entry.components.charts

import std.collection.ArrayList
import std.time.*
import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.data.model.Expense
import ohos_app_cangjie_entry.data.model.Recurrence
import ohos_app_cangjie_entry.data.model.toRecurrence
import ohos_app_cangjie_entry.state.ChartsState
import ohos_app_cangjie_entry.state.getChartsSnapshot

@Component
public class MonthlyChart {
    @Prop var page: Int64
    @Prop var recurrenceName: String

    private func recurrence(): Recurrence {
        toRecurrence(this.recurrenceName)
    }

    private func snapshot(): ChartsState {
        getChartsSnapshot(this.page, this.recurrence())
    }

    private func selectedExpenses(): ArrayList<Expense> {
        this.snapshot().expenses
    }

    private func rangeStart(): String {
        this.snapshot().dateStart
    }

    private func daysInMonth(): Int64 {
        let startDate = DateTime.parse("${this.rangeStart()} 00:00:00", "yyyy-MM-dd HH:mm:ss")
        let nextMonth = startDate.addMonths(1)
        let lastDay = nextMonth.addDays(-1)
        lastDay.dayOfMonth
    }

    private func dayKeyForDay(day: Int64): String {
        DateTime
            .parse("${this.rangeStart()} 00:00:00", "yyyy-MM-dd HH:mm:ss")
            .addDays(day - 1)
            .format("yyyy-MM-dd")
    }

    private func expenseDayKey(expense: Expense): String {
        DateTime
            .parse(expense.dateValue, "yyyy-MM-dd HH:mm:ss")
            .format("yyyy-MM-dd")
    }

    private func totalForDay(day: Int64): Float64 {
        let targetDayKey = this.dayKeyForDay(day)
        var total: Float64 = 0.0

        for (expense in this.selectedExpenses()) {
            if (this.expenseDayKey(expense) == targetDayKey) {
                total += expense.amount
            }
        }

        total
    }

    private func labelForDay(day: Int64, totalDays: Int64): String {
        if (
            day == 1 ||
            day == 5 ||
            day == 10 ||
            day == 15 ||
            day == 20 ||
            day == 25 ||
            day == totalDays
        ) {
            return day.toString()
        }

        " "
    }

    private func encodeParts(parts: ArrayList<String>): String {
        var encoded = ""
        var index: Int64 = 0

        while (index < parts.size) {
            if (index > 0) {
                encoded += ","
            }
            encoded += parts[index]
            index += 1
        }

        encoded
    }

    private func pointLabelsKey(): String {
        let labels = ArrayList<String>()
        let totalDays = this.daysInMonth()

        var day: Int64 = 1
        while (day <= totalDays) {
            labels.add(this.labelForDay(day, totalDays))
            day += 1
        }

        this.encodeParts(labels)
    }

    private func pointTotalsKey(): String {
        let totals = ArrayList<String>()
        let totalDays = this.daysInMonth()

        var day: Int64 = 1
        while (day <= totalDays) {
            totals.add(this.totalForDay(day).toString())
            day += 1
        }

        this.encodeParts(totals)
    }

    private func encodeIdentityParts(parts: ArrayList<String>): String {
        var encoded = ""
        var index: Int64 = 0

        while (index < parts.size) {
            if (index > 0) {
                encoded += "_"
            }
            encoded += parts[index]
            index += 1
        }

        encoded
    }

    private func pointTotalsIdentityKey(): String {
        let totals = ArrayList<String>()
        let totalDays = this.daysInMonth()

        var day: Int64 = 1
        while (day <= totalDays) {
            totals.add(this.totalForDay(day).toString())
            day += 1
        }

        this.encodeIdentityParts(totals)
    }

    private func periodKey(): String {
        let snapshot = this.snapshot()
        "${this.recurrenceName}-${this.page}-${snapshot.dateStart}-${snapshot.dateEnd}-${this.pointTotalsIdentityKey()}"
    }

    private func chartInstanceKeys(): ArrayList<String> {
        let keys = ArrayList<String>()
        keys.add(this.periodKey())
        keys
    }

    public func build(): Unit {
        Column() {
            ForEach(this.chartInstanceKeys(), itemGeneratorFunc: { key: String, _: Int64 =>
                LineChartCard(
                    title: "",
                    subtitle: "",
                    pointLabelsKey: this.pointLabelsKey(),
                    pointTotalsKey: this.pointTotalsKey(),
                    periodKey: key
                )
            }, keyGeneratorFunc: { key: String, _: Int64 => key })
        }
    }
}
