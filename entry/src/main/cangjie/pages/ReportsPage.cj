package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.header.HeaderCard
import ohos_app_cangjie_entry.components.expenses.ExpensesByAllSection
import ohos_app_cangjie_entry.state.getYearlyExpenseCount
import ohos_app_cangjie_entry.state.getYearlyDateCount

@Component
public class ReportsPage {
    public func build(): Unit {
        Column(space: 16) {
            HeaderCard(title: "Reports", iconGlyph: "R", infoGlyph: "i", subtitle: "Review grouped expense history")

            Row(space: 12) {
                Column(space: 4) {
                    Text("Transactions")
                        .fontSize(12)
                        .fontColor(0xFF7B7388)
                    Text("${getYearlyExpenseCount()}")
                        .fontSize(22)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(0xFF1C1B1F)
                }
                .width(48.percent)
                .padding(left: 18, right: 18, top: 18, bottom: 18)
                .borderRadius(24)
                .backgroundColor(0xFFFDF8FF)

                Column(space: 4) {
                    Text("Days")
                        .fontSize(12)
                        .fontColor(0xFF7B7388)
                    Text("${getYearlyDateCount()}")
                        .fontSize(22)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(0xFF1C1B1F)
                }
                .width(48.percent)
                .padding(left: 18, right: 18, top: 18, bottom: 18)
                .borderRadius(24)
                .backgroundColor(0xFFFDF8FF)
            }
            .width(100.percent)

            ExpensesByAllSection()
        }
        .width(100.percent)
    }
}