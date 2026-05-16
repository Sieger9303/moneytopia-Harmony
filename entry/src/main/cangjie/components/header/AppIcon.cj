package ohos_app_cangjie_entry.components.header

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos.resource.*

@Component
public class AppIcon {
    @Prop var name: String
    @Prop var size: Int64
    @Prop var color: Int64

    private func mediaResource(): AppResource {
        if (this.name == "wallet") { return @r(app.media.icon_account_balance_wallet) }
        if (this.name == "report") { return @r(app.media.icon_receipt_long) }
        if (this.name == "receipt") { return @r(app.media.icon_receipt) }
        if (this.name == "analytics") { return @r(app.media.icon_analytics) }
        if (this.name == "settings") { return @r(app.media.icon_settings) }
        if (this.name == "info") { return @r(app.media.icon_info) }
        if (this.name == "add") { return @r(app.media.icon_add) }
        if (this.name == "language") { return @r(app.media.icon_language) }
        if (this.name == "categories") { return @r(app.media.icon_category) }
        if (this.name == "currency") { return @r(app.media.icon_attach_money) }
        if (this.name == "delete") { return @r(app.media.icon_delete) }
        if (this.name == "error") { return @r(app.media.icon_error) }
        if (this.name == "chart") { return @r(app.media.icon_bar_chart) }
        if (this.name == "wallet_simple") { return @r(app.media.icon_wallet) }
        return @r(app.media.icon_info)
    }

    public func build(): Unit {
        Image(this.mediaResource())
            .width(this.size)
            .height(this.size)
            .objectFit(ImageFit.Contain)
    }
}