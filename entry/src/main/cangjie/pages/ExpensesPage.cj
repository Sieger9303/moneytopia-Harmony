package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.expenses.ExpensesByDaySection
import ohos_app_cangjie_entry.state.*

@Component
public class ExpensesPage {
    @State var counter: Int64 = 0

    public func build(): Unit {
        Column() {
            Text("Expenses")
                .fontSize(24)
            Text("Counter: ${this.counter}")
            Button("Increment")
                .onClick({ _ =>
                    this.counter += 1
                })
            Text(getDailyExpenseTotal())
                .fontSize(28)
            Text("Transactions today: ${getDailyExpenseCount()}")
            ExpensesByDaySection()
        }
    }
}