package ohos_app_cangjie_entry.utils

import std.time.*
import ohos_app_cangjie_entry.data.model.Recurrence

public struct DateRangeData {
    public let start: String
    public let end: String
    public let daysInRange: Int64

    public init(start: String, end: String, daysInRange: Int64) {
        this.start = start
        this.end = end
        this.daysInRange = daysInRange
    }
}

private let storedDateFormat = "yyyy-MM-dd"

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

private func dailyRange(today: DateTime, page: Int64): DateRangeData {
    let day = today.addDays(-page)
    DateRangeData(day.format(storedDateFormat), day.format(storedDateFormat), 1)
}

private func weeklyRange(today: DateTime, page: Int64): DateRangeData {
    let monday = today.addDays(-(dayOfWeekNumber(today.dayOfWeek) - 1))
    let start = monday.addDays(-(page * 7))
    let end = start.addDays(6)
    DateRangeData(start.format(storedDateFormat), end.format(storedDateFormat), 7)
}

private func monthlyRange(today: DateTime, page: Int64): DateRangeData {
    let firstOfCurrentMonth = DateTime.of(year: today.year, month: today.month, dayOfMonth: 1, hour: 0, minute: 0, second: 0, nanosecond: 0, timeZone: TimeZone.Local)
    let start = firstOfCurrentMonth.addMonths(-page)
    let nextMonthStart = start.addMonths(1)
    let end = nextMonthStart.addDays(-1)
    let days = end.dayOfMonth
    DateRangeData(start.format(storedDateFormat), end.format(storedDateFormat), days)
}

private func yearlyRange(today: DateTime): DateRangeData {
    let start = DateTime.of(year: today.year, month: January, dayOfMonth: 1, hour: 0, minute: 0, second: 0, nanosecond: 0, timeZone: TimeZone.Local)
    let end = DateTime.of(year: today.year, month: December, dayOfMonth: 31, hour: 0, minute: 0, second: 0, nanosecond: 0, timeZone: TimeZone.Local)
    DateRangeData(start.format(storedDateFormat), end.format(storedDateFormat), 365)
}

public func formatDay(day: String): String {
    let target = DateTime.parse("${day} 00:00:00", "yyyy-MM-dd HH:mm:ss")
    let today = DateTime.now()
    let yesterday = today.addDays(-1)
    if (target.year == today.year && target.month == today.month && target.dayOfMonth == today.dayOfMonth) {
        return "Today"
    }
    if (target.year == yesterday.year && target.month == yesterday.month && target.dayOfMonth == yesterday.dayOfMonth) {
        return "Yesterday"
    }
    if (target.year != today.year) {
        return target.format("EEE, dd MMM yyyy")
    }
    target.format("EEE, dd MMM")
}

public func formatDayForRange(day: String): String {
    let target = DateTime.parse("${day} 00:00:00", "yyyy-MM-dd HH:mm:ss")
    let today = DateTime.now()
    if (target.year != today.year) {
        return target.format("dd MMM yyyy")
    }
    target.format("dd MMM")
}

public func calculateDateRange(recurrence: Recurrence, page: Int64): DateRangeData {
    let today = DateTime.now()
    match (recurrence) {
        case Recurrence.Daily => dailyRange(today, page)
        case Recurrence.Weekly => weeklyRange(today, page)
        case Recurrence.Monthly => monthlyRange(today, page)
        case Recurrence.Yearly => yearlyRange(today)
        case _ => DateRangeData(today.format(storedDateFormat), today.format(storedDateFormat), 0)
    }
}
