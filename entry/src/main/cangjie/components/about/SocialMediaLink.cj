package ohos_app_cangjie_entry.components.about

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.runtime.RouteState

@Component
public class SocialMediaLink {
    @Prop var title: String
    @Prop var url: String

    public func build(): Unit {
        Row(space: 10) {
            Row() {
                Text("L")
                    .fontSize(14)
                    .fontColor(0xFF6558A8)
            }
            .width(30)
            .height(30)
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            .borderRadius(15)
            .backgroundColor(0xFFE7E1FB)

            Column(space: 2) {
                Text(this.title)
                    .fontSize(15)
                    .fontColor(0xFF1C1B1F)
                Text(this.url)
                    .fontSize(11)
                    .fontColor(0xFF6A6672)
            }
            .width(70.percent)
            .alignItems(HorizontalAlign.Start)
        }
        .padding(left: 14, right: 14, top: 14, bottom: 14)
        .width(100.percent)
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)
        .borderRadius(20)
        .backgroundColor(0xFFFFFFFF)
        .onClick({ _ =>
            RouteState.navigateToLink(this.title, this.url)
        })
    }
}