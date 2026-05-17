package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.header.HeaderCard
import ohos_app_cangjie_entry.components.expenses.ExpensesByAllSection
import ohos_app_cangjie_entry.state.getYearlyExpenseCount
import ohos_app_cangjie_entry.state.getYearlyDateCount
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class ReportsPage {
    public func build(): Unit {
        Column(space: 16) {
            HeaderCard(title: "Reports", iconName: "report", actionIconName: "info", subtitle: "Review grouped expense history", dialogText: "Reports shows grouped yearly history and keeps the non-delete behavior from the source report screen.", actionRoute: "")

            Row(space: 12) {
                Column(space: 4) {
                    Text("Transactions")
                        .fontSize(12)
                        .fontColor(AppTheme.textSecondary())
                    Text("")
                        .fontSize(22)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppTheme.textPrimary())
                }
                .width(48.percent)
                .padding(left: 18, right: 18, top: 18, bottom: 18)
                .borderRadius(24)
                .backgroundColor(AppTheme.surfacePrimary())

                Column(space: 4) {
                    Text("Days")
                        .fontSize(12)
                        .fontColor(AppTheme.textSecondary())
                    Text("")
                        .fontSize(22)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppTheme.textPrimary())
                }
                .width(48.percent)
                .padding(left: 18, right: 18, top: 18, bottom: 18)
                .borderRadius(24)
                .backgroundColor(AppTheme.surfacePrimary())
            }
            .width(100.percent)

            ExpensesByAllSection()
        }
        .width(100.percent)
    }
}