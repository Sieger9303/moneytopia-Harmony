package ohos_app_cangjie_entry.pages

import std.convert.*
import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.runtime.RouteState
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
        Scroll() {
            Column(space: 12) {
                Text("Add Expense")
                    .fontSize(24)

                Row(space: 8) {
                    Button("Close")
                        .onClick({ _ =>
                            if (this.isDirty()) {
                                this.showDiscardDialog = true
                            } else {
                                RouteState.navigate("expenses")
                            }
                        })
                    Button("Save")
                        .enabled(this.amount != "" && this.selectedCategory != "")
                        .onClick({ _ =>
                            this.saveExpense()
                        })
                }

                Text("Amount")
                TextInput(placeholder: "0", text: this.amount)
                    .onChange({ text =>
                        if (text.size <= this.maxAmountChars) {
                            this.amount = text
                        }
                    })

                Text("Category")
                if (this.selectedCategory == "") {
                    Text("No category selected")
                } else {
                    Text("Selected: ${this.selectedCategory}")
                }
                ForEach(this.expenseStore.getCategories(), itemGeneratorFunc: { category: Category, _: Int64 =>
                    Button(category.name)
                        .onClick({ _ =>
                            this.selectedCategory = category.name
                        })
                }, keyGeneratorFunc: { category: Category, _: Int64 =>
                    category.id
                })

                Text("Date")
                Row(space: 8) {
                    Button("Previous")
                        .onClick({ _ =>
                            this.choosePreviousDate()
                        })
                    Text(this.selectedDate)
                    Button("Next")
                        .enabled(this.selectedDate < ExpenseStore.todayDateKey())
                        .onClick({ _ =>
                            this.chooseNextDate()
                        })
                }

                Text("Recurrence")
                Row(space: 8) {
                    Button("None")
                        .onClick({ _ =>
                            this.selectedRecurrence = "None"
                        })
                    Button("Daily")
                        .onClick({ _ =>
                            this.selectedRecurrence = "Daily"
                        })
                    Button("Weekly")
                        .onClick({ _ =>
                            this.selectedRecurrence = "Weekly"
                        })
                    Button("Monthly")
                        .onClick({ _ =>
                            this.selectedRecurrence = "Monthly"
                        })
                    Button("Yearly")
                        .onClick({ _ =>
                            this.selectedRecurrence = "Yearly"
                        })
                }
                Text("Selected recurrence: ${this.selectedRecurrence}")

                Text("Note")
                TextInput(placeholder: "Optional note", text: this.note)
                    .onChange({ text =>
                        if (text.size <= this.maxNoteChars) {
                            this.note = text
                        }
                    })
                Text("${this.note.size}/${this.maxNoteChars}")

                if (this.showDiscardDialog) {
                    Column(space: 8) {
                        Text("Discard transaction?")
                            .fontSize(18)
                        Row(space: 8) {
                            Button("Cancel")
                                .onClick({ _ =>
                                    this.showDiscardDialog = false
                                })
                            Button("Discard")
                                .onClick({ _ =>
                                    this.showDiscardDialog = false
                                    this.resetForm()
                                    RouteState.navigate("expenses")
                                })
                        }
                    }
                    .padding(12)
                }

                if (this.savedMessage != "") {
                    Text(this.savedMessage)
                }
            }
            .padding(16)
        }
    }
}