package ohos_app_cangjie_entry.components.header

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.runtime.RouteState

@Component
public class HeaderCard {
    @Prop var title: String
    @Prop var iconName: String
    @Prop var actionIconName: String
    @Prop var subtitle: String
    @Prop var dialogText: String
    @Prop var actionRoute: String

    @State var showDialog: Bool = false

    private func handleAction(): Unit {
        if (this.dialogText != "") {
            this.showDialog = true
            return
        }
        if (this.actionRoute != "") {
            RouteState.navigate(this.actionRoute)
        }
    }

    public func build(): Unit {
        Column(space: 10) {
            Row(space: 12) {
                Row() {
                    AppIcon(name: this.iconName, size: 22, color: 0xFF6750A4)
                }
                .width(48)
                .height(48)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)
                .borderRadius(24)
                .backgroundColor(0xFFE9DFFF)

                Column(space: 2) {
                    Text(this.title)
                        .fontSize(21)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(0xFF1C1B1F)
                    if (this.subtitle != "") {
                        Text(this.subtitle)
                            .fontSize(12)
                            .fontColor(0xFF7B7388)
                    }
                }
                .width(48.percent)
                .alignItems(HorizontalAlign.Start)

                if (this.actionIconName != "") {
                    Row() {
                        AppIcon(name: this.actionIconName, size: 16, color: 0xFF6750A4)
                    }
                    .width(40)
                    .height(40)
                    .justifyContent(FlexAlign.Center)
                    .alignItems(VerticalAlign.Center)
                    .borderRadius(20)
                    .backgroundColor(0xFFF3EDF8)
                    .onClick({ _ =>
                        this.handleAction()
                    })
                }
            }
            .padding(left: 22, right: 14, top: 15, bottom: 15)
            .width(100.percent)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .borderRadius(999)
            .backgroundColor(0xFFFDF8FF)

            if (this.showDialog) {
                Column(space: 8) {
                    Text(this.title)
                        .fontSize(16)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(0xFF1C1B1F)
                    Text(this.dialogText)
                        .fontSize(13)
                        .fontColor(0xFF5F596B)
                    Row(space: 8) {
                        Button("Close")
                            .backgroundColor(0xFFF3EDF8)
                            .borderRadius(18)
                            .onClick({ _ =>
                                this.showDialog = false
                            })
                    }
                    .width(100.percent)
                    .justifyContent(FlexAlign.End)
                }
                .padding(left: 16, right: 16, top: 16, bottom: 16)
                .width(100.percent)
                .borderRadius(22)
                .backgroundColor(0xFFFFFFFF)
            }
        }
        .width(100.percent)
    }
}