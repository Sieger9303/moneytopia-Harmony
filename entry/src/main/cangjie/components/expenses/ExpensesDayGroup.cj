package ohos_app_cangjie_entry.components.expenses

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import std.collection.ArrayList
import ohos_app_cangjie_entry.data.local.PreferenceStore
import ohos_app_cangjie_entry.data.model.Expense
import ohos_app_cangjie_entry.utils.formatDay

@Component
public class ExpensesDayGroup {
    @Prop var title: String
    @Prop var expenses: ArrayList<Expense>
    @Prop var total: Float64
    @Prop var allowDelete: Bool

    private let preferenceStore = PreferenceStore()

    private func totalLabel(): String {
        "- ${this.preferenceStore.getCurrencySymbol()}${this.total}"
    }

    public func build(): Unit {
        Column(space: 10) {
            Text(formatDay(this.title))
                .fontSize(17)
                .fontWeight(FontWeight.Medium)
                .fontColor(0xFF1C1B1F)
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
                        .fontColor(0xFF6750A4)
                }
                .width(40)
                .height(40)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)
                .borderRadius(20)
                .backgroundColor(0xFFE8DDFF)

                Text("Total")
                    .fontSize(17)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(0xFF403457)
                    .width(52.percent)

                Text(this.totalLabel())
                    .fontSize(17)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(0xFF403457)
            }
            .padding(left: 14, right: 14, top: 14, bottom: 14)
            .width(100.percent)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .borderRadius(24)
            .backgroundColor(0xFFF1E7FF)
        }
        .width(100.percent)
    }
}