package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.categories.IconPickerDialog
import ohos_app_cangjie_entry.components.categories.resolveCategoryIconName
import ohos_app_cangjie_entry.components.header.AppIcon
import ohos_app_cangjie_entry.components.header.HeaderCard
import ohos_app_cangjie_entry.data.local.ExpenseStore
import ohos_app_cangjie_entry.data.model.Category

@Component
public class CategoryPage {
    @State var draftName: String = ""
    @State var draftIcon: String = "Category"
    @State var editingId: String = ""
    @State var showIconPicker: Bool = false

    private let expenseStore = ExpenseStore()

    private func submitLabel(): String {
        if (this.editingId == "") {
            return "Add Category"
        }
        return "Save Category"
    }

    private func resetDraft(): Unit {
        this.editingId = ""
        this.draftName = ""
        this.draftIcon = "Category"
    }

    public func build(): Unit {
        Column(space: 16) {
            HeaderCard(
                title: "Categories",
                iconName: "categories",
                actionIconName: "info",
                subtitle: "Manage spending groups and icons",
                dialogText: "Add, edit, and delete categories. The icon picker stays wired to the shared category icon registry.",
                actionRoute: ""
            )

            Column(space: 10) {
                Text("Category Name")
                    .fontSize(14)
                    .fontColor(0xFF7B7388)
                TextInput(placeholder: "Category name", text: this.draftName)
                    .backgroundColor(0xFFFDF8FF)
                    .borderRadius(20)
                    .padding(left: 14, right: 14, top: 12, bottom: 12)
                    .onChange({ text =>
                        this.draftName = text
                    })
                Row(space: 10) {
                    Row() {
                        AppIcon(name: resolveCategoryIconName(this.draftIcon), size: 18, color: 0xFF6750A4)
                    }
                    .width(36)
                    .height(36)
                    .justifyContent(FlexAlign.Center)
                    .alignItems(VerticalAlign.Center)
                    .borderRadius(18)
                    .backgroundColor(0xFFEFE6FD)

                    Text("Selected icon: ${this.draftIcon}")
                        .fontSize(13)
                        .fontColor(0xFF1C1B1F)
                }
                .alignItems(VerticalAlign.Center)
                Row(space: 8) {
                    Button("Choose Icon")
                        .backgroundColor(0xFFF3EDF8)
                        .borderRadius(20)
                        .onClick({ _ =>
                            this.showIconPicker = true
                        })
                    Button(this.submitLabel())
                        .fontColor(0xFFFFFFFF)
                        .backgroundColor(0xFF6750A4)
                        .borderRadius(20)
                        .enabled(this.draftName != "")
                        .onClick({ _ =>
                            if (this.editingId == "") {
                                this.expenseStore.addCategory(this.draftName, this.draftIcon)
                            } else {
                                this.expenseStore.updateCategory(this.editingId, this.draftName, this.draftIcon)
                            }
                            this.resetDraft()
                        })
                }
                IconPickerDialog(selectedIcon: this.draftIcon, visible: this.showIconPicker, draftIcon: this.draftIcon)
            }
            .padding(left: 16, right: 16, top: 16, bottom: 16)
            .width(100.percent)
            .borderRadius(26)
            .backgroundColor(0xFFF8F1FF)

            ForEach(this.expenseStore.getCategories(), itemGeneratorFunc: { category: Category, _: Int64 =>
                Row(space: 12) {
                    Row() {
                        AppIcon(name: resolveCategoryIconName(category.icon), size: 18, color: 0xFF6750A4)
                    }
                    .width(42)
                    .height(42)
                    .justifyContent(FlexAlign.Center)
                    .alignItems(VerticalAlign.Center)
                    .borderRadius(14)
                    .backgroundColor(0xFFEFE6FD)

                    Column(space: 3) {
                        Text(category.name)
                            .fontSize(16)
                            .fontColor(0xFF1C1B1F)
                        Text(category.icon)
                            .fontSize(12)
                            .fontColor(0xFF7B7388)
                    }
                    .width(42.percent)
                    .alignItems(HorizontalAlign.Start)

                    Row(space: 6) {
                        Button("Edit")
                            .backgroundColor(0xFFF3EDF8)
                            .borderRadius(16)
                            .onClick({ _ =>
                                this.editingId = category.id
                                this.draftName = category.name
                                this.draftIcon = category.icon
                            })
                        Button("Delete")
                            .fontColor(0xFFC84C58)
                            .backgroundColor(0xFFFFF0F2)
                            .borderRadius(16)
                            .onClick({ _ =>
                                this.expenseStore.deleteCategory(category.id)
                                if (this.editingId == category.id) {
                                    this.resetDraft()
                                }
                            })
                    }
                }
                .padding(left: 14, right: 14, top: 14, bottom: 14)
                .width(100.percent)
                .alignItems(VerticalAlign.Center)
                .justifyContent(FlexAlign.SpaceBetween)
                .borderRadius(24)
                .backgroundColor(0xFFFDF8FF)
            }, keyGeneratorFunc: { category: Category, _: Int64 =>
                category.id
            })
        }
        .width(100.percent)
    }
}