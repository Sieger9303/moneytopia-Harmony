package ohos_app_cangjie_entry.components.expenses

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.runtime.RouteState
import ohos_app_cangjie_entry.state.getDailyDates

@Component
public class ExpensesByDaySection {
    public func build(): Unit {
        Column(space: 12) {
            Row(space: 12) {
                Text("Recent Transactions")
                    .fontSize(20)
                Button("See all")
                    .onClick({ _ =>
                        RouteState.navigate("reports")
                    })
            }
            ExpenseDateGroupList(
                dates: getDailyDates(),
                recurrenceName: "Daily",
                allowDelete: true,
                emptyMessage: "No daily transactions yet."
            )
        }
    }
}