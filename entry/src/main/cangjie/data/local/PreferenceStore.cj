package ohos_app_cangjie_entry.data.local

import kit.ArkData.*
import ohos.business_exception.BusinessException
import kit.PerformanceAnalysisKit.Hilog
import ohos_app_cangjie_entry.runtime.AppRuntime
import ohos_app_cangjie_entry.runtime.RouteState

public class PreferenceStore {
    private static let prefsName: String = "moneytopia_prefs"
    private static let currencySymbolKey: String = "currency_symbol"
    private static let defaultCurrencySymbol: String = "$"

    public init() {}

    private func getPreferencesOrNone(): Option<Preferences> {
        match (AppRuntime.abilityContext) {
            case Option.Some(context) => Option.Some(Preferences.getPreferences(context, PreferencesOptions(PreferenceStore.prefsName)))
            case _ => Option.None
        }
    }

    public func saveCurrencySymbol(symbol: String): Unit {
        let value = if (symbol == "") { PreferenceStore.defaultCurrencySymbol } else { symbol }
        try {
            match (this.getPreferencesOrNone()) {
                case Option.Some(preferences) =>
                    preferences.put(PreferenceStore.currencySymbolKey, PreferencesValueType.StringData(value))
                    preferences.flush()
                case _ =>
                    Hilog.error(1, "Moneytopia", "UIAbilityContext is not ready for saving currency symbol")
            }
        } catch (e: BusinessException) {
            Hilog.error(1, "Moneytopia", "Failed to save currency symbol: ${e.message}")
        }
        RouteState.notifyDataChanged()
    }

    public func getCurrencySymbol(): String {
        try {
            match (this.getPreferencesOrNone()) {
                case Option.Some(preferences) =>
                    let value = preferences.get(PreferenceStore.currencySymbolKey, PreferencesValueType.StringData(PreferenceStore.defaultCurrencySymbol))
                    match (value) {
                        case PreferencesValueType.StringData(symbol) =>
                            if (symbol == "") {
                                return PreferenceStore.defaultCurrencySymbol
                            }
                            return symbol
                        case _ => return PreferenceStore.defaultCurrencySymbol
                    }
                case _ =>
                    Hilog.error(1, "Moneytopia", "UIAbilityContext is not ready for loading currency symbol")
                    return PreferenceStore.defaultCurrencySymbol
            }
        } catch (e: BusinessException) {
            Hilog.error(1, "Moneytopia", "Failed to load currency symbol: ${e.message}")
            return PreferenceStore.defaultCurrencySymbol
        }
    }
}