package ohos_app_cangjie_entry.components.expenses

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.runtime.RouteState
import ohos_app_cangjie_entry.state.getDailyDates

@Component
public class ExpensesByDaySection {
    public func build(): Unit {
        Column(space: 14) {
            Row(space: 12) {
                Text("Recent Transactions")
                    .fontSize(19)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(0xFF1C1B1F)
                    .width(58.percent)
                Button("See All")
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(0xFF6750A4)
                    .backgroundColor(0xFFF1EAFE)
                    .borderRadius(999)
                    .padding(left: 10, right: 10)
                    .onClick({ _ =>
                        RouteState.navigate("reports")
                    })
            }
            .width(100.percent)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            ExpenseDateGroupList(
                dates: getDailyDates(),
                recurrenceName: "Daily",
                allowDelete: true,
                emptyMessage: "No transactions recorded for today yet."
            )
        }
        .width(100.percent)
    }
}