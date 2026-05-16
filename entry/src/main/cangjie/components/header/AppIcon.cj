package ohos_app_cangjie_entry.components.header

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*

@Component
public class AppIcon {
    @Prop var name: String
    @Prop var size: Int64
    @Prop var color: Int64

    private func symbol(): String {
        if (this.name == "wallet") { return "¤" }
        if (this.name == "report") { return "▤" }
        if (this.name == "analytics") { return "▥" }
        if (this.name == "settings") { return "#" }
        if (this.name == "info") { return "?" }
        if (this.name == "add") { return "+" }
        if (this.name == "close") { return "x" }
        if (this.name == "categories") { return "[]" }
        if (this.name == "language") { return "()" }
        if (this.name == "about") { return "<>" }
        if (this.name == "link") { return "/>" }
        if (this.name == "delete") { return "-" }
        if (this.name == "currency") { return "$" }
        if (this.name == "check") { return "v" }
        if (this.name == "dot") { return "." }
        return "o"
    }

    public func build(): Unit {
        Text(this.symbol())
            .fontSize(this.size)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.color)
    }
}