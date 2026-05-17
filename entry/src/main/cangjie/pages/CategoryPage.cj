package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.categories.IconPickerDialog
import ohos_app_cangjie_entry.components.categories.resolveCategoryIconName
import ohos_app_cangjie_entry.components.header.AppIcon
import ohos_app_cangjie_entry.components.header.HeaderCard
import ohos_app_cangjie_entry.data.local.ExpenseStore
import ohos_app_cangjie_entry.data.model.Category
import ohos_app_cangjie_entry.runtime.RouteState

@Component
public class CategoryPage {
    @State var draftName: String = ""
    @State var draftIcon: String = "Category"
    @State var editingId: String = ""
    @State var editingLabel: String = ""
    @State var deleteId: String = ""
    @State var deleteLabel: String = ""
    @State var showAddDialog: Bool = false
    @State var showEditDialog: Bool = false
    @State var showDeleteDialog: Bool = false
    @State var showIconPicker: Bool = false

    private let expenseStore = ExpenseStore()

    private func resetDraft(): Unit {
        this.draftName = ""
        this.draftIcon = "Category"
        this.editingId = ""
        this.editingLabel = ""
    }

    private func openAddDialog(): Unit {
        this.resetDraft()
        this.showAddDialog = true
        this.showEditDialog = false
        this.showDeleteDialog = false
    }

    private func openEditDialog(category: Category): Unit {
        this.editingId = category.id
        this.editingLabel = category.name
        this.draftName = category.name
        this.draftIcon = category.icon
        this.showEditDialog = true
        this.showAddDialog = false
        this.showDeleteDialog = false
    }

    private func openDeleteDialog(category: Category): Unit {
        this.deleteId = category.id
        this.deleteLabel = category.name
        this.showDeleteDialog = true
        this.showAddDialog = false
        this.showEditDialog = false
    }

    private func submitAdd(): Unit {
        if (this.draftName == "") {
            return
        }
        this.expenseStore.addCategory(this.draftName, this.draftIcon)
        this.showAddDialog = false
        this.resetDraft()
    }

    private func submitEdit(): Unit {
        if (this.editingId == "" || this.draftName == "") {
            return
        }
        this.expenseStore.updateCategory(this.editingId, this.draftName, this.draftIcon)
        this.showEditDialog = false
        this.resetDraft()
    }

    private func confirmDelete(): Unit {
        if (this.deleteId == "") {
            return
        }
        this.expenseStore.deleteCategory(this.deleteId)
        if (this.editingId == this.deleteId) {
            this.resetDraft()
        }
        this.deleteId = ""
        this.deleteLabel = ""
        this.showDeleteDialog = false
    }

    public func build(): Unit {
        Column(space: 16) {
            HeaderCard(
                title: "Categories",
                iconName: "categories",
                actionIconName: "info",
                subtitle: "Manage spending groups and icons",
                dialogText: "Add, edit, and delete categories. Selecting an icon updates the same category list used by Add Expense and expense rows.",
                actionRoute: ""
            )

            Row(space: 10) {
                Button("Back")
                    .width(48.percent)
                    .backgroundColor(0xFFF3EDF8)
                    .borderRadius(20)
                    .onClick({ _ =>
                        RouteState.navigate("settings")
                    })
                Button("Add Category")
                    .width(48.percent)
                    .fontColor(0xFFFFFFFF)
                    .backgroundColor(0xFF6750A4)
                    .borderRadius(20)
                    .onClick({ _ =>
                        this.openAddDialog()
                    })
            }
            .width(100.percent)
            .justifyContent(FlexAlign.SpaceBetween)

            if (this.showAddDialog || this.showEditDialog) {
                Column(space: 10) {
                    Text(if (this.showEditDialog) { "Edit Category" } else { "Add Category" })
                        .fontSize(18)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(0xFF1C1B1F)
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
                        Button("Cancel")
                            .backgroundColor(0xFFF3EDF8)
                            .borderRadius(20)
                            .onClick({ _ =>
                                this.showAddDialog = false
                                this.showEditDialog = false
                                this.resetDraft()
                            })
                        Button(if (this.showEditDialog) { "Save" } else { "Add" })
                            .fontColor(0xFFFFFFFF)
                            .backgroundColor(0xFF6750A4)
                            .borderRadius(20)
                            .enabled(this.draftName != "")
                            .onClick({ _ =>
                                if (this.showEditDialog) {
                                    this.submitEdit()
                                } else {
                                    this.submitAdd()
                                }
                            })
                    }
                    IconPickerDialog(selectedIcon: this.draftIcon, visible: this.showIconPicker, draftIcon: this.draftIcon)
                }
                .padding(left: 16, right: 16, top: 16, bottom: 16)
                .width(100.percent)
                .borderRadius(26)
                .backgroundColor(0xFFF8F1FF)
            }

            if (this.showDeleteDialog) {
                Column(space: 10) {
                    Text("Delete Category")
                        .fontSize(18)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(0xFF1C1B1F)
                    Text("Are you sure you want to delete ${this.deleteLabel}?")
                        .fontSize(13)
                        .fontColor(0xFF5F596B)
                    Row(space: 8) {
                        Button("Cancel")
                            .backgroundColor(0xFFF3EDF8)
                            .borderRadius(18)
                            .onClick({ _ =>
                                this.showDeleteDialog = false
                                this.deleteId = ""
                                this.deleteLabel = ""
                            })
                        Button("Delete")
                            .fontColor(0xFFFFFFFF)
                            .backgroundColor(0xFFC84C58)
                            .borderRadius(18)
                            .onClick({ _ =>
                                this.confirmDelete()
                            })
                    }
                }
                .padding(16)
                .width(100.percent)
                .borderRadius(22)
                .backgroundColor(0xFFFFF8F8)
            }

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
                                this.openEditDialog(category)
                            })
                        Button("Delete")
                            .fontColor(0xFFC84C58)
                            .backgroundColor(0xFFFFF0F2)
                            .borderRadius(16)
                            .onClick({ _ =>
                                this.openDeleteDialog(category)
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