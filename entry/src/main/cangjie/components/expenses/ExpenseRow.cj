package ohos_app_cangjie_entry.components.expenses

import std.time.*
import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.categories.resolveCategoryIconName
import ohos_app_cangjie_entry.components.header.AppIcon
import ohos_app_cangjie_entry.data.local.ExpenseStore
import ohos_app_cangjie_entry.data.local.PreferenceStore
import ohos_app_cangjie_entry.data.model.Expense
import ohos_app_cangjie_entry.theme.AppTheme

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
        "- "
    }

    private func noteLabel(): String {
        if (this.expense.note != "") {
            return this.expense.note
        }
        return "No note added"
    }

    private func categoryIconName(): String {
        for (category in this.expenseStore.getCategories()) {
            if (category.name == this.expense.category) {
                return resolveCategoryIconName(category.icon)
            }
        }
        return resolveCategoryIconName("Category")
    }

    public func build(): Unit {
        Column(space: 10) {
            Row(space: 12) {
                Row() {
                    AppIcon(name: this.categoryIconName(), size: 18, color: Int64(AppTheme.brandPrimary()))
                }
                .width(48)
                .height(48)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)
                .borderRadius(16)
                .backgroundColor(AppTheme.surfaceInteractive())

                Column(space: 4) {
                    Text(this.expense.category)
                        .fontSize(16)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppTheme.textPrimary())
                    Text(this.noteLabel())
                        .fontSize(12)
                        .fontColor(AppTheme.textSecondary())
                }
                .width(50.percent)
                .alignItems(HorizontalAlign.Start)

                Column(space: 4) {
                    Text(this.amountLabel())
                        .fontSize(15)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppTheme.dangerPrimary())
                    Text(this.timeLabel())
                        .fontSize(12)
                        .fontColor(AppTheme.textSecondary())
                }
                .alignItems(HorizontalAlign.End)
            }
            .width(100.percent)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            if (this.allowDelete && !this.showDeletePrompt) {
                Row(space: 6) {
                    AppIcon(name: "delete", size: 14, color: Int64(AppTheme.dangerPrimary()))
                    Text("Delete")
                        .fontSize(12)
                        .fontColor(AppTheme.dangerPrimary())
                }
                .padding(left: 12, right: 12, top: 8, bottom: 8)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)
                .borderRadius(16)
                .backgroundColor(AppTheme.surfaceDangerSoft())
                .onClick({ _ =>
                    this.showDeletePrompt = true
                })
                .width(100.percent)
            }

            if (this.showDeletePrompt) {
                Column(space: 8) {
                    Text("Delete transaction?")
                        .fontSize(12)
                        .fontColor(AppTheme.textSecondary())
                    Row(space: 8) {
                        Button("Cancel")
                            .fontSize(12)
                            .backgroundColor(AppTheme.surfaceSecondary())
                            .fontColor(AppTheme.textPrimary())
                            .borderRadius(16)
                            .onClick({ _ =>
                                this.showDeletePrompt = false
                            })
                        Button("Delete")
                            .fontSize(12)
                            .fontColor(AppTheme.onBrandPrimary())
                            .backgroundColor(AppTheme.dangerPrimary())
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
                .backgroundColor(AppTheme.surfaceDangerPanel())
            }
        }
        .padding(left: 16, right: 16, top: 16, bottom: 16)
        .width(100.percent)
        .borderRadius(24)
        .backgroundColor(AppTheme.surfacePrimary())
    }
}