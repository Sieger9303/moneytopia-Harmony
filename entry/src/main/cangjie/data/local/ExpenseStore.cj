package ohos_app_cangjie_entry.data.local

import std.collection.ArrayList
import std.convert.*
import std.time.*
import kit.ArkData.*
import kit.PerformanceAnalysisKit.Hilog
import ohos.business_exception.BusinessException
import ohos_app_cangjie_entry.data.model.Category
import ohos_app_cangjie_entry.data.model.Expense
import ohos_app_cangjie_entry.runtime.AppRuntime
import ohos_app_cangjie_entry.runtime.RouteState

public class ExpenseStore {
    private static let storedDateFormat = "yyyy-MM-dd HH:mm:ss"
    private static let dayKeyFormat = "yyyy-MM-dd"
    private static let expensesPrefsName = "moneytopia_expenses"
    private static let categoriesPrefsName = "moneytopia_categories"
    private static let countKey = "count"
    private static let nextIdKey = "next_id"
    private static let categorySeededKey = "seeded"
    private static let sharedExpenses = ArrayList<Expense>()
    private static let sharedCategories = ArrayList<Category>()
    private static var nextExpenseId: Int64 = 1
    private static var nextCategoryId: Int64 = 13
    private static var dataLoaded: Bool = false

    public init() {
        this.ensureLoaded()
        this.initializeCategories()
    }

    private func getPreferences(name: String): Option<Preferences> {
        match (AppRuntime.abilityContext) {
            case Option.Some(context) => Option.Some(Preferences.getPreferences(context, PreferencesOptions(name)))
            case _ => Option.None
        }
    }

    private func getStringPreference(preferences: Preferences, key: String, fallback: String): String {
        let value = preferences.get(key, PreferencesValueType.StringData(fallback))
        match (value) {
            case PreferencesValueType.StringData(text) => text
            case _ => fallback
        }
    }

    private func getIntPreference(preferences: Preferences, key: String, fallback: Int64): Int64 {
        let value = preferences.get(key, PreferencesValueType.StringData(fallback.toString()))
        match (value) {
            case PreferencesValueType.StringData(text) => Int64.parse(text)
            case _ => fallback
        }
    }

    private func getBoolPreference(preferences: Preferences, key: String, fallback: Bool): Bool {
        let value = preferences.get(key, PreferencesValueType.BoolData(fallback))
        match (value) {
            case PreferencesValueType.BoolData(flag) => flag
            case _ => fallback
        }
    }

    private func categoriesAlreadySeeded(): Bool {
        match (this.getPreferences(ExpenseStore.categoriesPrefsName)) {
            case Option.Some(preferences) =>
                this.getBoolPreference(preferences, ExpenseStore.categorySeededKey, false)
            case _ => false
        }
    }

    private func expenseIdKey(index: Int64): String {
        "expense_id_${index}"
    }

    private func expenseAmountKey(index: Int64): String {
        "expense_amount_${index}"
    }

    private func expenseCategoryKey(index: Int64): String {
        "expense_category_${index}"
    }

    private func expenseDateKey(index: Int64): String {
        "expense_date_${index}"
    }

    private func expenseRecurrenceKey(index: Int64): String {
        "expense_recurrence_${index}"
    }

    private func expenseNoteKey(index: Int64): String {
        "expense_note_${index}"
    }

    private func categoryIdKey(index: Int64): String {
        "category_id_${index}"
    }

    private func categoryNameKey(index: Int64): String {
        "category_name_${index}"
    }

    private func categoryIconKey(index: Int64): String {
        "category_icon_${index}"
    }

    private func persistExpenses(): Unit {
        try {
            match (this.getPreferences(ExpenseStore.expensesPrefsName)) {
                case Option.Some(preferences) =>
                    preferences.clear()
                    preferences.put(ExpenseStore.countKey, PreferencesValueType.StringData(ExpenseStore.sharedExpenses.size.toString()))
                    preferences.put(ExpenseStore.nextIdKey, PreferencesValueType.StringData(ExpenseStore.nextExpenseId.toString()))
                    for (index in 0..ExpenseStore.sharedExpenses.size - 1) {
                        let expense = ExpenseStore.sharedExpenses[index]
                        preferences.put(this.expenseIdKey(index), PreferencesValueType.StringData(expense.id))
                        preferences.put(this.expenseAmountKey(index), PreferencesValueType.StringData(expense.amount.toString()))
                        preferences.put(this.expenseCategoryKey(index), PreferencesValueType.StringData(expense.category))
                        preferences.put(this.expenseDateKey(index), PreferencesValueType.StringData(expense.dateValue))
                        preferences.put(this.expenseRecurrenceKey(index), PreferencesValueType.StringData(expense.recurrenceName))
                        preferences.put(this.expenseNoteKey(index), PreferencesValueType.StringData(expense.note))
                    }
                    preferences.flush()
                case _ =>
                    Hilog.error(1, "Moneytopia", "UIAbilityContext is not ready for expense persistence")
            }
        } catch (e: BusinessException) {
            Hilog.error(1, "Moneytopia", "Failed to persist expenses: ${e.message}")
        }
    }

    private func persistCategories(): Unit {
        try {
            match (this.getPreferences(ExpenseStore.categoriesPrefsName)) {
                case Option.Some(preferences) =>
                    preferences.clear()
                    preferences.put(ExpenseStore.countKey, PreferencesValueType.StringData(ExpenseStore.sharedCategories.size.toString()))
                    preferences.put(ExpenseStore.nextIdKey, PreferencesValueType.StringData(ExpenseStore.nextCategoryId.toString()))
                    preferences.put(ExpenseStore.categorySeededKey, PreferencesValueType.BoolData(true))
                    for (index in 0..ExpenseStore.sharedCategories.size - 1) {
                        let category = ExpenseStore.sharedCategories[index]
                        preferences.put(this.categoryIdKey(index), PreferencesValueType.StringData(category.id))
                        preferences.put(this.categoryNameKey(index), PreferencesValueType.StringData(category.name))
                        preferences.put(this.categoryIconKey(index), PreferencesValueType.StringData(category.icon))
                    }
                    preferences.flush()
                case _ =>
                    Hilog.error(1, "Moneytopia", "UIAbilityContext is not ready for category persistence")
            }
        } catch (e: BusinessException) {
            Hilog.error(1, "Moneytopia", "Failed to persist categories: ${e.message}")
        }
    }

    private func preferencesReady(): Bool {
        return this.getPreferences(ExpenseStore.expensesPrefsName).isSome() &&
               this.getPreferences(ExpenseStore.categoriesPrefsName).isSome()
    }

    private func ensureLoaded(): Unit {
        if (ExpenseStore.dataLoaded) {
            return
        }

        if (!this.preferencesReady()) {
            Hilog.error(1, "Moneytopia", "Preferences are not ready; defer ExpenseStore loading")
            return
        }

        ExpenseStore.sharedExpenses.clear()
        ExpenseStore.sharedCategories.clear()

        try {
            match (this.getPreferences(ExpenseStore.expensesPrefsName)) {
                case Option.Some(preferences) =>
                    let count = this.getIntPreference(preferences, ExpenseStore.countKey, 0)
                    ExpenseStore.nextExpenseId = this.getIntPreference(preferences, ExpenseStore.nextIdKey, 1)
                    for (index in 0..count - 1) {
                        let amountText = this.getStringPreference(preferences, this.expenseAmountKey(index), "0")
                        let parsedAmount = Float64.parse(amountText)
                        ExpenseStore.sharedExpenses.add(Expense(
                            id: this.getStringPreference(preferences, this.expenseIdKey(index), ""),
                            amount: parsedAmount,
                            category: this.getStringPreference(preferences, this.expenseCategoryKey(index), ""),
                            dateValue: this.getStringPreference(preferences, this.expenseDateKey(index), ""),
                            recurrenceName: this.getStringPreference(preferences, this.expenseRecurrenceKey(index), "None"),
                            note: this.getStringPreference(preferences, this.expenseNoteKey(index), "")
                        ))
                    }
                case _ =>
                    return
            }

            match (this.getPreferences(ExpenseStore.categoriesPrefsName)) {
                case Option.Some(preferences) =>
                    let count = this.getIntPreference(preferences, ExpenseStore.countKey, 0)
                    ExpenseStore.nextCategoryId = this.getIntPreference(preferences, ExpenseStore.nextIdKey, 13)
                    for (index in 0..count - 1) {
                        ExpenseStore.sharedCategories.add(Category(
                            id: this.getStringPreference(preferences, this.categoryIdKey(index), ""),
                            name: this.getStringPreference(preferences, this.categoryNameKey(index), ""),
                            icon: this.getStringPreference(preferences, this.categoryIconKey(index), "Category")
                        ))
                    }
                    if (count == 0 && !this.getBoolPreference(preferences, ExpenseStore.categorySeededKey, false)) {
                        ExpenseStore.nextCategoryId = 13
                    }
                case _ =>
                    return
            }

            ExpenseStore.dataLoaded = true
        } catch (e: BusinessException) {
            Hilog.error(1, "Moneytopia", "Failed to load persisted store data: ${e.message}")
        }
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

    private func dayOfWeekNumber(day: DayOfWeek): Int64 {
        match (day) {
            case Monday => 1
            case Tuesday => 2
            case Wednesday => 3
            case Thursday => 4
            case Friday => 5
            case Saturday => 6
            case Sunday => 7
        }
    }

    private func dayKey(date: DateTime): String {
        date.format(ExpenseStore.dayKeyFormat)
    }

    private func sameWeek(left: DateTime, right: DateTime): Bool {
        let weekStart = right.addDays(-(this.dayOfWeekNumber(right.dayOfWeek) - 1))
        let weekEnd = weekStart.addDays(6)

        let leftKey = this.dayKey(left)
        let startKey = this.dayKey(weekStart)
        let endKey = this.dayKey(weekEnd)

        leftKey >= startKey && leftKey <= endKey
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
        this.ensureLoaded()
        ExpenseStore.sharedExpenses
    }

    public func getCategories(): ArrayList<Category> {
        this.ensureLoaded()
        ExpenseStore.sharedCategories
    }

    public func initializeCategories(): Unit {
        this.ensureLoaded()

        if (!ExpenseStore.dataLoaded) {
            return
        }

        if (ExpenseStore.sharedCategories.size > 0) {
            return
        }

        if (this.categoriesAlreadySeeded()) {
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
        this.persistCategories()
    }

    public func addExpense(expense: Expense): Unit {
        this.ensureLoaded()
        ExpenseStore.sharedExpenses.add(expense)
        ExpenseStore.nextExpenseId += 1
        this.persistExpenses()
        RouteState.notifyDataChanged()
    }

    public func deleteExpense(expenseId: String): Unit {
        this.ensureLoaded()
        var deleteIndex: Int64 = -1
        for (index in 0..ExpenseStore.sharedExpenses.size - 1) {
            if (ExpenseStore.sharedExpenses[index].id == expenseId) {
                deleteIndex = index
            }
        }
        if (deleteIndex >= 0) {
            ExpenseStore.sharedExpenses.remove(deleteIndex..deleteIndex)
            this.persistExpenses()
            RouteState.notifyDataChanged()
        }
    }

    public func deleteAllExpenses(): Unit {
        this.ensureLoaded()
        ExpenseStore.sharedExpenses.clear()
        this.persistExpenses()
        RouteState.notifyDataChanged()
    }

    public func uniqueExpenseDates(): ArrayList<String> {
        this.uniqueExpenseDatesForRecurrence("All")
    }

    public func uniqueExpenseDatesForRecurrence(recurrenceName: String): ArrayList<String> {
        this.ensureLoaded()
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
        this.ensureLoaded()
        let matches = ArrayList<Expense>()
        for (expense in ExpenseStore.sharedExpenses) {
            if (this.matchesRecurrence(expense, recurrenceName) && this.parseExpenseDateTime(expense).format(ExpenseStore.dayKeyFormat) == dateValue) {
                this.insertExpenseAscending(matches, expense)
            }
        }
        matches
    }

    public func getExpensesByRecurrenceName(recurrenceName: String): ArrayList<Expense> {
        this.ensureLoaded()
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
        this.ensureLoaded()
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
        this.ensureLoaded()
        var total: Float64 = 0.0
        for (expense in ExpenseStore.sharedExpenses) {
            if (this.matchesRecurrence(expense, recurrenceName)) {
                total += expense.amount
            }
        }
        total
    }

    public func createExpense(amount: Float64, category: String, dayKey: String, recurrenceName: String, note: String): Expense {
        this.ensureLoaded()
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
        this.ensureLoaded()
        ExpenseStore.sharedCategories.add(
            Category(id: ExpenseStore.nextCategoryId.toString(), name: name, icon: icon)
        )
        ExpenseStore.nextCategoryId += 1
        this.persistCategories()
        RouteState.notifyDataChanged()
    }

    public func updateCategory(categoryId: String, name: String, icon: String): Unit {
        this.ensureLoaded()
        for (index in 0..ExpenseStore.sharedCategories.size - 1) {
            if (ExpenseStore.sharedCategories[index].id == categoryId) {
                ExpenseStore.sharedCategories[index] = Category(id: categoryId, name: name, icon: icon)
            }
        }
        this.persistCategories()
        RouteState.notifyDataChanged()
    }

    public func deleteCategory(categoryId: String): Unit {
        this.ensureLoaded()

        if (categoryId == "") {
            return
        }

        let kept = ArrayList<Category>()
        var removed = false

        for (category in ExpenseStore.sharedCategories) {
            if (category.id == categoryId) {
                removed = true
            } else {
                kept.add(Category(id: category.id, name: category.name, icon: category.icon))
            }
        }

        if (removed) {
            ExpenseStore.sharedCategories.clear()
            for (category in kept) {
                ExpenseStore.sharedCategories.add(category)
            }
            this.persistCategories()
            RouteState.notifyDataChanged()
        }
    }
}