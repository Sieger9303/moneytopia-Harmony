package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.header.HeaderCard
import ohos_app_cangjie_entry.components.expenses.ExpensesByAllSection

@Component
public class ReportsPage {
    public func build(): Unit {
        Scroll() {
            Column(space: 16) {
                HeaderCard(title: "Reports", iconName: "report", actionIconName: "info", subtitle: "Review grouped expense history", dialogText: "Reports shows grouped yearly history and keeps the non-delete behavior from the source report screen.", actionRoute: "")

                ExpensesByAllSection()

                Blank()
                    .height(120)
                    .width(100.percent)
            }
            .padding(left: 16, right: 16, top: 18, bottom: 12)
            .width(100.percent)
        }
        .scrollBar(BarState.Off)
        .width(100.percent)
        .height(100.percent)
    }
}