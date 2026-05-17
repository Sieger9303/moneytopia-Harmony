package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos.web.webview.*
import ohos_app_cangjie_entry.runtime.RouteState

@Component
public class WebLinkPage {
    let webController = WebviewController()

    public func build(): Unit {
        Column(space: 12) {
            Text(RouteState.currentLinkTitle)
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(0xFF1C1B1F)
            Button("Back")
                .backgroundColor(0xFFF3EDF8)
                .borderRadius(20)
                .onClick({ _ =>
                    RouteState.navigate("settings/about")
                })
            Web(src: RouteState.currentLinkUrl, controller: this.webController)
                .width(100.percent)
                .height(85.percent)
        }
        .padding(16)
        .width(100.percent)
        .height(100.percent)
    }
}