package ohos_app_cangjie_entry

import kit.AbilityKit.Want
import kit.AbilityKit.UIAbility
import kit.AbilityKit.LaunchParam
import kit.ArkUI.WindowStage
import kit.PerformanceAnalysisKit.Hilog
import ohos_app_cangjie_entry.runtime.AppRuntime

class EntryAbility <: UIAbility {
    public init() {
        super()
        registerSelf()
    }

    public override func onCreate(want: Want, launchParam: LaunchParam): Unit {
        Hilog.info(1, "Moneytopia", "EntryAbility onCreate")
        AppRuntime.setAbilityContext(this.context)
    }

    public override func onWindowStageCreate(windowStage: WindowStage): Unit {
        Hilog.info(1, "Moneytopia", "EntryAbility onWindowStageCreate")
        windowStage.loadContent("EntryView")
    }
}