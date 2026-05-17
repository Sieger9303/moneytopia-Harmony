package ohos_app_cangjie_entry.runtime

import kit.AbilityKit.UIAbilityContext

public class AppRuntime {
    public static var abilityContext: Option<UIAbilityContext> = Option.None

    public static func setAbilityContext(context: UIAbilityContext): Unit {
        AppRuntime.abilityContext = Option.Some(context)
    }
}