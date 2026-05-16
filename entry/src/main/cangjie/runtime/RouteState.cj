package ohos_app_cangjie_entry.runtime

public class RouteState {
    public static var currentRoute: String = "expenses"
    public static var currentLinkTitle: String = ""
    public static var currentLinkUrl: String = ""

    public static func navigate(route: String): Unit {
        RouteState.currentRoute = route
    }

    public static func navigateToLink(title: String, url: String): Unit {
        RouteState.currentLinkTitle = title
        RouteState.currentLinkUrl = url
        RouteState.currentRoute = "settings/about/web"
    }
}