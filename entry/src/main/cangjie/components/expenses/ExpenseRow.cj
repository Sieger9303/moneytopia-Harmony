package ohos_app_cangjie_entry.components.expenses

import std.time.*
import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.data.local.ExpenseStore
import ohos_app_cangjie_entry.data.local.PreferenceStore
import ohos_app_cangjie_entry.data.model.Expense

@Component
public class ExpenseRow {
    @Prop var expense: Expense
    @Prop var allowDelete: Bool

    @State var showDeletePrompt: Bool = false

    private let expenseStore = ExpenseStore()
    private let preferenceStore = PreferenceStore()

    private func timeLabel(): String {
        DateTime.parse(this.expense.dateValue, "yyyy-MM-dd HH:mm:ss").format("HH:mm")
    }

    public func build(): Unit {
        Column(space: 6) {
            Row(space: 8) {
                Text(this.expense.category)
                    .fontSize(18)
                if (this.expense.recurrenceName != "None") {
                    Text(this.expense.recurrenceName)
                }
            }
            if (this.expense.note != "") {
                Text(this.expense.note)
            }
            Row(space: 12) {
                Text("- ${this.preferenceStore.getCurrencySymbol()}${this.expense.amount}")
                Text(this.timeLabel())
            }
            if (this.allowDelete && !this.showDeletePrompt) {
                Button("Delete transaction")
                    .onClick({ _ =>
                        this.showDeletePrompt = true
                    })
            }
            if (this.showDeletePrompt) {
                Column(space: 6) {
                    Text("Delete this transaction?")
                    Row(space: 8) {
                        Button("Cancel")
                            .onClick({ _ =>
                                this.showDeletePrompt = false
                            })
                        Button("Delete")
                            .onClick({ _ =>
                                this.expenseStore.deleteExpense(this.expense.id)
                                this.showDeletePrompt = false
                            })
                    }
                }
            }
        }
        .padding(12)
    }
}