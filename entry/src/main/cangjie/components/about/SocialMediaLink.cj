package ohos_app_cangjie_entry.components.about

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.runtime.RouteState

@Component
public class SocialMediaLink {
    @Prop var title: String
    @Prop var url: String

    public func build(): Unit {
        Button(this.title)
            .onClick({ _ =>
                RouteState.navigateToLink(this.title, this.url)
            })
    }
}