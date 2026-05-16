package ohos_app_cangjie_entry.components.charts

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import std.collection.ArrayList
import ohos_app_cangjie_entry.components.expenses.ExpensesByPeriodSection
import ohos_app_cangjie_entry.data.model.Expense
import ohos_app_cangjie_entry.data.model.Recurrence
import ohos_app_cangjie_entry.data.model.toRecurrence
import ohos_app_cangjie_entry.state.getChartsSnapshot
import ohos_app_cangjie_entry.utils.calculateDateRange
import ohos_app_cangjie_entry.utils.formatDayForRange

@Component
public class ChartsSection {
    @Prop var page: Int64
    @Prop var recurrenceName: String
    @Prop var title: String

    private func recurrence(): Recurrence {
        toRecurrence(this.recurrenceName)
    }

    private func snapshot() {
        getChartsSnapshot(this.page, this.recurrence())
    }

    private func dateRangeLabel(): String {
        let snapshot = this.snapshot()
        "${formatDayForRange(snapshot.dateStart)} - ${formatDayForRange(snapshot.dateEnd)}"
    }

    private func totalLabel(): String {
        let snapshot = this.snapshot()
        "${snapshot.currencySymbol}${snapshot.totalInRange}"
    }

    private func periodExpenses(): ArrayList<Expense> {
        this.snapshot().expenses
    }

    private func rangeStart(): String {
        calculateDateRange(this.recurrence(), this.page).start
    }

    private func rangeDays(): Int64 {
        calculateDateRange(this.recurrence(), this.page).daysInRange
    }

    public func build(): Unit {
        Column(space: 12) {
            Text(this.title)
                .fontSize(20)
            Text(this.dateRangeLabel())
            Text(this.totalLabel())
                .fontSize(24)
            ChartMarker(label: "Period breakdown")
            if (this.recurrenceName == "Weekly") {
                WeeklyChart(expenses: this.periodExpenses())
            }
            if (this.recurrenceName == "Monthly") {
                MonthlyChart(expenses: this.periodExpenses(), rangeStart: this.rangeStart(), daysInRange: this.rangeDays())
            }
            if (this.recurrenceName == "Yearly") {
                YearlyChart(expenses: this.periodExpenses())
            }
            ExpensesByPeriodSection(title: "Transactions", expenses: this.periodExpenses())
        }
    }
}