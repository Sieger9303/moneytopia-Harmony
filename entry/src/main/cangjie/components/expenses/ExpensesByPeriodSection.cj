package ohos_app_cangjie_entry.components.expenses

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import std.collection.ArrayList
import ohos_app_cangjie_entry.data.model.Expense
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class ExpensesByPeriodSection {
    @Prop var title: String
    @Prop var expenses: ArrayList<Expense>

    private func sortedDates(): ArrayList<String> {
        let dates = ArrayList<String>()
        for (expense in this.expenses) {
            let dayKey = expense.dateValue.replace(" 00:00:00", "")
            let dateOnly = if (dayKey.indexOf(" ") != Option.None) { expense.dateValue.split(" ")[0] } else { dayKey }
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

    private func expensesForDate(dateValue: String): ArrayList<Expense> {
        let matches = ArrayList<Expense>()
        for (expense in this.expenses) {
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
        for (expense in this.expenses) {
            if (expense.dateValue.startsWith(dateValue + " ") || expense.dateValue == dateValue) {
                total += expense.amount
            }
        }
        total
    }

    public func build(): Unit {
        Column(space: 12) {
            Text(this.title)
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTheme.textPrimary())

            if (this.expenses.size == 0) {
                Text("No transactions in this period.")
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
                        dateValue
                    })
                }
                .width(100.percent)
            }
        }
        .width(100.percent)
    }
}