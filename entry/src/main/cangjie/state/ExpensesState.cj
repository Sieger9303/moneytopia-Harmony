package ohos_app_cangjie_entry.state

import std.collection.ArrayList
import ohos_app_cangjie_entry.data.local.ExpenseStore
import ohos_app_cangjie_entry.data.local.PreferenceStore
import ohos_app_cangjie_entry.data.model.Expense

public class ExpensesState {
    public var totalExpenses: Float64 = 0.0
    public var currencySymbol: String = "$"
    public var categoryCount: Int64 = 0

    public init() {}

    public init(totalExpenses!: Float64, currencySymbol!: String, categoryCount!: Int64) {
        this.totalExpenses = totalExpenses
        this.currencySymbol = currencySymbol
        this.categoryCount = categoryCount
    }
}

private func cloneExpenses(source: ArrayList<Expense>): ArrayList<Expense> {
    let copied = ArrayList<Expense>()
    for (expense in source) {
        copied.add(expense)
    }
    copied
}

public func getExpensesSnapshot(): ExpensesState {
    let expenseStore = ExpenseStore()
    let preferenceStore = PreferenceStore()
    ExpensesState(
        totalExpenses: expenseStore.getTotalAmount(),
        currencySymbol: preferenceStore.getCurrencySymbol(),
        categoryCount: expenseStore.getCategories().size
    )
}

public func getDailyExpenseTotal(): String {
    let preferenceStore = PreferenceStore()
    let expenseStore = ExpenseStore()
    let symbol = preferenceStore.getCurrencySymbol()
    let total = expenseStore.getTotalAmountByRecurrenceName("Daily")
    "${symbol}${total}"
}

public func getDailyExpenseCount(): Int64 {
    ExpenseStore().getExpensesByRecurrenceName("Daily").size
}

public func getYearlyExpenseCount(): Int64 {
    ExpenseStore().getExpensesByRecurrenceName("Yearly").size
}

public func getDailyDateCount(): Int64 {
    ExpenseStore().uniqueExpenseDatesForRecurrence("Daily").size
}

public func getYearlyDateCount(): Int64 {
    ExpenseStore().uniqueExpenseDatesForRecurrence("Yearly").size
}

public func getDailyDates(): ArrayList<String> {
    ExpenseStore().uniqueExpenseDatesForRecurrence("Daily")
}

public func getYearlyDates(): ArrayList<String> {
    ExpenseStore().uniqueExpenseDatesForRecurrence("Yearly")
}

public func getDailyExpensesForDate(dateValue: String): ArrayList<Expense> {
    cloneExpenses(ExpenseStore().getExpensesByDateForRecurrence(dateValue, "Daily"))
}

public func getYearlyExpensesForDate(dateValue: String): ArrayList<Expense> {
    cloneExpenses(ExpenseStore().getExpensesByDateForRecurrence(dateValue, "Yearly"))
}

public func getDailyTotalForDate(dateValue: String): Float64 {
    ExpenseStore().totalForDateForRecurrence(dateValue, "Daily")
}

public func getYearlyTotalForDate(dateValue: String): Float64 {
    ExpenseStore().totalForDateForRecurrence(dateValue, "Yearly")
}