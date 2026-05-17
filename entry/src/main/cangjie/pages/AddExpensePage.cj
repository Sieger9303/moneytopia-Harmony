package ohos_app_cangjie_entry.pages

import std.convert.*
import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.runtime.RouteState
import ohos_app_cangjie_entry.components.header.HeaderCard
import ohos_app_cangjie_entry.data.local.ExpenseStore
import ohos_app_cangjie_entry.data.model.Category
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class AddExpensePage {
    @State var amount: String = ""
    @State var note: String = ""
    @State var selectedCategory: String = ""
    @State var selectedDate: String = ExpenseStore.todayDateKey()
    @State var selectedRecurrence: String = "None"
    @State var savedMessage: String = ""
    @State var showDiscardDialog: Bool = false

    private let expenseStore = ExpenseStore()
    private let maxAmountChars: Int64 = 10
    private let maxNoteChars: Int64 = 20

    private func isDirty(): Bool {
        this.amount != "" || this.note != "" || this.selectedCategory != "" || this.selectedDate != ExpenseStore.todayDateKey() || this.selectedRecurrence != "None"
    }

    private func resetForm(): Unit {
        this.amount = ""
        this.note = ""
        this.selectedCategory = ""
        this.selectedDate = ExpenseStore.todayDateKey()
        this.selectedRecurrence = "None"
    }

    private func choosePreviousDate(): Unit {
        this.selectedDate = this.expenseStore.previousDateKey(this.selectedDate)
    }

    private func chooseNextDate(): Unit {
        let todayKey = ExpenseStore.todayDateKey()
        if (this.selectedDate < todayKey) {
            this.selectedDate = this.expenseStore.nextDateKey(this.selectedDate)
        }
    }

    private func saveExpense(): Unit {
        if (this.amount == "") {
            this.savedMessage = "Enter a valid amount"
            return
        }
        if (this.selectedCategory == "") {
            this.savedMessage = "Choose a category first"
            return
        }
        let parsedAmount = Float64.parse(this.amount)
        if (parsedAmount <= 0.0) {
            this.savedMessage = "Enter a valid amount"
            return
        }
        let expense = this.expenseStore.createExpense(parsedAmount, this.selectedCategory, this.selectedDate, this.selectedRecurrence, this.note)
        this.expenseStore.addExpense(expense)
        this.savedMessage = "Transaction saved"
        this.resetForm()
        RouteState.navigate("expenses")
    }

    private func optionText(selected: Bool): UInt32 {
        if (selected) {
            return AppTheme.onBrandPrimary()
        }
        return AppTheme.brandPrimary()
    }

    private func optionSurface(selected: Bool): UInt32 {
        if (selected) {
            return AppTheme.brandPrimary()
        }
        return AppTheme.surfaceInteractive()
    }

    public func build(): Unit {
        Column(space: 16) {
            HeaderCard(title: "Add Expense", iconName: "add", actionIconName: "", subtitle: "Create a new transaction", dialogText: "", actionRoute: "")

            Row(space: 8) {
                Button("Discard")
                    .width(48.percent)
                    .backgroundColor(AppTheme.surfaceSecondary())
                    .fontColor(AppTheme.textPrimary())
                    .borderRadius(20)
                    .onClick({ _ =>
                        if (this.isDirty()) {
                            this.showDiscardDialog = true
                        } else {
                            RouteState.navigate("expenses")
                        }
                    })
                Button("Save")
                    .width(48.percent)
                    .fontColor(AppTheme.onBrandPrimary())
                    .backgroundColor(AppTheme.brandPrimary())
                    .borderRadius(20)
                    .enabled(this.amount != "" && this.selectedCategory != "")
                    .onClick({ _ =>
                        this.saveExpense()
                    })
            }
            .width(100.percent)
            .justifyContent(FlexAlign.SpaceBetween)

            Column(space: 14) {
                Text("Amount")
                    .fontSize(14)
                    .fontColor(AppTheme.textSecondary())
                TextInput(placeholder: "0", text: this.amount)
                    .backgroundColor(AppTheme.surfacePrimary())
                    .fontColor(AppTheme.textPrimary())
                    .borderRadius(20)
                    .padding(left: 14, right: 14, top: 12, bottom: 12)
                    .onChange({ text =>
                        if (text.size <= this.maxAmountChars) {
                            this.amount = text
                        }
                    })

                Text("Category")
                    .fontSize(14)
                    .fontColor(AppTheme.textSecondary())
                Text(if (this.selectedCategory == "") { "Choose a category below" } else { "Selected: " })
                    .fontSize(13)
                    .fontColor(AppTheme.textPrimary())

                ForEach(this.expenseStore.getCategories(), itemGeneratorFunc: { category: Category, _: Int64 =>
                    Button(category.name)
                        .width(100.percent)
                        .fontColor(this.optionText(this.selectedCategory == category.name))
                        .backgroundColor(this.optionSurface(this.selectedCategory == category.name))
                        .borderRadius(20)
                        .onClick({ _ =>
                            this.selectedCategory = category.name
                        })
                }, keyGeneratorFunc: { category: Category, _: Int64 =>
                    category.id
                })

                Text("Date")
                    .fontSize(14)
                    .fontColor(AppTheme.textSecondary())
                Row(space: 8) {
                    Button("Previous")
                        .backgroundColor(AppTheme.surfaceSecondary())
                        .fontColor(AppTheme.textPrimary())
                        .borderRadius(20)
                        .onClick({ _ =>
                            this.choosePreviousDate()
                        })
                    Text(this.selectedDate)
                        .fontSize(14)
                        .fontColor(AppTheme.textPrimary())
                    Button("Next")
                        .backgroundColor(AppTheme.surfaceSecondary())
                        .fontColor(AppTheme.textPrimary())
                        .borderRadius(20)
                        .enabled(this.selectedDate < ExpenseStore.todayDateKey())
                        .onClick({ _ =>
                            this.chooseNextDate()
                        })
                }
                .padding(left: 12, right: 12, top: 12, bottom: 12)
                .width(100.percent)
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center)
                .borderRadius(18)
                .backgroundColor(AppTheme.surfacePrimary())

                Text("Recurrence")
                    .fontSize(14)
                    .fontColor(AppTheme.textSecondary())
                Row(space: 6) {
                    Button("None").backgroundColor(this.optionSurface(this.selectedRecurrence == "None")).fontColor(this.optionText(this.selectedRecurrence == "None")).borderRadius(999).onClick({ _ => this.selectedRecurrence = "None" })
                    Button("Daily").backgroundColor(this.optionSurface(this.selectedRecurrence == "Daily")).fontColor(this.optionText(this.selectedRecurrence == "Daily")).borderRadius(999).onClick({ _ => this.selectedRecurrence = "Daily" })
                    Button("Weekly").backgroundColor(this.optionSurface(this.selectedRecurrence == "Weekly")).fontColor(this.optionText(this.selectedRecurrence == "Weekly")).borderRadius(999).onClick({ _ => this.selectedRecurrence = "Weekly" })
                }
                Row(space: 6) {
                    Button("Monthly").backgroundColor(this.optionSurface(this.selectedRecurrence == "Monthly")).fontColor(this.optionText(this.selectedRecurrence == "Monthly")).borderRadius(999).onClick({ _ => this.selectedRecurrence = "Monthly" })
                    Button("Yearly").backgroundColor(this.optionSurface(this.selectedRecurrence == "Yearly")).fontColor(this.optionText(this.selectedRecurrence == "Yearly")).borderRadius(999).onClick({ _ => this.selectedRecurrence = "Yearly" })
                }

                Text("Note")
                    .fontSize(14)
                    .fontColor(AppTheme.textSecondary())
                TextInput(placeholder: "Optional note", text: this.note)
                    .backgroundColor(AppTheme.surfacePrimary())
                    .fontColor(AppTheme.textPrimary())
                    .borderRadius(20)
                    .padding(left: 14, right: 14, top: 12, bottom: 12)
                    .onChange({ text =>
                        if (text.size <= this.maxNoteChars) {
                            this.note = text
                        }
                    })
                Text("/")
                    .fontSize(12)
                    .fontColor(AppTheme.textSecondary())
            }
            .padding(left: 16, right: 16, top: 16, bottom: 16)
            .width(100.percent)
            .borderRadius(26)
            .backgroundColor(AppTheme.surfaceSelected())

            if (this.showDiscardDialog) {
                Column(space: 8) {
                    Text("Discard transaction?")
                        .fontSize(14)
                        .fontColor(AppTheme.textPrimary())
                    Row(space: 8) {
                        Button("Cancel").backgroundColor(AppTheme.surfaceSecondary()).fontColor(AppTheme.textPrimary()).borderRadius(18).onClick({ _ => this.showDiscardDialog = false })
                        Button("Discard").fontColor(AppTheme.onBrandPrimary()).backgroundColor(AppTheme.dangerPrimary()).borderRadius(18).onClick({ _ =>
                            this.showDiscardDialog = false
                            this.resetForm()
                            RouteState.navigate("expenses")
                        })
                    }
                }
                .padding(14)
                .width(100.percent)
                .borderRadius(22)
                .backgroundColor(AppTheme.surfaceElevated())
            }

            if (this.savedMessage != "") {
                Text(this.savedMessage)
                    .fontSize(12)
                    .fontColor(AppTheme.textSecondary())
            }
        }
        .width(100.percent)
    }
}