package ohos_app_cangjie_entry.components.expenses

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import std.collection.ArrayList
import ohos_app_cangjie_entry.data.model.Expense
import ohos_app_cangjie_entry.state.getDailyExpensesForDate
import ohos_app_cangjie_entry.state.getDailyTotalForDate
import ohos_app_cangjie_entry.state.getYearlyExpensesForDate
import ohos_app_cangjie_entry.state.getYearlyTotalForDate
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class ExpenseDateGroupList {
    @Prop var dates: ArrayList<String>
    @Prop var recurrenceName: String
    @Prop var allowDelete: Bool
    @Prop var emptyMessage: String

    private func expensesForDate(dateValue: String): ArrayList<Expense> {
        if (this.recurrenceName == "Daily") {
            return getDailyExpensesForDate(dateValue)
        }
        return getYearlyExpensesForDate(dateValue)
    }

    private func totalForDate(dateValue: String): Float64 {
        if (this.recurrenceName == "Daily") {
            return getDailyTotalForDate(dateValue)
        }
        return getYearlyTotalForDate(dateValue)
    }

    public func build(): Unit {
        if (this.dates.size == 0) {
            Column(space: 10) {
                Text(this.emptyMessage)
                    .fontSize(15)
                    .fontColor(AppTheme.textSecondary())
            }
            .alignItems(HorizontalAlign.Center)
            .padding(left: 18, right: 18, top: 22, bottom: 22)
            .width(100.percent)
            .borderRadius(24)
            .backgroundColor(AppTheme.surfaceElevated())
        } else {
            Column(space: 14) {
                ForEach(this.dates, itemGeneratorFunc: { dateValue: String, _: Int64 =>
                    ExpensesDayGroup(
                        title: dateValue,
                        expenses: this.expensesForDate(dateValue),
                        total: this.totalForDate(dateValue),
                        allowDelete: this.allowDelete
                    )
                }, keyGeneratorFunc: { dateValue: String, _: Int64 =>
                    dateValue
                })
            }
            .width(100.percent)
        }
    }
}