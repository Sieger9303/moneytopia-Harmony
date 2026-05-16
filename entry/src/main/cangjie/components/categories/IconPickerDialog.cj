package ohos_app_cangjie_entry.components.categories

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.header.AppIcon

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
                    Row(space: 10) {
                        Row() {
                            AppIcon(name: icon.iconName, size: 18, color: if (this.draftIcon == icon.name) { 0xFFFFFFFF } else { 0xFF6750A4 })
                        }
                        .width(34)
                        .height(34)
                        .justifyContent(FlexAlign.Center)
                        .alignItems(VerticalAlign.Center)
                        .borderRadius(17)
                        .backgroundColor(if (this.draftIcon == icon.name) { 0xFF7B58C9 } else { 0xFFEFE6FD })

                        Text(icon.name)
                            .fontSize(14)
                            .fontColor(if (this.draftIcon == icon.name) { 0xFFFFFFFF } else { 0xFF1C1B1F })
                    }
                    .padding(left: 12, right: 12, top: 10, bottom: 10)
                    .width(100.percent)
                    .alignItems(VerticalAlign.Center)
                    .borderRadius(18)
                    .backgroundColor(if (this.draftIcon == icon.name) { 0xFF6750A4 } else { 0xFFF3EDF8 })
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