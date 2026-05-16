package ohos_app_cangjie_entry.components.header

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*

@Component
public class InfoDialog {
    @Prop var title: String
    @Prop var message: String

    public func build(): Unit {
        Column(space: 8) {
            Text(this.title)
                .fontSize(18)
            Text(this.message)
        }
        .padding(12)
    }
}