package ohos_app_cangjie_entry.components.settings

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*

@Component
public class CurrencyDialog {
    @Prop var currentSymbol: String

    public func build(): Unit {
        Column(space: 8) {
            Text("Currency")
                .fontSize(18)
            Text("Current: ${this.currentSymbol}")
        }
        .padding(12)
    }
}