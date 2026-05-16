package ohos_app_cangjie_entry.components.expenses

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.state.getYearlyDates

@Component
public class ExpensesByAllSection {
    public func build(): Unit {
        Column(space: 12) {
            Text("All Transactions")
                .fontSize(20)
            ExpenseDateGroupList(
                dates: getYearlyDates(),
                recurrenceName: "Yearly",
                allowDelete: false,
                emptyMessage: "No reports available yet."
            )
        }
    }
}