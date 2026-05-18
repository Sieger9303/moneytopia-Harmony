## Source Kotlin files inspected
- `moneytopia/app/src/main/java/com/dimrnhhh/moneytopia/pages/Analytics.kt`
- `moneytopia/app/src/main/java/com/dimrnhhh/moneytopia/components/charts/Charts.kt`
- `moneytopia/app/src/main/java/com/dimrnhhh/moneytopia/viewmodels/ChartsViewModel.kt`
- `moneytopia/app/src/main/java/com/dimrnhhh/moneytopia/components/expenses/ExpensesByPeriod.kt`
- `moneytopia/app/src/main/java/com/dimrnhhh/moneytopia/models/Expense.kt`
- `moneytopia/app/src/main/java/com/dimrnhhh/moneytopia/utils/DateUtils.kt`

## Exact source data flow found
- `Analytics.kt` uses `HorizontalPager` and passes the pager page index to `Charts(page = it, recurrence = uiState.recurrence)`.
- `ChartsViewModel(page, recurrence)` calls `calculateDateRange(recurrence, page)`, computes one selected date range, and filters expenses inclusively to that exact period.
- `Charts.kt` uses the same `uiState.expenses` for the top date range label, top total, chart content, and lower `ExpensesByPeriod` section.
- `ExpensesByPeriod.kt` does not fetch current-day/current-week/current-month data. It only groups the received `expenses` by day with `groupedByDay()` and renders those date groups.
- `Today` and `Yesterday` come only from date formatting for a rendered group date. They are not data filters.

## Target Cangjie files inspected
- `moneytopia-Harmony/entry/cjpm.toml`
- `moneytopia-Harmony/entry/src/main/cangjie/pages/AnalyticsPage.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/components/charts/ChartsSection.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/state/ChartsState.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/components/expenses/ExpensesByPeriodSection.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/components/expenses/ExpensesDayGroup.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/utils/DateUtils.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/data/model/Expense.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/data/local/ExpenseStore.cj`

## Files changed
- `moneytopia-Harmony/entry/src/main/cangjie/components/charts/ChartsSection.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/components/expenses/ExpensesByPeriodSection.cj`

## Exact transaction data-flow fix
- `ChartsSection.cj` already used `getChartsSnapshot(page, recurrence)` for the top range label, top total, and chart expenses.
- The lower Transactions call now passes selected-period primitives instead of only an `ArrayList<Expense>` prop: `page: this.page` and `recurrenceName: this.recurrenceName`.
- `ExpensesByPeriodSection.cj` now derives its list from `getChartsSnapshot(this.page, toRecurrence(this.recurrenceName)).expenses`, matching the Kotlin flow `ChartsViewModel(page, recurrence) -> uiState.expenses -> ExpensesByPeriod(expenses)`.
- `uniqueSortedDatesDescending()`, `expensesForDate(...)`, `totalForDate(...)`, and empty-state checks all use that selected-period expense list.
- The component does not call current-day/current-week/current-month helpers and does not hardcode `Today` as a data source.

## Exact rebuild/key fix
- The lower list `ForEach` key now includes selected period and date: `${this.recurrenceName}-${this.page}-${dateValue}`.
- This prevents day-group nodes from being reused across page or recurrence changes.
- A small macro-safe follow-up adjustment removed a local `let` from `build()` and replaced it with `hasSelectedExpenses()`, after the first rebuild reported `@Component` macro evaluation failure in `ExpensesByPeriodSection.cj`.

## Build command/result
- Command: `python ".agents/skills/harmonyos-build/build.py" --project-root "D:/Kotlintranslate/moneytopia-Harmony"`
- Result: `BUILD SUCCESSFUL`

## Remaining emulator checks
- Verify Weekly `Previous` changes lower Transactions to the selected previous week's day groups.
- Verify Monthly lower Transactions shows all non-empty selected-month expense day groups instead of only today.
- Verify group headers still show `Today` and `Yesterday` only when the actual group date matches those dates.
- Verify switching between Weekly, Monthly, and Yearly no longer reuses stale lower transaction nodes.
