package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.header.HeaderCard
import ohos_app_cangjie_entry.runtime.RouteState
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class LanguagesPage {
    public func build(): Unit {
        Column(space: 16) {
            HeaderCard(
                title: "Language",
                iconName: "language",
                actionIconName: "info",
                subtitle: "Change the app language in system settings",
                dialogText: "The original Kotlin app does not provide an in-app language picker. After confirming the caution dialog in Settings, transaction data is cleared and the app language should be changed from system settings.",
                actionRoute: ""
            )

            Column(space: 10) {
                Text("System language change required")
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTheme.textPrimary())
                Text("This HarmonyOS fallback page is informational only. Change the app language in system settings, then return to Moneytopia.")
                    .fontSize(13)
                    .fontColor(AppTheme.textTertiary())
                Text("No internal language preference is saved here.")
                    .fontSize(12)
                    .fontColor(AppTheme.textSecondary())
            }
            .padding(left: 18, right: 18, top: 18, bottom: 18)
            .width(100.percent)
            .borderRadius(24)
            .backgroundColor(AppTheme.surfacePrimary())

            Button("Back to Settings")
                .fontColor(AppTheme.onBrandPrimary())
                .backgroundColor(AppTheme.brandPrimary())
                .borderRadius(18)
                .onClick({ _ =>
                    RouteState.navigate("settings")
                })
        }
        .width(100.percent)
    }
}