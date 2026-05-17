package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import std.collection.ArrayList
import ohos_app_cangjie_entry.components.about.Contributor
import ohos_app_cangjie_entry.components.about.SocialMediaLink
import ohos_app_cangjie_entry.components.header.AppIcon
import ohos_app_cangjie_entry.runtime.RouteState
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class AboutPage {
    private func contributors(): ArrayList<Contributor> {
        let items = ArrayList<Contributor>()
        items.add(Contributor(name: "Dimas Rian Hastedi", role: "Development"))
        items.add(Contributor(name: "Dimas Rian Hastedi", role: "UI/UX Design"))
        items.add(Contributor(name: "Dimas Rian Hastedi", role: "Support"))
        items.add(Contributor(name: "Dimas Rian Hastedi", role: "Translation"))
        items
    }

    public func build(): Unit {
        Column(space: 16) {
            Row(space: 12) {
                Button("Back")
                    .backgroundColor(AppTheme.surfaceSecondary())
                    .fontColor(AppTheme.textPrimary())
                    .borderRadius(18)
                    .onClick({ _ =>
                        RouteState.navigate("settings")
                    })

                Column(space: 2) {
                    Text("About")
                        .fontSize(21)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppTheme.textPrimary())
                    Text("App details, links, and contributors")
                        .fontSize(12)
                        .fontColor(AppTheme.textSecondary())
                }
                .width(66.percent)
                .alignItems(HorizontalAlign.Start)
            }
            .padding(left: 18, right: 18, top: 15, bottom: 15)
            .width(100.percent)
            .alignItems(VerticalAlign.Center)
            .borderRadius(999)
            .backgroundColor(AppTheme.surfacePrimary())

            Column(space: 8) {
                Row() {
                    AppIcon(name: "wallet", size: 28, color: Int64(AppTheme.brandPrimary()))
                }
                .width(72)
                .height(72)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)
                .borderRadius(24)
                .backgroundColor(AppTheme.surfaceAccentStrong())
                Text("Moneytopia")
                    .fontSize(24)
                    .fontColor(AppTheme.textPrimary())
                Text("v1.0.2")
                    .fontSize(13)
                    .fontColor(AppTheme.textSecondary())
            }
            .padding(left: 20, right: 20, top: 20, bottom: 20)
            .width(100.percent)
            .alignItems(HorizontalAlign.Center)
            .borderRadius(26)
            .backgroundColor(AppTheme.surfacePrimary())

            Text("Social links")
                .fontSize(18)
                .fontColor(AppTheme.textPrimary())
                .width(100.percent)
            SocialMediaLink(title: "GitHub", url: "https://github.com/dimrnhhh")
            SocialMediaLink(title: "Behance", url: "https://www.behance.net/dimrnhhh")
            SocialMediaLink(title: "LinkedIn", url: "https://www.linkedin.com/in/dimrnhhh/")
            SocialMediaLink(title: "Instagram", url: "https://www.instagram.com/dimrnhhh/")

            Text("Contributors")
                .fontSize(18)
                .fontColor(AppTheme.textPrimary())
                .width(100.percent)
            ForEach(this.contributors(), itemGeneratorFunc: { contributor: Contributor, _: Int64 =>
                Column(space: 3) {
                    Text(contributor.name)
                        .fontSize(16)
                        .fontColor(AppTheme.textPrimary())
                    Text(contributor.role)
                        .fontSize(12)
                        .fontColor(AppTheme.textSecondary())
                }
                .padding(left: 14, right: 14, top: 14, bottom: 14)
                .width(100.percent)
                .borderRadius(24)
                .backgroundColor(AppTheme.surfacePrimary())
            }, keyGeneratorFunc: { contributor: Contributor, _: Int64 =>
                contributor.role
            })
        }
        .width(100.percent)
    }
}