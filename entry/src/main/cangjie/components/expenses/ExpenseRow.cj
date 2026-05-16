package ohos_app_cangjie_entry.components.expenses

import std.time.*
import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.data.local.ExpenseStore
import ohos_app_cangjie_entry.data.local.PreferenceStore
import ohos_app_cangjie_entry.data.model.Expense

@Component
public class ExpenseRow {
    @Prop var expense: Expense
    @Prop var allowDelete: Bool

    @State var showDeletePrompt: Bool = false

    private let expenseStore = ExpenseStore()
    private let preferenceStore = PreferenceStore()

    private func timeLabel(): String {
        DateTime.parse(this.expense.dateValue, "yyyy-MM-dd HH:mm:ss").format("HH:mm")
    }

    private func amountLabel(): String {
        "- ${this.preferenceStore.getCurrencySymbol()}${this.expense.amount}"
    }

    private func noteLabel(): String {
        if (this.expense.note != "") {
            return this.expense.note
        }
        return "No note added"
    }

    private func categoryGlyph(): String {
        if (this.expense.category.size > 0) {
            return "${this.expense.category[0]}"
        }
        return "C"
    }

    public func build(): Unit {
        Column(space: 10) {
            Row(space: 12) {
                Row() {
                    Text(this.categoryGlyph())
                        .fontSize(16)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(0xFF6750A4)
                }
                .width(48)
                .height(48)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)
                .borderRadius(16)
                .backgroundColor(0xFFF2E9FF)

                Column(space: 4) {
                    Text(this.expense.category)
                        .fontSize(16)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(0xFF1C1B1F)
                    Text(this.noteLabel())
                        .fontSize(12)
                        .fontColor(0xFF7B7388)
                }
                .width(50.percent)
                .alignItems(HorizontalAlign.Start)

                Column(space: 4) {
                    Text(this.amountLabel())
                        .fontSize(15)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(0xFFC84C58)
                    Text(this.timeLabel())
                        .fontSize(12)
                        .fontColor(0xFF7B7388)
                }
                .alignItems(HorizontalAlign.End)
            }
            .width(100.percent)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            if (this.allowDelete && !this.showDeletePrompt) {
                Row() {
                    Button("Delete")
                        .fontSize(12)
                        .fontColor(0xFFC84C58)
                        .backgroundColor(0xFFFFF0F2)
                        .borderRadius(16)
                        .onClick({ _ =>
                            this.showDeletePrompt = true
                        })
                }
                .width(100.percent)
                .justifyContent(FlexAlign.End)
            }

            if (this.showDeletePrompt) {
                Column(space: 8) {
                    Text("Delete transaction?")
                        .fontSize(12)
                        .fontColor(0xFF7B7388)
                    Row(space: 8) {
                        Button("Cancel")
                            .fontSize(12)
                            .backgroundColor(0xFFF3EDF8)
                            .borderRadius(16)
                            .onClick({ _ =>
                                this.showDeletePrompt = false
                            })
                        Button("Delete")
                            .fontSize(12)
                            .fontColor(0xFFFFFFFF)
                            .backgroundColor(0xFFC84C58)
                            .borderRadius(16)
                            .onClick({ _ =>
                                this.expenseStore.deleteExpense(this.expense.id)
                                this.showDeletePrompt = false
                            })
                    }
                }
                .padding(12)
                .width(100.percent)
                .borderRadius(18)
                .backgroundColor(0xFFFFF8F8)
            }
        }
        .padding(left: 16, right: 16, top: 16, bottom: 16)
        .width(100.percent)
        .borderRadius(24)
        .backgroundColor(0xFFFDF8FF)
    }
}