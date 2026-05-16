package ohos_app_cangjie_entry.state

import ohos_app_cangjie_entry.data.local.PreferenceStore
import ohos_app_cangjie_entry.data.model.Recurrence
import ohos_app_cangjie_entry.data.model.recurrenceName

public class AddExpenseState {
    public var amount: String = ""
    public var category: String = ""
    public var dateValue: String = "today"
    public var recurrence: String = "None"
    public var note: String = ""
    public var currencySymbol: String = "$"

    public init() {}
}

public func getAddExpenseSnapshot(): AddExpenseState {
    let preferenceStore = PreferenceStore()
    let state = AddExpenseState()
    state.currencySymbol = preferenceStore.getCurrencySymbol()
    state.recurrence = recurrenceName(Recurrence.None)
    state
}