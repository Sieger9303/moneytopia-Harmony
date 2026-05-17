package ohos_app_cangjie_entry.components.expenses

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.runtime.RouteState
import ohos_app_cangjie_entry.state.getDailyDates
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class ExpensesByDaySection {
    public func build(): Unit {
        Column(space: 14) {
            Row(space: 12) {
                Text("Recent Transactions")
                    .fontSize(19)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTheme.textPrimary())
                    .width(58.percent)
                Button("See All")
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTheme.brandPrimary())
                    .backgroundColor(AppTheme.surfaceInteractive())
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