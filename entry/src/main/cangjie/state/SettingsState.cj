package ohos_app_cangjie_entry.state

import ohos_app_cangjie_entry.data.local.PreferenceStore

public class SettingsState {
    public var currencySymbol: String = "$"

    public init() {}

    public init(currencySymbol!: String) {
        this.currencySymbol = currencySymbol
    }
}

public func getSettingsSnapshot(): SettingsState {
    let preferenceStore = PreferenceStore()
    SettingsState(currencySymbol: preferenceStore.getCurrencySymbol())
}