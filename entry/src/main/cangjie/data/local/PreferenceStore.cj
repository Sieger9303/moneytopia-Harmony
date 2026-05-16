package ohos_app_cangjie_entry.data.local

public class PreferenceStore {
    private static var sharedCurrencySymbol: String = "$"
    private static var sharedLanguageCode: String = "en"

    public init() {}

    public func saveCurrencySymbol(symbol: String): Unit {
        PreferenceStore.sharedCurrencySymbol = symbol
    }

    public func getCurrencySymbol(): String {
        PreferenceStore.sharedCurrencySymbol
    }

    public func saveLanguageCode(languageCode: String): Unit {
        PreferenceStore.sharedLanguageCode = languageCode
    }

    public func getLanguageCode(): String {
        PreferenceStore.sharedLanguageCode
    }
}