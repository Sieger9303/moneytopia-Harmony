package ohos_app_cangjie_entry.components.expenses

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import std.collection.ArrayList
import ohos_app_cangjie_entry.data.model.Expense
import ohos_app_cangjie_entry.data.model.Recurrence
import ohos_app_cangjie_entry.data.model.toRecurrence
import ohos_app_cangjie_entry.state.getChartsSnapshot
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class ExpensesByPeriodSection {
    @Prop var title: String
    @Prop var page: Int64
    @Prop var recurrenceName: String

    private func recurrence(): Recurrence {
        toRecurrence(this.recurrenceName)
    }

    private func selectedExpenses(): ArrayList<Expense> {
        getChartsSnapshot(this.page, this.recurrence()).expenses
    }

    private func uniqueSortedDatesDescending(): ArrayList<String> {
        let dates = ArrayList<String>()
        for (expense in this.selectedExpenses()) {
            let dateOnly = expense.dateValue.split(" ")[0]
            var exists = false
            for (existing in dates) {
                if (existing == dateOnly) {
                    exists = true
                }
            }
            if (!exists) {
                dates.add(dateOnly)
            }
        }
        if (dates.size <= 1) {
            return dates
        }
        for (outer in 0..dates.size - 1) {
            for (inner in 0..dates.size - 2) {
                if (dates[inner] < dates[inner + 1]) {
                    let current = dates[inner]
                    dates[inner] = dates[inner + 1]
                    dates[inner + 1] = current
                }
            }
        }
        dates
    }

    private func sortedDates(): ArrayList<String> {
        this.uniqueSortedDatesDescending()
    }

    private func expensesForDate(dateValue: String): ArrayList<Expense> {
        let matches = ArrayList<Expense>()
        for (expense in this.selectedExpenses()) {
            if (expense.dateValue.startsWith(dateValue + " ") || expense.dateValue == dateValue) {
                matches.add(expense)
            }
        }
        if (matches.size <= 1) {
            return matches
        }
        for (outer in 0..matches.size - 1) {
            for (inner in 0..matches.size - 2) {
                if (matches[inner].dateValue > matches[inner + 1].dateValue) {
                    let current = matches[inner]
                    matches[inner] = matches[inner + 1]
                    matches[inner + 1] = current
                }
            }
        }
        matches
    }

    private func totalForDate(dateValue: String): Float64 {
        var total: Float64 = 0.0
        for (expense in this.selectedExpenses()) {
            if (expense.dateValue.startsWith(dateValue + " ") || expense.dateValue == dateValue) {
                total += expense.amount
            }
        }
        total
    }

    private func hasSelectedExpenses(): Bool {
        this.selectedExpenses().size > 0
    }

    public func build(): Unit {
        Column(space: 12) {
            if (this.title != "") {
                Text(this.title)
                    .fontSize(20)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTheme.textPrimary())
            }

            if (!this.hasSelectedExpenses()) {
                Text("Transaction history for this time period is not available.")
                    .fontSize(14)
                    .fontColor(AppTheme.textSecondary())
                    .padding(left: 18, right: 18, top: 20, bottom: 20)
                    .width(100.percent)
                    .borderRadius(24)
                    .backgroundColor(AppTheme.surfaceElevated())
            } else {
                Column(space: 14) {
                    ForEach(this.sortedDates(), itemGeneratorFunc: { dateValue: String, _: Int64 =>
                        ExpensesDayGroup(
                            title: dateValue,
                            expenses: this.expensesForDate(dateValue),
                            total: this.totalForDate(dateValue),
                            allowDelete: false
                        )
                    }, keyGeneratorFunc: { dateValue: String, _: Int64 =>
                        "${this.recurrenceName}-${this.page}-${dateValue}"
                    })
                }
                .width(100.percent)
            }
        }
        .width(100.percent)
    }
}
