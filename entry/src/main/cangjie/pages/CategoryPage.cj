package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import std.collection.ArrayList
import ohos_app_cangjie_entry.components.categories.IconPickerDialog
import ohos_app_cangjie_entry.components.categories.resolveCategoryIconName
import ohos_app_cangjie_entry.components.header.AppIcon
import ohos_app_cangjie_entry.components.header.HeaderCard
import ohos_app_cangjie_entry.data.local.ExpenseStore
import ohos_app_cangjie_entry.data.model.Category
import ohos_app_cangjie_entry.runtime.RouteState
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class CategoryPage {
    @State var categories: ArrayList<Category> = ArrayList<Category>()
    @State var draftName: String = ""
    @State var draftIcon: String = "Category"
    @State var editingId: String = ""
    @State var editingLabel: String = ""
    @State var deleteId: String = ""
    @State var deleteLabel: String = ""
    @State var refreshVersion: Int64 = 0
    @State var showAddDialog: Bool = false
    @State var showEditDialog: Bool = false
    @State var showDeleteDialog: Bool = false
    @State var showIconPicker: Bool = false

    private let expenseStore = ExpenseStore()

    private func reloadCategories(): Unit {
        let refreshed = ArrayList<Category>()
        for (category in this.expenseStore.getCategories()) {
            refreshed.add(Category(id: category.id, name: category.name, icon: category.icon))
        }
        this.categories = refreshed
        this.refreshVersion += 1
    }

    private func anyDialogVisible(): Bool {
        this.showAddDialog || this.showEditDialog || this.showDeleteDialog || this.showIconPicker
    }

    private func resetDraft(): Unit {
        this.draftName = ""
        this.draftIcon = "Category"
        this.editingId = ""
        this.editingLabel = ""
        this.showIconPicker = false
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
        this.showIconPicker = false
    }

    private func openDeleteDialog(category: Category): Unit {
        this.deleteId = category.id
        this.deleteLabel = category.name
        this.showDeleteDialog = true
        this.showAddDialog = false
        this.showEditDialog = false
        this.showIconPicker = false
    }

    private func submitAdd(): Unit {
        if (this.draftName == "") {
            return
        }
        this.expenseStore.addCategory(this.draftName, this.draftIcon)
        this.reloadCategories()
        this.showAddDialog = false
        this.resetDraft()
    }

    private func submitEdit(): Unit {
        if (this.editingId == "" || this.draftName == "") {
            return
        }
        this.expenseStore.updateCategory(this.editingId, this.draftName, this.draftIcon)
        this.reloadCategories()
        this.showEditDialog = false
        this.resetDraft()
    }

    private func confirmDelete(): Unit {
        if (this.deleteId == "") {
            return
        }
        this.expenseStore.deleteCategory(this.deleteId)
        this.reloadCategories()
        if (this.editingId == this.deleteId) {
            this.resetDraft()
        }
        this.deleteId = ""
        this.deleteLabel = ""
        this.showDeleteDialog = false
    }

    private func closeEditors(): Unit {
        this.showAddDialog = false
        this.showEditDialog = false
        this.showIconPicker = false
        this.resetDraft()
    }

    public func aboutToAppear(): Unit {
        this.reloadCategories()
    }

    public func build(): Unit {
        Stack() {
            Scroll() {
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
                            .backgroundColor(AppTheme.surfaceSecondary())
                            .fontColor(AppTheme.textPrimary())
                            .borderRadius(20)
                            .onClick({ _ =>
                                RouteState.navigate("settings")
                            })
                        Button("Add Category")
                            .width(48.percent)
                            .fontColor(AppTheme.onBrandPrimary())
                            .backgroundColor(AppTheme.brandPrimary())
                            .borderRadius(20)
                            .onClick({ _ =>
                                this.openAddDialog()
                            })
                    }
                    .width(100.percent)
                    .justifyContent(FlexAlign.SpaceBetween)

                    ForEach(this.categories, itemGeneratorFunc: { category: Category, _: Int64 =>
                        Row(space: 12) {
                            Row() {
                                AppIcon(name: resolveCategoryIconName(category.icon), size: 18, color: Int64(AppTheme.brandPrimary()))
                            }
                            .width(42)
                            .height(42)
                            .justifyContent(FlexAlign.Center)
                            .alignItems(VerticalAlign.Center)
                            .borderRadius(14)
                            .backgroundColor(AppTheme.surfaceAccentSoft())

                            Column(space: 3) {
                                Text(category.name)
                                    .fontSize(16)
                                    .fontColor(AppTheme.textPrimary())
                                Text(category.icon)
                                    .fontSize(12)
                                    .fontColor(AppTheme.textSecondary())
                            }
                            .width(42.percent)
                            .alignItems(HorizontalAlign.Start)

                            Row(space: 6) {
                                Button("Edit")
                                    .backgroundColor(AppTheme.surfaceSecondary())
                                    .fontColor(AppTheme.textPrimary())
                                    .borderRadius(16)
                                    .onClick({ _ =>
                                        this.openEditDialog(category)
                                    })
                                Button("Delete")
                                    .fontColor(AppTheme.dangerPrimary())
                                    .backgroundColor(AppTheme.surfaceDangerSoft())
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
                        .backgroundColor(AppTheme.surfacePrimary())
                    }, keyGeneratorFunc: { category: Category, _: Int64 =>
                        "${category.id}-${this.refreshVersion}"
                    })
                }
                .width(100.percent)
            }
            .scrollBar(BarState.Off)
            .width(100.percent)
            .height(100.percent)

            if (this.anyDialogVisible()) {
                Column() {
                    Column(space: 12) {
                        if (this.showAddDialog || this.showEditDialog) {
                            Column(space: 10) {
                                Text(if (this.showEditDialog) { "Edit Category" } else { "Add Category" })
                                    .fontSize(18)
                                    .fontWeight(FontWeight.Medium)
                                    .fontColor(AppTheme.textPrimary())
                                TextInput(placeholder: "Category name", text: this.draftName)
                                    .backgroundColor(AppTheme.surfacePrimary())
                                    .fontColor(AppTheme.textPrimary())
                                    .borderRadius(20)
                                    .padding(left: 14, right: 14, top: 12, bottom: 12)
                                    .onChange({ text =>
                                        this.draftName = text
                                    })
                                Row(space: 10) {
                                    Row() {
                                        AppIcon(name: resolveCategoryIconName(this.draftIcon), size: 18, color: Int64(AppTheme.brandPrimary()))
                                    }
                                    .width(36)
                                    .height(36)
                                    .justifyContent(FlexAlign.Center)
                                    .alignItems(VerticalAlign.Center)
                                    .borderRadius(18)
                                    .backgroundColor(AppTheme.surfaceAccentSoft())
                                    Column(space: 2) {
                                        Text("Selected icon:")
                                            .fontSize(13)
                                            .fontColor(AppTheme.textPrimary())
                                        Text(this.draftIcon)
                                            .fontSize(12)
                                            .fontColor(AppTheme.textSecondary())
                                    }
                                    .alignItems(HorizontalAlign.Start)
                                }
                                .alignItems(VerticalAlign.Center)
                                Row(space: 8) {
                                    Button("Choose Icon")
                                        .backgroundColor(AppTheme.surfaceSecondary())
                                        .fontColor(AppTheme.textPrimary())
                                        .borderRadius(20)
                                        .onClick({ _ =>
                                            this.showIconPicker = true
                                        })
                                    Button("Cancel")
                                        .backgroundColor(AppTheme.surfaceSecondary())
                                        .fontColor(AppTheme.textPrimary())
                                        .borderRadius(20)
                                        .onClick({ _ =>
                                            this.closeEditors()
                                        })
                                    Button(if (this.showEditDialog) { "Save" } else { "Add" })
                                        .fontColor(AppTheme.onBrandPrimary())
                                        .backgroundColor(AppTheme.brandPrimary())
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
                            }
                        }

                        if (this.showDeleteDialog) {
                            Column(space: 10) {
                                Text("Delete Category")
                                    .fontSize(18)
                                    .fontWeight(FontWeight.Medium)
                                    .fontColor(AppTheme.textPrimary())
                                Text("Are you sure you want to delete ${this.deleteLabel}?")
                                    .fontSize(13)
                                    .fontColor(AppTheme.textTertiary())
                                Row(space: 8) {
                                    Button("Cancel")
                                        .backgroundColor(AppTheme.surfaceSecondary())
                                        .fontColor(AppTheme.textPrimary())
                                        .borderRadius(18)
                                        .onClick({ _ =>
                                            this.showDeleteDialog = false
                                            this.deleteId = ""
                                            this.deleteLabel = ""
                                        })
                                    Button("Delete")
                                        .fontColor(AppTheme.onBrandPrimary())
                                        .backgroundColor(AppTheme.dangerPrimary())
                                        .borderRadius(18)
                                        .onClick({ _ =>
                                            this.confirmDelete()
                                        })
                                }
                            }
                        }

                        if (this.showIconPicker) {
                            IconPickerDialog(selectedIcon: this.draftIcon, visible: this.showIconPicker, draftIcon: this.draftIcon)
                        }
                    }
                    .width(88.percent)
                    .padding(left: 18, right: 18, top: 18, bottom: 18)
                    .borderRadius(28)
                    .backgroundColor(AppTheme.surfaceElevated())
                }
                .width(100.percent)
                .height(100.percent)
                .alignItems(HorizontalAlign.Center)
                .justifyContent(FlexAlign.Center)
                .padding(left: 16, right: 16, top: 16, bottom: 16)
                .backgroundColor(AppTheme.surfaceSecondary())
            }
        }
        .width(100.percent)
        .height(100.percent)
    }
}
