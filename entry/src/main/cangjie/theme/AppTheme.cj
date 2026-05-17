package ohos_app_cangjie_entry.theme

import kit.LocalizationKit.*
import ohos.business_exception.BusinessException
import kit.PerformanceAnalysisKit.Hilog
import ohos_app_cangjie_entry.runtime.AppRuntime

public struct AppTheme {
    public static let transparentStatusBar: Bool = true
    public static let useDynamicColor: Bool = true

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
            Hilog.error(1, "Moneytopia", "AppTheme.isDarkMode failed: ")
            return false
        }
    }

    public static func colorByName(name: String, fallback: UInt32): UInt32 {
        try {
            match (AppRuntime.abilityContext) {
                case Option.Some(context) =>
                    return context.resourceManager.getColorByName(name)
                case _ => return fallback
            }
        } catch (e: BusinessException) {
            Hilog.error(1, "Moneytopia", "AppTheme.colorByName() failed: ")
            return fallback
        }
    }

    public static func appBackground(): UInt32 { AppTheme.colorByName("app_bg", 0xFFF6F1FA) }
    public static func surfacePrimary(): UInt32 { AppTheme.colorByName("surface_primary", 0xFFFDF8FF) }
    public static func surfaceSecondary(): UInt32 { AppTheme.colorByName("surface_secondary", 0xFFF3EDF8) }
    public static func surfaceAccentSoft(): UInt32 { AppTheme.colorByName("surface_accent_soft", 0xFFEFE6FD) }
    public static func surfaceAccentStrong(): UInt32 { AppTheme.colorByName("surface_accent_strong", 0xFFE8DDFF) }
    public static func surfaceSelected(): UInt32 { AppTheme.colorByName("surface_selected", 0xFFF8F1FF) }
    public static func surfaceElevated(): UInt32 { AppTheme.colorByName("surface_elevated", 0xFFFFFFFF) }
    public static func surfaceInteractive(): UInt32 { AppTheme.colorByName("surface_interactive", 0xFFF2EAFD) }
    public static func surfaceDangerSoft(): UInt32 { AppTheme.colorByName("surface_danger_soft", 0xFFFFF0F2) }
    public static func surfaceDangerPanel(): UInt32 { AppTheme.colorByName("surface_danger_panel", 0xFFFFF8F8) }
    public static func textPrimary(): UInt32 { AppTheme.colorByName("text_primary", 0xFF1C1B1F) }
    public static func textSecondary(): UInt32 { AppTheme.colorByName("text_secondary", 0xFF7B7388) }
    public static func textTertiary(): UInt32 { AppTheme.colorByName("text_tertiary", 0xFF5F596B) }
    public static func textBrandStrong(): UInt32 { AppTheme.colorByName("text_brand_strong", 0xFF403457) }
    public static func brandPrimary(): UInt32 { AppTheme.colorByName("brand_primary", 0xFF6750A4) }
    public static func onBrandPrimary(): UInt32 { AppTheme.colorByName("on_brand_primary", 0xFFFFFFFF) }
    public static func dangerPrimary(): UInt32 { AppTheme.colorByName("danger_primary", 0xFFC84C58) }
}