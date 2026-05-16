package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.expenses.ExpensesByAllSection
import ohos_app_cangjie_entry.runtime.RouteState
import ohos_app_cangjie_entry.state.*

@Component
public class ReportsPage {
    @State var counter: Int64 = 0

    public func build(): Unit {
        Column() {
            Text("Reports")
                .fontSize(24)
            Text("Counter: ${this.counter}")
            Button("Increment")
                .onClick({ _ =>
                    this.counter += 1
                })
            Text("Transactions this year: ${getYearlyExpenseCount()}")
            Button("Back to Expenses")
                .onClick({ _ =>
                    RouteState.navigate("expenses")
                })
            ExpensesByAllSection()
        }
    }
}