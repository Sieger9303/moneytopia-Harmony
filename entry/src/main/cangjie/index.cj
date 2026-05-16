package ohos_app_cangjie_entry

import kit.ArkUI.*
import ohos_app_cangjie_entry.pages.MainPage
import ohos.arkui.state_macro_manage.*

@Entry
@Component
class EntryView {
    func build(): Unit {
        Column() {
            MainPage()
        }
    }
}