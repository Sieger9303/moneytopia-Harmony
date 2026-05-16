package ohos_app_cangjie_entry.pages

import std.convert.*
import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.runtime.RouteState
import ohos_app_cangjie_entry.components.header.HeaderCard
import ohos_app_cangjie_entry.data.local.ExpenseStore
import ohos_app_cangjie_entry.data.model.Category

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

    public func build(): Unit {
        Column(space: 16) {
            HeaderCard(title: "Add Expense", iconGlyph: "+", infoGlyph: "x", subtitle: "Create a new transaction")

            Row(space: 8) {
                Button("Discard")
                    .width(48.percent)
                    .backgroundColor(0xFFF3EDF8)
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
                    .fontColor(0xFFFFFFFF)
                    .backgroundColor(0xFF6750A4)
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
                    .fontColor(0xFF7B7388)
                TextInput(placeholder: "0", text: this.amount)
                    .backgroundColor(0xFFFDF8FF)
                    .borderRadius(20)
                    .padding(left: 14, right: 14, top: 12, bottom: 12)
                    .onChange({ text =>
                        if (text.size <= this.maxAmountChars) {
                            this.amount = text
                        }
                    })

                Text("Category")
                    .fontSize(14)
                    .fontColor(0xFF7B7388)
                Text(if (this.selectedCategory == "") { "Choose a category below" } else { "Selected: ${this.selectedCategory}" })
                    .fontSize(13)
                    .fontColor(0xFF1C1B1F)

                ForEach(this.expenseStore.getCategories(), itemGeneratorFunc: { category: Category, _: Int64 =>
                    Button(category.name)
                        .width(100.percent)
                        .fontColor(if (this.selectedCategory == category.name) { 0xFFFFFFFF } else { 0xFF6750A4 })
                        .backgroundColor(if (this.selectedCategory == category.name) { 0xFF6750A4 } else { 0xFFF2EAFD })
                        .borderRadius(20)
                        .onClick({ _ =>
                            this.selectedCategory = category.name
                        })
                }, keyGeneratorFunc: { category: Category, _: Int64 =>
                    category.id
                })

                Text("Date")
                    .fontSize(14)
                    .fontColor(0xFF7B7388)
                Row(space: 8) {
                    Button("Previous")
                        .backgroundColor(0xFFF3EDF8)
                        .borderRadius(20)
                        .onClick({ _ =>
                            this.choosePreviousDate()
                        })
                    Text(this.selectedDate)
                        .fontSize(14)
                        .fontColor(0xFF1C1B1F)
                    Button("Next")
                        .backgroundColor(0xFFF3EDF8)
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
                .backgroundColor(0xFFFDF8FF)

                Text("Recurrence")
                    .fontSize(14)
                    .fontColor(0xFF7B7388)
                Row(space: 6) {
                    Button("None").backgroundColor(if (this.selectedRecurrence == "None") { 0xFF6750A4 } else { 0xFFF2EAFD }).fontColor(if (this.selectedRecurrence == "None") { 0xFFFFFFFF } else { 0xFF6750A4 }).borderRadius(999).onClick({ _ => this.selectedRecurrence = "None" })
                    Button("Daily").backgroundColor(if (this.selectedRecurrence == "Daily") { 0xFF6750A4 } else { 0xFFF2EAFD }).fontColor(if (this.selectedRecurrence == "Daily") { 0xFFFFFFFF } else { 0xFF6750A4 }).borderRadius(999).onClick({ _ => this.selectedRecurrence = "Daily" })
                    Button("Weekly").backgroundColor(if (this.selectedRecurrence == "Weekly") { 0xFF6750A4 } else { 0xFFF2EAFD }).fontColor(if (this.selectedRecurrence == "Weekly") { 0xFFFFFFFF } else { 0xFF6750A4 }).borderRadius(999).onClick({ _ => this.selectedRecurrence = "Weekly" })
                }
                Row(space: 6) {
                    Button("Monthly").backgroundColor(if (this.selectedRecurrence == "Monthly") { 0xFF6750A4 } else { 0xFFF2EAFD }).fontColor(if (this.selectedRecurrence == "Monthly") { 0xFFFFFFFF } else { 0xFF6750A4 }).borderRadius(999).onClick({ _ => this.selectedRecurrence = "Monthly" })
                    Button("Yearly").backgroundColor(if (this.selectedRecurrence == "Yearly") { 0xFF6750A4 } else { 0xFFF2EAFD }).fontColor(if (this.selectedRecurrence == "Yearly") { 0xFFFFFFFF } else { 0xFF6750A4 }).borderRadius(999).onClick({ _ => this.selectedRecurrence = "Yearly" })
                }

                Text("Note")
                    .fontSize(14)
                    .fontColor(0xFF7B7388)
                TextInput(placeholder: "Optional note", text: this.note)
                    .backgroundColor(0xFFFDF8FF)
                    .borderRadius(20)
                    .padding(left: 14, right: 14, top: 12, bottom: 12)
                    .onChange({ text =>
                        if (text.size <= this.maxNoteChars) {
                            this.note = text
                        }
                    })
                Text("${this.note.size}/${this.maxNoteChars}")
                    .fontSize(12)
                    .fontColor(0xFF7B7388)
            }
            .padding(left: 16, right: 16, top: 16, bottom: 16)
            .width(100.percent)
            .borderRadius(26)
            .backgroundColor(0xFFF8F1FF)

            if (this.showDiscardDialog) {
                Column(space: 8) {
                    Text("Discard transaction?")
                        .fontSize(14)
                        .fontColor(0xFF1C1B1F)
                    Row(space: 8) {
                        Button("Cancel").backgroundColor(0xFFF3EDF8).borderRadius(18).onClick({ _ => this.showDiscardDialog = false })
                        Button("Discard").fontColor(0xFFFFFFFF).backgroundColor(0xFFC84C58).borderRadius(18).onClick({ _ =>
                            this.showDiscardDialog = false
                            this.resetForm()
                            RouteState.navigate("expenses")
                        })
                    }
                }
                .padding(14)
                .width(100.percent)
                .borderRadius(22)
                .backgroundColor(0xFFFFFFFF)
            }

            if (this.savedMessage != "") {
                Text(this.savedMessage)
                    .fontSize(12)
                    .fontColor(0xFF7B7388)
            }
        }
        .width(100.percent)
    }
}