package ohos_app_cangjie_entry.components.settings

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class CurrencyDialog {
    @Prop var currentSymbol: String

    public func build(): Unit {
        Column(space: 8) {
            Text("Currency")
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTheme.textPrimary())
            Text("Current: ")
                .fontSize(13)
                .fontColor(AppTheme.textSecondary())
        }
        .padding(12)
        .width(100.percent)
        .borderRadius(20)
        .backgroundColor(AppTheme.surfaceSelected())
    }
}