package ohos_app_cangjie_entry.entryability

import kit.AbilityKit.Want
import kit.AbilityKit.UIAbility
import kit.AbilityKit.LaunchParam
import kit.ArkUI.WindowStage
import kit.PerformanceAnalysisKit.Hilog

class EntryAbility <: UIAbility {
    public init() {
        super()
        registerSelf()
    }

    public override func onCreate(want: Want, launchParam: LaunchParam): Unit {
        Hilog.info(1, "Moneytopia", "EntryAbility onCreate")
    }

    public override func onWindowStageCreate(windowStage: WindowStage): Unit {
        Hilog.info(1, "Moneytopia", "EntryAbility onWindowStageCreate")
        windowStage.loadContent("EntryView")
    }
}