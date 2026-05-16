package ohos_app_cangjie_entry.state

import std.collection.ArrayList
import ohos_app_cangjie_entry.data.local.ExpenseStore
import ohos_app_cangjie_entry.data.model.Category

public class CategoryState {
    public var categories = ArrayList<Category>()

    public init() {}
}

public func getCategorySnapshot(): CategoryState {
    let expenseStore = ExpenseStore()
    let state = CategoryState()
    state.categories = expenseStore.getCategories()
    state
}