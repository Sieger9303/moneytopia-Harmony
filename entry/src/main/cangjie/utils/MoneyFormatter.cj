package ohos_app_cangjie_entry.utils

import std.convert.*

private func compactAmount(amount: Float64): String {
    let formatted = amount.format(".2")
    let trimmedZeros = formatted.trimEnd("0")
    if (trimmedZeros.endsWith(".")) {
        return trimmedZeros.trimEnd(".")
    }
    return trimmedZeros
}

public func formatMoney(amount: Float64, currencySymbol: String): String {
    return "${currencySymbol}${compactAmount(amount)}"
}

public func formatExpenseMoney(amount: Float64, currencySymbol: String): String {
    return "-${currencySymbol}${compactAmount(amount)}"
}

public func formatCompactAmount(amount: Float64): String {
    return compactAmount(amount)
}