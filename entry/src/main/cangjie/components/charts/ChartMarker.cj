package ohos_app_cangjie_entry.components.charts

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class ChartMarker {
    @Prop var label: String

    public func build(): Unit {
        Text(this.label)
            .fontSize(13)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTheme.brandPrimary())
            .padding(left: 12, right: 12, top: 8, bottom: 8)
            .borderRadius(16)
            .backgroundColor(AppTheme.surfaceInteractive())
    }
}