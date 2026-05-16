package ohos_app_cangjie_entry.components.charts

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*

@Component
public class ChartMarker {
    @Prop var label: String

    public func build(): Unit {
        Text(this.label)
            .padding(8)
    }
}