package ohos_app_cangjie_entry.components.expenses

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import std.collection.ArrayList
import ohos_app_cangjie_entry.data.model.Expense

@Component
public class ExpensesByPeriodSection {
    @Prop var title: String
    @Prop var expenses: ArrayList<Expense>

    public func build(): Unit {
        Column(space: 12) {
            Text(this.title)
                .fontSize(20)

            if (this.expenses.size == 0) {
                Text("No transactions in this period.")
            } else {
                ForEach(this.expenses, itemGeneratorFunc: { expense: Expense, _: Int64 =>
                    ExpenseRow(expense: expense, allowDelete: false)
                }, keyGeneratorFunc: { expense: Expense, _: Int64 =>
                    expense.id
                })
            }
        }
    }
}