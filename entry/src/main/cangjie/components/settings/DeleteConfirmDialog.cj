package ohos_app_cangjie_entry.components.settings

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*

@Component
public class DeleteConfirmDialog {
    @Prop var title: String
    @Prop var message: String

    public func build(): Unit {
        Column(space: 8) {
            Text(this.title)
                .fontSize(18)
            Text(this.message)
            Text("Delete")
        }
        .padding(12)
    }
}