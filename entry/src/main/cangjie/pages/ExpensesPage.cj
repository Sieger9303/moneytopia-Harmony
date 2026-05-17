package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.expenses.ExpensesByDaySection
import ohos_app_cangjie_entry.components.header.HeaderCard
import ohos_app_cangjie_entry.state.*
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class ExpensesPage {
    public func build(): Unit {
        Scroll() {
            Column(space: 18) {
                HeaderCard(title: "Expenses", iconName: "wallet", actionIconName: "info", subtitle: "Track your spending today", dialogText: "Review today's total, open the full reports page with See All, and manage transactions from the expenses list.", actionRoute: "")

                Column(space: 8) {
                    Text("Total Expenses Today")
                        .fontSize(15)
                        .fontColor(AppTheme.textSecondary())
                    Text(getDailyExpenseTotal())
                        .fontSize(32)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppTheme.textPrimary())
                    Text("${getDailyExpenseCount()} transaction(s) today")
                        .fontSize(12)
                        .fontColor(AppTheme.textSecondary())
                }
                .padding(left: 20, right: 20, top: 24, bottom: 24)
                .width(100.percent)
                .alignItems(HorizontalAlign.Center)
                .borderRadius(30)
                .backgroundColor(AppTheme.surfacePrimary())

                ExpensesByDaySection()

                Blank()
                    .height(88)
                    .width(100.percent)
            }
            .width(100.percent)
        }
        .scrollBar(BarState.Off)
        .width(100.percent)
        .height(100.percent)
    }
}