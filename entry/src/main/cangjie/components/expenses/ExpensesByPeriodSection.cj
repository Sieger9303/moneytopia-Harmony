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
                ForEach(this.expenses, itemGeneratorFunc: { expense: Expense, _: Int64 =>
                    ExpenseRow(expense: expense, allowDelete: false)
                }, keyGeneratorFunc: { expense: Expense, _: Int64 =>
                    expense.id
                })
            }
        }
        .width(100.percent)
    }
}