package ohos_app_cangjie_entry.components.categories

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.header.AppIcon
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class IconPickerDialog {
    @Prop var selectedIcon: String
    @Link var visible: Bool
    @Link var draftIcon: String

    private func iconForeground(selected: Bool): Int64 {
        if (selected) {
            return Int64(AppTheme.onBrandPrimary())
        }
        return Int64(AppTheme.brandPrimary())
    }

    private func iconChipSurface(selected: Bool): UInt32 {
        if (selected) {
            return AppTheme.brandPrimary()
        }
        return AppTheme.surfaceAccentSoft()
    }

    private func rowSurface(selected: Bool): UInt32 {
        if (selected) {
            return AppTheme.brandPrimary()
        }
        return AppTheme.surfaceSecondary()
    }

    private func rowText(selected: Bool): UInt32 {
        if (selected) {
            return AppTheme.onBrandPrimary()
        }
        return AppTheme.textPrimary()
    }

    public func build(): Unit {
        Column(space: 8) {
            if (this.visible) {
                Text("Select an Icon")
                    .fontSize(18)
                    .fontColor(AppTheme.textPrimary())
                ForEach(availableCategoryIcons(), itemGeneratorFunc: { icon: CategoryIconItem, _: Int64 =>
                    Row(space: 10) {
                        Row() {
                            AppIcon(name: icon.iconName, size: 18, color: this.iconForeground(this.draftIcon == icon.name))
                        }
                        .width(34)
                        .height(34)
                        .justifyContent(FlexAlign.Center)
                        .alignItems(VerticalAlign.Center)
                        .borderRadius(17)
                        .backgroundColor(this.iconChipSurface(this.draftIcon == icon.name))

                        Text(icon.name)
                            .fontSize(14)
                            .fontColor(this.rowText(this.draftIcon == icon.name))
                    }
                    .padding(left: 12, right: 12, top: 10, bottom: 10)
                    .width(100.percent)
                    .alignItems(VerticalAlign.Center)
                    .borderRadius(18)
                    .backgroundColor(this.rowSurface(this.draftIcon == icon.name))
                    .onClick({ _ =>
                        this.draftIcon = icon.name
                        this.visible = false
                    })
                }, keyGeneratorFunc: { icon: CategoryIconItem, _: Int64 =>
                    icon.name
                })
                Button("Close")
                    .backgroundColor(AppTheme.surfaceSecondary())
                    .fontColor(AppTheme.textPrimary())
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