package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import std.collection.ArrayList
import ohos_app_cangjie_entry.components.about.Contributor
import ohos_app_cangjie_entry.components.about.SocialMediaLink
import ohos_app_cangjie_entry.components.header.HeaderCard
import ohos_app_cangjie_entry.runtime.RouteState

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
        Scroll() {
            Column(space: 12) {
                HeaderCard(title: "About")
                Column(space: 6) {
                    Text("M")
                        .fontSize(34)
                    Text("Moneytopia")
                        .fontSize(24)
                    Text("v1.0.2")
                }
                Text("App links")
                    .fontSize(18)
                Text("Open the developer links inside the app web view.")
                SocialMediaLink(title: "GitHub", url: "https://github.com/dimrnhhh")
                SocialMediaLink(title: "Behance", url: "https://www.behance.net/dimrnhhh")
                SocialMediaLink(title: "LinkedIn", url: "https://www.linkedin.com/in/dimrnhhh/")
                SocialMediaLink(title: "Instagram", url: "https://www.instagram.com/dimrnhhh/")
                Text("Contributors")
                    .fontSize(20)
                ForEach(this.contributors(), itemGeneratorFunc: { contributor: Contributor, _: Int64 =>
                    Column(space: 2) {
                        Text(contributor.name)
                        Text(contributor.role)
                    }
                    .padding(8)
                }, keyGeneratorFunc: { contributor: Contributor, _: Int64 =>
                    contributor.role
                })
                Button("Back to Settings")
                    .onClick({ _ =>
                        RouteState.navigate("settings")
                    })
            }
            .padding(16)
        }
    }
}