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
public class WeeklyChart {
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

    private func dayKeyForOffset(offset: Int64): String {
        DateTime
            .parse("${this.snapshot().dateStart} 00:00:00", "yyyy-MM-dd HH:mm:ss")
            .addDays(offset)
            .format("yyyy-MM-dd")
    }

    private func expenseDayKey(expense: Expense): String {
        DateTime
            .parse(expense.dateValue, "yyyy-MM-dd HH:mm:ss")
            .format("yyyy-MM-dd")
    }

    private func totalForOffset(offset: Int64): Float64 {
        let targetDayKey = this.dayKeyForOffset(offset)
        var total: Float64 = 0.0

        for (expense in this.selectedExpenses()) {
            if (this.expenseDayKey(expense) == targetDayKey) {
                total += expense.amount
            }
        }

        total
    }

    private func pointLabelsKey(): String {
        "Mon,Tue,Wed,Thu,Fri,Sat,Sun"
    }

    private func pointTotalsKey(): String {
        "${this.totalForOffset(0)},${this.totalForOffset(1)},${this.totalForOffset(2)},${this.totalForOffset(3)},${this.totalForOffset(4)},${this.totalForOffset(5)},${this.totalForOffset(6)}"
    }

    private func pointTotalsIdentityKey(): String {
        "${this.totalForOffset(0)}_${this.totalForOffset(1)}_${this.totalForOffset(2)}_${this.totalForOffset(3)}_${this.totalForOffset(4)}_${this.totalForOffset(5)}_${this.totalForOffset(6)}"
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