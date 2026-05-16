package ohos_app_cangjie_entry.data.local

import std.collection.ArrayList
import std.time.*
import ohos_app_cangjie_entry.data.model.Category
import ohos_app_cangjie_entry.data.model.Expense

public class ExpenseStore {
    private static let storedDateFormat = "yyyy-MM-dd HH:mm:ss"
    private static let dayKeyFormat = "yyyy-MM-dd"
    private static let sharedExpenses = ArrayList<Expense>()
    private static let sharedCategories = ArrayList<Category>()
    private static var nextExpenseId: Int64 = 1
    private static var nextCategoryId: Int64 = 13

    public init() {
        this.initializeCategories()
    }

    private func parseExpenseDateTime(expense: Expense): DateTime {
        DateTime.parse(expense.dateValue, ExpenseStore.storedDateFormat)
    }

    private func parseDayKey(dayKey: String): DateTime {
        DateTime.parse("${dayKey} 00:00:00", ExpenseStore.storedDateFormat)
    }

    private func sameDay(left: DateTime, right: DateTime): Bool {
        left.year == right.year && left.month == right.month && left.dayOfMonth == right.dayOfMonth
    }

    private func sameMonth(left: DateTime, right: DateTime): Bool {
        left.year == right.year && left.month == right.month
    }

    private func sameYear(left: DateTime, right: DateTime): Bool {
        left.year == right.year
    }

    private func sameWeek(left: DateTime, right: DateTime): Bool {
        left.isoWeek == right.isoWeek
    }

    private func matchesRecurrence(expense: Expense, recurrenceName: String): Bool {
        let expenseDate = this.parseExpenseDateTime(expense)
        let today = DateTime.now()
        match (recurrenceName) {
            case "Daily" => this.sameDay(expenseDate, today)
            case "Weekly" => this.sameWeek(expenseDate, today)
            case "Monthly" => this.sameMonth(expenseDate, today)
            case "Yearly" => this.sameYear(expenseDate, today)
            case _ => true
        }
    }

    private func insertDateDescending(target: ArrayList<String>, dateKey: String): Unit {
        for (existing in target) {
            if (existing == dateKey) {
                return
            }
        }
        target.add(dateKey)
        if (target.size <= 1) {
            return
        }
        for (outer in 0..target.size - 1) {
            for (inner in 0..target.size - 2) {
                if (target[inner] < target[inner + 1]) {
                    let current = target[inner]
                    target[inner] = target[inner + 1]
                    target[inner + 1] = current
                }
            }
        }
    }

    private func insertExpenseAscending(target: ArrayList<Expense>, expense: Expense): Unit {
        target.add(expense)
        if (target.size <= 1) {
            return
        }
        for (outer in 0..target.size - 1) {
            for (inner in 0..target.size - 2) {
                if (this.parseExpenseDateTime(target[inner]) > this.parseExpenseDateTime(target[inner + 1])) {
                    let current = target[inner]
                    target[inner] = target[inner + 1]
                    target[inner + 1] = current
                }
            }
        }
    }

    public static func todayDateKey(): String {
        DateTime.now().format(ExpenseStore.dayKeyFormat)
    }

    public func previousDateKey(dayKey: String): String {
        this.parseDayKey(dayKey).addDays(-1).format(ExpenseStore.dayKeyFormat)
    }

    public func nextDateKey(dayKey: String): String {
        this.parseDayKey(dayKey).addDays(1).format(ExpenseStore.dayKeyFormat)
    }

    public func getExpenses(): ArrayList<Expense> {
        ExpenseStore.sharedExpenses
    }

    public func getCategories(): ArrayList<Category> {
        ExpenseStore.sharedCategories
    }

    public func initializeCategories(): Unit {
        if (ExpenseStore.sharedCategories.size > 0) {
            return
        }
        ExpenseStore.sharedCategories.add(Category(id: "1", name: "Bills", icon: "Payments"))
        ExpenseStore.sharedCategories.add(Category(id: "2", name: "Debt", icon: "CreditCard"))
        ExpenseStore.sharedCategories.add(Category(id: "3", name: "Education", icon: "School"))
        ExpenseStore.sharedCategories.add(Category(id: "4", name: "Family", icon: "Cottage"))
        ExpenseStore.sharedCategories.add(Category(id: "5", name: "Foods & Drinks", icon: "Fastfood"))
        ExpenseStore.sharedCategories.add(Category(id: "6", name: "Healthcare", icon: "MonitorHeart"))
        ExpenseStore.sharedCategories.add(Category(id: "7", name: "Savings", icon: "Savings"))
        ExpenseStore.sharedCategories.add(Category(id: "8", name: "Shopping", icon: "ShoppingBag"))
        ExpenseStore.sharedCategories.add(Category(id: "9", name: "Social Events", icon: "Diversity1"))
        ExpenseStore.sharedCategories.add(Category(id: "10", name: "Top Up", icon: "AddCard"))
        ExpenseStore.sharedCategories.add(Category(id: "11", name: "Transportation", icon: "LocalTaxi"))
        ExpenseStore.sharedCategories.add(Category(id: "12", name: "Others", icon: "Category"))
    }

    public func addExpense(expense: Expense): Unit {
        ExpenseStore.sharedExpenses.add(expense)
        ExpenseStore.nextExpenseId += 1
    }

    public func deleteExpense(expenseId: String): Unit {
        var deleteIndex: Int64 = -1
        for (index in 0..ExpenseStore.sharedExpenses.size - 1) {
            if (ExpenseStore.sharedExpenses[index].id == expenseId) {
                deleteIndex = index
            }
        }
        if (deleteIndex >= 0) {
            ExpenseStore.sharedExpenses.remove(deleteIndex..deleteIndex)
        }
    }

    public func deleteAllExpenses(): Unit {
        ExpenseStore.sharedExpenses.clear()
    }

    public func uniqueExpenseDates(): ArrayList<String> {
        this.uniqueExpenseDatesForRecurrence("All")
    }

    public func uniqueExpenseDatesForRecurrence(recurrenceName: String): ArrayList<String> {
        let dates = ArrayList<String>()
        for (expense in ExpenseStore.sharedExpenses) {
            if (this.matchesRecurrence(expense, recurrenceName)) {
                this.insertDateDescending(dates, this.parseExpenseDateTime(expense).format(ExpenseStore.dayKeyFormat))
            }
        }
        dates
    }

    public func getExpensesByDate(dateValue: String): ArrayList<Expense> {
        this.getExpensesByDateForRecurrence(dateValue, "All")
    }

    public func getExpensesByDateForRecurrence(dateValue: String, recurrenceName: String): ArrayList<Expense> {
        let matches = ArrayList<Expense>()
        for (expense in ExpenseStore.sharedExpenses) {
            if (this.matchesRecurrence(expense, recurrenceName) && this.parseExpenseDateTime(expense).format(ExpenseStore.dayKeyFormat) == dateValue) {
                this.insertExpenseAscending(matches, expense)
            }
        }
        matches
    }

    public func getExpensesByRecurrenceName(recurrenceName: String): ArrayList<Expense> {
        let matches = ArrayList<Expense>()
        for (expense in ExpenseStore.sharedExpenses) {
            if (this.matchesRecurrence(expense, recurrenceName)) {
                matches.add(expense)
            }
        }
        matches
    }

    public func totalForDate(dateValue: String): Float64 {
        this.totalForDateForRecurrence(dateValue, "All")
    }

    public func totalForDateForRecurrence(dateValue: String, recurrenceName: String): Float64 {
        var total: Float64 = 0.0
        for (expense in ExpenseStore.sharedExpenses) {
            if (this.matchesRecurrence(expense, recurrenceName) && this.parseExpenseDateTime(expense).format(ExpenseStore.dayKeyFormat) == dateValue) {
                total += expense.amount
            }
        }
        total
    }

    public func getTotalAmount(): Float64 {
        this.getTotalAmountByRecurrenceName("All")
    }

    public func getTotalAmountByRecurrenceName(recurrenceName: String): Float64 {
        var total: Float64 = 0.0
        for (expense in ExpenseStore.sharedExpenses) {
            if (this.matchesRecurrence(expense, recurrenceName)) {
                total += expense.amount
            }
        }
        total
    }

    public func createExpense(amount: Float64, category: String, dayKey: String, recurrenceName: String, note: String): Expense {
        let now = DateTime.now()
        let selectedDate = this.parseDayKey(dayKey)
        let storedDate = DateTime.of(
            year: selectedDate.year,
            month: selectedDate.month,
            dayOfMonth: selectedDate.dayOfMonth,
            hour: now.hour,
            minute: now.minute,
            second: now.second,
            nanosecond: 0,
            timeZone: TimeZone.Local
        )
        Expense(
            id: ExpenseStore.nextExpenseId.toString(),
            amount: amount,
            category: category,
            dateValue: storedDate.format(ExpenseStore.storedDateFormat),
            recurrenceName: recurrenceName,
            note: note
        )
    }

    public func addCategory(name: String, icon: String): Unit {
        ExpenseStore.sharedCategories.add(
            Category(id: ExpenseStore.nextCategoryId.toString(), name: name, icon: icon)
        )
        ExpenseStore.nextCategoryId += 1
    }

    public func updateCategory(categoryId: String, name: String, icon: String): Unit {
        for (index in 0..ExpenseStore.sharedCategories.size - 1) {
            if (ExpenseStore.sharedCategories[index].id == categoryId) {
                ExpenseStore.sharedCategories[index] = Category(id: categoryId, name: name, icon: icon)
            }
        }
    }

    public func deleteCategory(categoryId: String): Unit {
        var deleteIndex: Int64 = -1
        for (index in 0..ExpenseStore.sharedCategories.size - 1) {
            if (ExpenseStore.sharedCategories[index].id == categoryId) {
                deleteIndex = index
            }
        }
        if (deleteIndex >= 0) {
            ExpenseStore.sharedCategories.remove(deleteIndex..deleteIndex)
        }
    }
}