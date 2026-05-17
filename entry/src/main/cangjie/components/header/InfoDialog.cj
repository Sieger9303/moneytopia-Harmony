package ohos_app_cangjie_entry.components.header

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class InfoDialog {
    @Prop var title: String
    @Prop var message: String

    public func build(): Unit {
        Column(space: 8) {
            Text(this.title)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTheme.textPrimary())
            Text(this.message)
                .fontSize(13)
                .fontColor(AppTheme.textTertiary())
        }
        .padding(12)
        .width(100.percent)
        .borderRadius(20)
        .backgroundColor(AppTheme.surfacePrimary())
    }
}