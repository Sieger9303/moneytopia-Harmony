package ohos_app_cangjie_entry.state

import ohos_app_cangjie_entry.data.model.Recurrence

public class StateFactory {
    public init() {}

    public func createExpensesState(): ExpensesState {
        getExpensesSnapshot()
    }

    public func createAddExpenseState(): AddExpenseState {
        getAddExpenseSnapshot()
    }

    public func createCategoryState(): CategoryState {
        getCategorySnapshot()
    }

    public func createAnalyticsState(): AnalyticsState {
        getAnalyticsSnapshot()
    }

    public func createChartsState(page: Int64, recurrence: Recurrence): ChartsState {
        getChartsSnapshot(page, recurrence)
    }
}