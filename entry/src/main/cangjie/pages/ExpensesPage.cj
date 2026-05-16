package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.expenses.ExpensesByDaySection
import ohos_app_cangjie_entry.components.header.HeaderCard
import ohos_app_cangjie_entry.state.*

@Component
public class ExpensesPage {
    public func build(): Unit {
        Column(space: 18) {
            HeaderCard(title: "Expenses", iconName: "wallet", actionIconName: "info", subtitle: "Track your spending today")

            Column(space: 8) {
                Text("Total Expenses Today")
                    .fontSize(15)
                    .fontColor(0xFF7B7388)
                Text(getDailyExpenseTotal())
                    .fontSize(32)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(0xFF1C1B1F)
                Text("${getDailyExpenseCount()} transaction(s) today")
                    .fontSize(12)
                    .fontColor(0xFF7B7388)
            }
            .padding(left: 20, right: 20, top: 24, bottom: 24)
            .width(100.percent)
            .alignItems(HorizontalAlign.Center)
            .borderRadius(30)
            .backgroundColor(0xFFFDF8FF)

            ExpensesByDaySection()
        }
        .width(100.percent)
    }
}