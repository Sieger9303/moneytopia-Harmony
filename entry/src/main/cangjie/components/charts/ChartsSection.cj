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
        Column(space: 14) {
            Column(space: 4) {
                Text(this.title)
                    .fontSize(20)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(0xFF1C1B1F)
                Text(this.dateRangeLabel())
                    .fontSize(12)
                    .fontColor(0xFF7B7388)
                Text(this.totalLabel())
                    .fontSize(24)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(0xFF1C1B1F)
            }
            .padding(left: 18, right: 18, top: 18, bottom: 18)
            .width(100.percent)
            .borderRadius(24)
            .backgroundColor(0xFFFDF8FF)

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