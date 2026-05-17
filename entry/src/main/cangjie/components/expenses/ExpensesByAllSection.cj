package ohos_app_cangjie_entry.components.expenses

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.state.getYearlyDates
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class ExpensesByAllSection {
    public func build(): Unit {
        Column(space: 14) {
            Text("All Transactions")
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTheme.textPrimary())
                .padding(left: 4)
            ExpenseDateGroupList(
                dates: getYearlyDates(),
                recurrenceName: "Yearly",
                allowDelete: false,
                emptyMessage: "No reports available yet."
            )
        }
        .width(100.percent)
    }
}