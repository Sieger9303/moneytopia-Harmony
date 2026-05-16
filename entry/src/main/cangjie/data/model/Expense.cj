package ohos_app_cangjie_entry.data.model

public class Expense {
    public var id: String = ""
    public var amount: Float64 = 0.0
    public var category: String = ""
    public var dateValue: String = ""
    public var recurrenceName: String = "None"
    public var note: String = ""

    public init() {}

    public init(id!: String, amount!: Float64, category!: String, dateValue!: String, recurrenceName!: String, note!: String) {
        this.id = id
        this.amount = amount
        this.category = category
        this.dateValue = dateValue
        this.recurrenceName = recurrenceName
        this.note = note
    }
}

public class DayExpenses {
    public var expenses: Array<Expense> = []
    public var total: Float64 = 0.0

    public init() {}

    public init(expenses!: Array<Expense>, total!: Float64) {
        this.expenses = expenses
        this.total = total
    }
}