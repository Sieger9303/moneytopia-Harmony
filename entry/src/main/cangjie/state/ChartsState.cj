package ohos_app_cangjie_entry.state

import std.collection.ArrayList
import std.time.*
import ohos_app_cangjie_entry.data.local.ExpenseStore
import ohos_app_cangjie_entry.data.local.PreferenceStore
import ohos_app_cangjie_entry.data.model.Expense
import ohos_app_cangjie_entry.data.model.Recurrence
import ohos_app_cangjie_entry.utils.calculateDateRange

public class ChartsState {
    public var expenses: ArrayList<Expense> = ArrayList<Expense>()
    public var dateStart: String = ""
    public var dateEnd: String = ""
    public var totalInRange: Float64 = 0.0
    public var currencySymbol: String = "$"

    public init() {}

    public init(expenses!: ArrayList<Expense>, dateStart!: String, dateEnd!: String, totalInRange!: Float64, currencySymbol!: String) {
        this.expenses = expenses
        this.dateStart = dateStart
        this.dateEnd = dateEnd
        this.totalInRange = totalInRange
        this.currencySymbol = currencySymbol
    }
}

private let storedDateTimeFormat = "yyyy-MM-dd HH:mm:ss"
private let storedDayFormat = "yyyy-MM-dd"

private func parseExpenseDate(expense: Expense): DateTime {
    DateTime.parse(expense.dateValue, storedDateTimeFormat)
}

private func parseRangeDay(day: String): DateTime {
    DateTime.parse("${day} 00:00:00", storedDateTimeFormat)
}

private func endOfRangeDay(day: String): DateTime {
    DateTime.parse("${day} 23:59:59", storedDateTimeFormat)
}

private func sortExpensesAscending(expenses: ArrayList<Expense>): ArrayList<Expense> {
    if (expenses.size <= 1) {
        return expenses
    }
    for (outer in 0..expenses.size - 1) {
        for (inner in 0..expenses.size - 2) {
            if (expenses[inner].dateValue > expenses[inner + 1].dateValue) {
                let current = expenses[inner]
                expenses[inner] = expenses[inner + 1]
                expenses[inner + 1] = current
            }
        }
    }
    expenses
}

public func getChartsSnapshot(page: Int64, recurrence: Recurrence): ChartsState {
    let expenseStore = ExpenseStore()
    let preferenceStore = PreferenceStore()
    let range = calculateDateRange(recurrence, page)
    let start = parseRangeDay(range.start)
    let end = endOfRangeDay(range.end)
    let expenses = ArrayList<Expense>()
    var total: Float64 = 0.0
    for (expense in expenseStore.getExpenses()) {
        let expenseDate = parseExpenseDate(expense)
        if (expenseDate >= start && expenseDate <= end) {
            expenses.add(expense)
            total += expense.amount
        }
    }
    ChartsState(
        expenses: sortExpensesAscending(expenses),
        dateStart: range.start,
        dateEnd: range.end,
        totalInRange: total,
        currencySymbol: preferenceStore.getCurrencySymbol()
    )
}