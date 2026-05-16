package ohos_app_cangjie_entry.components.expenses

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import std.collection.ArrayList
import ohos_app_cangjie_entry.data.local.PreferenceStore
import ohos_app_cangjie_entry.data.model.Expense
import ohos_app_cangjie_entry.utils.formatDay

@Component
public class ExpensesDayGroup {
    @Prop var title: String
    @Prop var expenses: ArrayList<Expense>
    @Prop var total: Float64
    @Prop var allowDelete: Bool

    private let preferenceStore = PreferenceStore()

    public func build(): Unit {
        Column(space: 8) {
            Text(formatDay(this.title))
                .fontSize(18)

            ForEach(this.expenses, itemGeneratorFunc: { expense: Expense, _: Int64 =>
                ExpenseRow(expense: expense, allowDelete: this.allowDelete)
            }, keyGeneratorFunc: { expense: Expense, _: Int64 =>
                expense.id
            })

            Text("Total: ${this.preferenceStore.getCurrencySymbol()}${this.total}")
                .fontSize(18)
        }
        .padding(8)
    }
}