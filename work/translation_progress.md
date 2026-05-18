## Source Kotlin files inspected
- `moneytopia/app/src/main/java/com/dimrnhhh/moneytopia/pages/Analytics.kt`
- `moneytopia/app/src/main/java/com/dimrnhhh/moneytopia/viewmodels/AnalyticsViewModel.kt`
- `moneytopia/app/src/main/java/com/dimrnhhh/moneytopia/viewmodels/ChartsViewModel.kt`
- `moneytopia/app/src/main/java/com/dimrnhhh/moneytopia/components/charts/Charts.kt`
- `moneytopia/app/src/main/java/com/dimrnhhh/moneytopia/components/charts/WeeklyChart.kt`
- `moneytopia/app/src/main/java/com/dimrnhhh/moneytopia/components/charts/MonthlyChart.kt`
- `moneytopia/app/src/main/java/com/dimrnhhh/moneytopia/components/charts/YearlyChart.kt`
- `moneytopia/app/src/main/java/com/dimrnhhh/moneytopia/components/charts/Marker.kt`
- `moneytopia/app/src/main/java/com/dimrnhhh/moneytopia/components/expenses/ExpensesByPeriod.kt`
- `moneytopia/app/src/main/java/com/dimrnhhh/moneytopia/components/expenses/ExpensesDayGroup.kt`
- `moneytopia/app/src/main/java/com/dimrnhhh/moneytopia/models/Expense.kt`
- `moneytopia/app/src/main/java/com/dimrnhhh/moneytopia/utils/DateUtils.kt`

## Exact source behavior found
- Analytics page selects recurrence from `Weekly`, `Monthly`, `Yearly`.
- Period paging comes from the pager index. Weekly has 53 pages, monthly 12, yearly 1.
- `ChartsViewModel` computes one selected date range from `calculateDateRange(recurrence, page)` and filters expenses inclusively by that range.
- The same filtered `uiState.expenses` drives the top range label, top total, chart values, and lower `ExpensesByPeriod` list.
- Kotlin `Charts.kt` passes the same selected-period list into `WeeklyChart`, `MonthlyChart`, `YearlyChart`, and `ExpensesByPeriod`.
- `ExpensesByPeriod.kt` does not refetch current-day/current-week/current-month data. It groups only the provided `expenses` by calendar day.
- Group headers are `Today`, `Yesterday`, or formatted date via `LocalDate.formatDay()`.
- Group order is descending by date.
- Expense order inside each group is ascending by expense datetime.
- A `Total` row is shown at the end of each day group.
- Empty Analytics state text is `Transaction history for this time period is not available.`
- Weekly chart uses Monday through Sunday bottom labels and totals grouped by day of week from the selected expense list.
- Monthly chart uses one label per day of selected month from the selected expense list. It does not use guessed sparse ticks.
- Yearly chart uses January through December bottom labels and totals grouped by month from the selected expense list.
- Kotlin uses a chart library line chart with a filled line style and marker. The target cannot use that library directly, so the Harmony port keeps a bounded line path and label selection faithful to source data grouping.

## Target Cangjie files inspected
- `moneytopia-Harmony/entry/cjpm.toml`
- `moneytopia-Harmony/entry/src/main/cangjie/pages/AnalyticsPage.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/components/charts/ChartsSection.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/state/ChartsState.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/components/charts/WeeklyChart.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/components/charts/MonthlyChart.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/components/charts/YearlyChart.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/components/charts/LineChartCard.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/components/expenses/ExpensesByPeriodSection.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/components/expenses/ExpensesDayGroup.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/data/model/Expense.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/data/model/Recurrence.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/utils/DateUtils.cj`

## Files changed
- `moneytopia-Harmony/entry/src/main/cangjie/pages/AnalyticsPage.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/components/charts/ChartsSection.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/components/charts/WeeklyChart.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/components/charts/MonthlyChart.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/components/charts/YearlyChart.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/components/charts/LineChartCard.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/components/expenses/ExpensesByPeriodSection.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/components/expenses/ExpensesDayGroup.cj`
- `moneytopia-Harmony/entry/src/main/cangjie/utils/DateUtils.cj`

## Exact selected-period data-flow fix
- Kept `ChartsState.getChartsSnapshot(page, recurrence)` as the single selected-period snapshot source.
- `ChartsSection.cj` now uses the same selected `page` and `recurrence` for:
  - top range label
  - top total
  - chart expenses
  - lower transactions expenses
- Removed the non-source helper banner between the total card and chart.
- Lower transactions now receive the selected-period expenses from `ChartsSection` instead of computing another independent period.

## Exact ExpensesByPeriod source-fidelity fix
- `ExpensesByPeriodSection.cj` now behaves as a direct selected-period grouping view:
  - groups only provided expenses by day string
  - sorts day groups descending
  - sorts expenses within a day ascending by `dateValue`
  - uses empty text matching Kotlin `empty_analytics`
- `ExpensesDayGroup.cj` still renders the group `Total` row and date header, and header text comes from `formatDay()`.
- `DateUtils.cj` now formats day headers closer to Kotlin behavior:
  - `Today` and `Yesterday` only when date actually matches current day or previous day
  - otherwise current-year date header format with weekday
  - otherwise cross-year date header format with weekday and year

## Exact chart source-fidelity fix
- Removed custom chart titles/subtitles not present in Kotlin chart area.
- `WeeklyChart.cj` still maps selected-period expenses to Monday-Sunday totals.
- `MonthlyChart.cj` now emits one x-axis label per selected day number instead of sparse guessed ticks that wrapped badly.
- `YearlyChart.cj` still maps selected-period expenses to January-December totals.
- `LineChartCard.cj` removed the overshooting spline interpolation and now uses bounded straight line segments between points.
- Grid lines remain lightweight. The line no longer dips below baseline for non-negative values.
- Bottom labels now come directly from the period point labels without the previous extra dot-strip design.

## Build command/result
- Command: `python ".agents/skills/harmonyos-build/build.py" --project-root "D:/Kotlintranslate/moneytopia-Harmony"`
- Result: `BUILD SUCCESSFUL`

## Remaining emulator checks
- Verify weekly `Previous` changes lower transactions to the exact previous-week groups.
- Verify monthly lower transactions show all selected-month day groups, not just today.
- Verify monthly x-axis labels render horizontally and do not wrap into the previous broken layout.
- Verify yearly labels remain readable in device width.
- Verify the line path visually stays within chart bounds for zero-heavy and mixed totals.
- Verify analytics info dialog text still appears correctly from the header info action.
