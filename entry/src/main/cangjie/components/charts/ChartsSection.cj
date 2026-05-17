package ohos_app_cangjie_entry.components.charts

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.expenses.ExpensesByPeriodSection
import ohos_app_cangjie_entry.data.model.Recurrence
import ohos_app_cangjie_entry.data.model.toRecurrence
import ohos_app_cangjie_entry.state.getChartsSnapshot
import ohos_app_cangjie_entry.utils.calculateDateRange
import ohos_app_cangjie_entry.utils.formatDayForRange
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class ChartsSection {
    @Prop var page: Int64
    @Prop var recurrenceName: String
    @Prop var title: String

    private func recurrence(): Recurrence {
        toRecurrence(this.recurrenceName)
    }

    private func dateRangeLabel(): String {
        let data = getChartsSnapshot(this.page, this.recurrence())
        formatDayForRange(data.dateStart) + " - " + formatDayForRange(data.dateEnd)
    }

    private func totalLabel(): String {
        let data = getChartsSnapshot(this.page, this.recurrence())
        data.currencySymbol + data.totalInRange.toString()
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
                Text(this.dateRangeLabel())
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTheme.textPrimary())
                Text(this.totalLabel())
                    .fontSize(24)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTheme.textPrimary())
            }
            .padding(left: 18, right: 18, top: 18, bottom: 18)
            .width(100.percent)
            .borderRadius(24)
            .backgroundColor(AppTheme.surfacePrimary())

            ChartMarker(label: "Tap the mode above to switch periods")
            if (this.recurrenceName == "Weekly") {
                WeeklyChart(expenses: getChartsSnapshot(this.page, this.recurrence()).expenses)
            }
            if (this.recurrenceName == "Monthly") {
                MonthlyChart(expenses: getChartsSnapshot(this.page, this.recurrence()).expenses, rangeStart: this.rangeStart(), daysInRange: this.rangeDays())
            }
            if (this.recurrenceName == "Yearly") {
                YearlyChart(expenses: getChartsSnapshot(this.page, this.recurrence()).expenses)
            }
            ExpensesByPeriodSection(title: "Transactions", expenses: getChartsSnapshot(this.page, this.recurrence()).expenses)
        }
        .width(100.percent)
    }
}