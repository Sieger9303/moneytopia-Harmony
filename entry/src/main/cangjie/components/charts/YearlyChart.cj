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
public class YearlyChart {
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

    private func selectedYearKey(): String {
        DateTime
            .parse("${this.snapshot().dateStart} 00:00:00", "yyyy-MM-dd HH:mm:ss")
            .format("yyyy")
    }

    private func monthKey(monthNumber: Int64): String {
        if (monthNumber < 10) {
            return "0${monthNumber}"
        }

        monthNumber.toString()
    }

    private func expenseYearKey(expense: Expense): String {
        DateTime
            .parse(expense.dateValue, "yyyy-MM-dd HH:mm:ss")
            .format("yyyy")
    }

    private func expenseMonthKey(expense: Expense): String {
        DateTime
            .parse(expense.dateValue, "yyyy-MM-dd HH:mm:ss")
            .format("MM")
    }

    private func totalForMonth(monthNumber: Int64): Float64 {
        let targetYearKey = this.selectedYearKey()
        let targetMonthKey = this.monthKey(monthNumber)
        var total: Float64 = 0.0

        for (expense in this.selectedExpenses()) {
            if (
                this.expenseYearKey(expense) == targetYearKey &&
                this.expenseMonthKey(expense) == targetMonthKey
            ) {
                total += expense.amount
            }
        }

        total
    }

    private func pointLabelsKey(): String {
        "Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec"
    }

    private func pointTotalsKey(): String {
        "${this.totalForMonth(1)}|${this.totalForMonth(2)}|${this.totalForMonth(3)}|${this.totalForMonth(4)}|${this.totalForMonth(5)}|${this.totalForMonth(6)}|${this.totalForMonth(7)}|${this.totalForMonth(8)}|${this.totalForMonth(9)}|${this.totalForMonth(10)}|${this.totalForMonth(11)}|${this.totalForMonth(12)}"
    }

    private func periodKey(): String {
        let snapshot = this.snapshot()
        "${this.recurrenceName}-${this.page}-${snapshot.dateStart}-${snapshot.dateEnd}-${this.pointTotalsKey()}"
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