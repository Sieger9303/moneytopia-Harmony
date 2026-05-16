package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import std.collection.ArrayList
import ohos_app_cangjie_entry.components.about.Contributor
import ohos_app_cangjie_entry.components.about.SocialMediaLink
import ohos_app_cangjie_entry.components.header.HeaderCard

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
            HeaderCard(title: "About", iconGlyph: "M", infoGlyph: "i", subtitle: "App details, links, and contributors")

            Column(space: 8) {
                Row() {
                    Text("M")
                        .fontSize(28)
                        .fontColor(0xFF6750A4)
                }
                .width(72)
                .height(72)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)
                .borderRadius(24)
                .backgroundColor(0xFFE8DDFF)
                Text("Moneytopia")
                    .fontSize(24)
                    .fontColor(0xFF1C1B1F)
                Text("v1.0.2")
                    .fontSize(13)
                    .fontColor(0xFF7B7388)
            }
            .padding(left: 20, right: 20, top: 20, bottom: 20)
            .width(100.percent)
            .alignItems(HorizontalAlign.Center)
            .borderRadius(26)
            .backgroundColor(0xFFFDF8FF)

            Text("Social links")
                .fontSize(18)
                .fontColor(0xFF1C1B1F)
            SocialMediaLink(title: "GitHub", url: "https://github.com/dimrnhhh")
            SocialMediaLink(title: "Behance", url: "https://www.behance.net/dimrnhhh")
            SocialMediaLink(title: "LinkedIn", url: "https://www.linkedin.com/in/dimrnhhh/")
            SocialMediaLink(title: "Instagram", url: "https://www.instagram.com/dimrnhhh/")

            Text("Contributors")
                .fontSize(18)
                .fontColor(0xFF1C1B1F)
            ForEach(this.contributors(), itemGeneratorFunc: { contributor: Contributor, _: Int64 =>
                Column(space: 3) {
                    Text(contributor.name)
                        .fontSize(16)
                        .fontColor(0xFF1C1B1F)
                    Text(contributor.role)
                        .fontSize(12)
                        .fontColor(0xFF7B7388)
                }
                .padding(left: 14, right: 14, top: 14, bottom: 14)
                .width(100.percent)
                .borderRadius(24)
                .backgroundColor(0xFFFDF8FF)
            }, keyGeneratorFunc: { contributor: Contributor, _: Int64 =>
                contributor.role
            })
        }
        .width(100.percent)
    }
}