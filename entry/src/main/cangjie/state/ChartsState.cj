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

private func parseDay(day: String): DateTime {
    DateTime.parse("${day} 00:00:00", "yyyy-MM-dd HH:mm:ss")
}

private func parseExpenseDay(expense: Expense): DateTime {
    DateTime.parse(expense.dateValue, "yyyy-MM-dd HH:mm:ss")
}

private func isInRange(expense: Expense, start: DateTime, end: DateTime): Bool {
    let day = parseExpenseDay(expense)
    day >= start && day <= end
}

public func getChartsSnapshot(page: Int64, recurrence: Recurrence): ChartsState {
    let expenseStore = ExpenseStore()
    let preferenceStore = PreferenceStore()
    let range = calculateDateRange(recurrence, page)
    let start = parseDay(range.start)
    let end = parseDay(range.end)
    let expenses = ArrayList<Expense>()
    var total: Float64 = 0.0
    for (expense in expenseStore.getExpenses()) {
        if (isInRange(expense, start, end)) {
            expenses.add(expense)
            total += expense.amount
        }
    }
    ChartsState(
        expenses: expenses,
        dateStart: range.start,
        dateEnd: range.end,
        totalInRange: total,
        currencySymbol: preferenceStore.getCurrencySymbol()
    )
}