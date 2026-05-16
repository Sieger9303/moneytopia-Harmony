package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.runtime.RouteState
import ohos_app_cangjie_entry.components.categories.IconPickerDialog
import ohos_app_cangjie_entry.components.categories.resolveCategoryIcon
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

    public func build(): Unit {
        Scroll() {
            Column(space: 12) {
                Text("Categories")
                    .fontSize(24)

                TextInput(placeholder: "Category name", text: this.draftName)
                    .onChange({ text =>
                        this.draftName = text
                    })

                Text("Selected icon: ${resolveCategoryIcon(this.draftIcon)} ${this.draftIcon}")
                Button("Choose Icon")
                    .onClick({ _ =>
                        this.showIconPicker = true
                    })

                IconPickerDialog(selectedIcon: this.draftIcon, visible: this.showIconPicker, draftIcon: this.draftIcon)

                Button(this.submitLabel())
                    .enabled(this.draftName != "")
                    .onClick({ _ =>
                        if (this.editingId == "") {
                            this.expenseStore.addCategory(this.draftName, this.draftIcon)
                        } else {
                            this.expenseStore.updateCategory(this.editingId, this.draftName, this.draftIcon)
                            this.editingId = ""
                        }
                        this.draftName = ""
                        this.draftIcon = "Category"
                    })

                ForEach(this.expenseStore.getCategories(), itemGeneratorFunc: { category: Category, _: Int64 =>
                    Row() {
                        Column() {
                            Text("${resolveCategoryIcon(category.icon)} ${category.name}")
                            Text(category.icon)
                        }
                        Button("Edit")
                            .onClick({ _ =>
                                this.editingId = category.id
                                this.draftName = category.name
                                this.draftIcon = category.icon
                            })
                        Button("Delete")
                            .onClick({ _ =>
                                this.expenseStore.deleteCategory(category.id)
                                if (this.editingId == category.id) {
                                    this.editingId = ""
                                    this.draftName = ""
                                    this.draftIcon = "Category"
                                }
                            })
                    }
                }, keyGeneratorFunc: { category: Category, _: Int64 =>
                    category.id
                })

                Button("Back to Settings")
                    .onClick({ _ =>
                        RouteState.navigate("settings")
                    })
            }
            .padding(16)
        }
    }
}