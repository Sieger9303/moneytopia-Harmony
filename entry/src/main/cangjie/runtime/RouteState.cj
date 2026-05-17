package ohos_app_cangjie_entry.runtime

public class RouteState {
    public static var currentRoute: String = "expenses"
    public static var currentLinkTitle: String = ""
    public static var currentLinkUrl: String = ""
    private static var onChange: Option<() -> Unit> = Option.None

    public static func setChangeHandler(handler: () -> Unit): Unit {
        RouteState.onChange = Option.Some(handler)
    }

    private static func emitChange(): Unit {
        RouteState.onChange?()
    }

    public static func navigate(route: String): Unit {
        RouteState.currentRoute = route
        RouteState.emitChange()
    }

    public static func navigateToLink(title: String, url: String): Unit {
        RouteState.currentLinkTitle = title
        RouteState.currentLinkUrl = url
        RouteState.currentRoute = "settings/about/web"
        RouteState.emitChange()
    }

    public static func notifyDataChanged(): Unit {
        RouteState.emitChange()
    }
}