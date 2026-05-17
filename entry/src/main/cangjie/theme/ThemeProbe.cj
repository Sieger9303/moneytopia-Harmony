package ohos_app_cangjie_entry.theme

import kit.LocalizationKit.*
import ohos.business_exception.BusinessException
import kit.PerformanceAnalysisKit.Hilog
import ohos_app_cangjie_entry.runtime.AppRuntime

public struct ThemeProbe {
    public static func isDarkMode(): Bool {
        try {
            match (AppRuntime.abilityContext) {
                case Option.Some(context) =>
                    let configuration = context.resourceManager.getConfiguration()
                    match (configuration.colorMode) {
                        case ColorMode.Dark => return true
                        case _ => return false
                    }
                case _ => return false
            }
        } catch (e: BusinessException) {
            Hilog.error(1, "Moneytopia", "ThemeProbe.isDarkMode failed: ${e.message}")
            return false
        }
    }

    public static func appBackgroundColor(): UInt32 {
        try {
            match (AppRuntime.abilityContext) {
                case Option.Some(context) =>
                    return context.resourceManager.getColorByName("app_bg")
                case _ => return 0xFFF6F1FA
            }
        } catch (e: BusinessException) {
            Hilog.error(1, "Moneytopia", "ThemeProbe.appBackgroundColor failed: ${e.message}")
            return 0xFFF6F1FA
        }
    }
}