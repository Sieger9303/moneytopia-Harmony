package ohos_app_cangjie_entry.components.expenses

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import std.collection.ArrayList
import ohos_app_cangjie_entry.data.local.PreferenceStore
import ohos_app_cangjie_entry.data.model.Expense
import ohos_app_cangjie_entry.utils.formatDay
import ohos_app_cangjie_entry.theme.AppTheme
import ohos_app_cangjie_entry.utils.formatExpenseMoney

@Component
public class ExpensesDayGroup {
    @Prop var title: String
    @Prop var expenses: ArrayList<Expense>
    @Prop var total: Float64
    @Prop var allowDelete: Bool

    private let preferenceStore = PreferenceStore()

    private func totalLabel(): String {
        let symbol = this.preferenceStore.getCurrencySymbol()
        return formatExpenseMoney(this.total, symbol)
    }

    public func build(): Unit {
        Column(space: 10) {
            Text(formatDay(this.title))
                .fontSize(17)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTheme.textPrimary())
                .padding(left: 4)

            ForEach(this.expenses, itemGeneratorFunc: { expense: Expense, _: Int64 =>
                ExpenseRow(expense: expense, allowDelete: this.allowDelete)
            }, keyGeneratorFunc: { expense: Expense, _: Int64 =>
                expense.id
            })

            Row(space: 12) {
                Row() {
                    Text("T")
                        .fontSize(15)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppTheme.brandPrimary())
                }
                .width(40)
                .height(40)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)
                .borderRadius(20)
                .backgroundColor(AppTheme.surfaceAccentStrong())

                Text("Total")
                    .fontSize(17)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTheme.textBrandStrong())
                    .width(52.percent)

                Text(this.totalLabel())
                    .fontSize(17)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTheme.textBrandStrong())
            }
            .padding(left: 14, right: 14, top: 14, bottom: 14)
            .width(100.percent)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .borderRadius(24)
            .backgroundColor(AppTheme.surfaceAccentSoft())
        }
        .width(100.percent)
    }
}