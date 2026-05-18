package ohos_app_cangjie_entry.components.charts

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.expenses.ExpensesByPeriodSection
import ohos_app_cangjie_entry.data.model.Recurrence
import ohos_app_cangjie_entry.data.model.toRecurrence
import ohos_app_cangjie_entry.state.ChartsState
import ohos_app_cangjie_entry.state.getChartsSnapshot
import ohos_app_cangjie_entry.utils.formatDayForRange
import ohos_app_cangjie_entry.utils.formatMoney
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class ChartsSection {
    @Prop var page: Int64
    @Prop var recurrenceName: String
    @Prop var title: String

    private func recurrence(): Recurrence {
        toRecurrence(this.recurrenceName)
    }

    private func data(): ChartsState {
        getChartsSnapshot(this.page, this.recurrence())
    }

    private func dateRangeLabel(): String {
        let data = this.data()
        return "${formatDayForRange(data.dateStart)} - ${formatDayForRange(data.dateEnd)}"
    }

    private func totalLabel(): String {
        let data = this.data()
        return formatMoney(data.totalInRange, data.currencySymbol)
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

            ChartMarker(label: "Selected period transactions appear below the chart")

            if (this.recurrenceName == "Weekly") {
                WeeklyChart(expenses: this.data().expenses)
            }
            if (this.recurrenceName == "Monthly") {
                MonthlyChart(expenses: this.data().expenses, rangeStart: this.data().dateStart)
            }
            if (this.recurrenceName == "Yearly") {
                YearlyChart(expenses: this.data().expenses)
            }

            ExpensesByPeriodSection(title: "Transactions", expenses: this.data().expenses)
        }
        .width(100.percent)
    }
}