package ohos_app_cangjie_entry.data.local

import ohos_app_cangjie_entry.runtime.RouteState

public class PreferenceStore {
    private static var sharedCurrencySymbol: String = "$"
    private static var sharedLanguageCode: String = "en"

    public init() {}

    public func saveCurrencySymbol(symbol: String): Unit {
        PreferenceStore.sharedCurrencySymbol = symbol
        RouteState.notifyDataChanged()
    }

    public func getCurrencySymbol(): String {
        PreferenceStore.sharedCurrencySymbol
    }

    public func saveLanguageCode(languageCode: String): Unit {
        PreferenceStore.sharedLanguageCode = languageCode
        RouteState.notifyDataChanged()
    }

    public func getLanguageCode(): String {
        PreferenceStore.sharedLanguageCode
    }
}