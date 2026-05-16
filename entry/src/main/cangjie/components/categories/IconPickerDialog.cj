package ohos_app_cangjie_entry.components.categories

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*

@Component
public class IconPickerDialog {
    @Prop var selectedIcon: String
    @Link var visible: Bool
    @Link var draftIcon: String

    public func build(): Unit {
        Column(space: 8) {
            if (this.visible) {
                Text("Select an Icon")
                    .fontSize(18)
                    .fontColor(0xFF1C1B1F)
                ForEach(availableCategoryIcons(), itemGeneratorFunc: { icon: CategoryIconItem, _: Int64 =>
                    Button("${icon.symbol} ${icon.name}")
                        .width(100.percent)
                        .fontColor(if (this.draftIcon == icon.name) { 0xFFFFFFFF } else { 0xFF6750A4 })
                        .backgroundColor(if (this.draftIcon == icon.name) { 0xFF6750A4 } else { 0xFFF3EDF8 })
                        .borderRadius(18)
                        .onClick({ _ =>
                            this.draftIcon = icon.name
                            this.visible = false
                        })
                }, keyGeneratorFunc: { icon: CategoryIconItem, _: Int64 =>
                    icon.name
                })
                Button("Close")
                    .backgroundColor(0xFFF3EDF8)
                    .borderRadius(18)
                    .onClick({ _ =>
                        this.visible = false
                    })
            }
        }
        .padding(12)
        .width(100.percent)
    }
}