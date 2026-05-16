package ohos_app_cangjie_entry.components.navigation

public struct BottomNavItem {
    public let title: String
    public let iconGlyph: String
    public let route: String

    public init(title: String, iconGlyph: String, route: String) {
        this.title = title
        this.iconGlyph = iconGlyph
        this.route = route
    }
}