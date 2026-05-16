package ohos_app_cangjie_entry.state

import ohos_app_cangjie_entry.data.local.PreferenceStore

public class SettingsState {
    public var currencySymbol: String = "$"
    public var languageCode: String = "en"

    public init() {}

    public init(currencySymbol!: String, languageCode!: String) {
        this.currencySymbol = currencySymbol
        this.languageCode = languageCode
    }
}

public func getSettingsSnapshot(): SettingsState {
    let preferenceStore = PreferenceStore()
    SettingsState(currencySymbol: preferenceStore.getCurrencySymbol(), languageCode: preferenceStore.getLanguageCode())
}