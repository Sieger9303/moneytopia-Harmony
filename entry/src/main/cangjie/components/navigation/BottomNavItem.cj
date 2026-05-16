package ohos_app_cangjie_entry.components.navigation

public struct BottomNavItem {
    public let title: String
    public let selectedIcon: String
    public let unselectedIcon: String
    public let route: String

    public init(title: String, selectedIcon: String, unselectedIcon: String, route: String) {
        this.title = title
        this.selectedIcon = selectedIcon
        this.unselectedIcon = unselectedIcon
        this.route = route
    }
}