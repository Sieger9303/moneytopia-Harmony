package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos.web.webview.*
import ohos_app_cangjie_entry.runtime.RouteState
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class WebLinkPage {
    let webController = WebviewController()

    public func build(): Unit {
        Column(space: 12) {
            Text(RouteState.currentLinkTitle)
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTheme.textPrimary())
            Button("Back")
                .backgroundColor(AppTheme.surfaceSecondary())
                .fontColor(AppTheme.textPrimary())
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
        .backgroundColor(AppTheme.appBackground())
    }
}