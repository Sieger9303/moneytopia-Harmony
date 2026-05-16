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
                ForEach(availableCategoryIcons(), itemGeneratorFunc: { icon: CategoryIconItem, _: Int64 =>
                    Button("${icon.symbol} ${icon.name}")
                        .onClick({ _ =>
                            this.draftIcon = icon.name
                            this.visible = false
                        })
                }, keyGeneratorFunc: { icon: CategoryIconItem, _: Int64 =>
                    icon.name
                })
                Button("Close")
                    .onClick({ _ =>
                        this.visible = false
                    })
            }
        }
        .padding(12)
    }
}