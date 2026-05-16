package ohos_app_cangjie_entry.components.header

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*

@Component
public class HeaderCard {
    @Prop var title: String

    public func build(): Unit {
        Row(space: 12) {
            Text(this.title)
                .fontSize(20)
            Text("i")
        }
        .padding(16)
    }
}