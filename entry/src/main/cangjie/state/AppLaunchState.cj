package ohos_app_cangjie_entry.state

public class AppLaunchState {
    public var isSplashVisible: Bool = true

    public func finishLaunch(): Unit {
        this.isSplashVisible = false
    }
}