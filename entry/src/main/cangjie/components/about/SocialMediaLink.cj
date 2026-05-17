package ohos_app_cangjie_entry.components.about

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.header.AppIcon
import ohos_app_cangjie_entry.runtime.RouteState
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class SocialMediaLink {
    @Prop var title: String
    @Prop var url: String

    private func iconName(): String {
        if (this.title == "GitHub") { return "settings" }
        if (this.title == "Behance") { return "analytics" }
        if (this.title == "LinkedIn") { return "language" }
        if (this.title == "Instagram") { return "wallet_simple" }
        return "info"
    }

    public func build(): Unit {
        Row(space: 10) {
            Row() {
                AppIcon(name: this.iconName(), size: 14, color: Int64(AppTheme.brandPrimary()))
            }
            .width(30)
            .height(30)
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            .borderRadius(15)
            .backgroundColor(AppTheme.surfaceAccentStrong())

            Column(space: 2) {
                Text(this.title)
                    .fontSize(15)
                    .fontColor(AppTheme.textPrimary())
                Text(this.url)
                    .fontSize(11)
                    .fontColor(AppTheme.textSecondary())
            }
            .width(70.percent)
            .alignItems(HorizontalAlign.Start)
        }
        .padding(left: 14, right: 14, top: 14, bottom: 14)
        .width(100.percent)
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)
        .borderRadius(20)
        .backgroundColor(AppTheme.surfaceElevated())
        .onClick({ _ =>
            RouteState.navigateToLink(this.title, this.url)
        })
    }
}