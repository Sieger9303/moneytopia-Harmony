package ohos_app_cangjie_entry.components.navigation

public struct BottomNavItem {
    public let title: String
    public let iconName: String
    public let route: String

    public init(title: String, iconName: String, route: String) {
        this.title = title
        this.iconName = iconName
        this.route = route
    }
}