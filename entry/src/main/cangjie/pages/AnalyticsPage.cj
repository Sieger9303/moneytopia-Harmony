package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.header.HeaderCard
import ohos_app_cangjie_entry.components.charts.ChartsSection
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class AnalyticsPage {
    @State var selectedMode: String = "Weekly"
    @State var selectedPage: Int64 = 0

    private func pageLimit(): Int64 {
        if (this.selectedMode == "Monthly") {
            return 12
        }
        if (this.selectedMode == "Yearly") {
            return 1
        }
        return 53
    }

    private func modeButtonText(mode: String): UInt32 {
        if (this.selectedMode == mode) {
            return AppTheme.onBrandPrimary()
        }
        return AppTheme.brandPrimary()
    }

    private func modeButtonSurface(mode: String): UInt32 {
        if (this.selectedMode == mode) {
            return AppTheme.brandPrimary()
        }
        return AppTheme.surfaceInteractive()
    }

    public func build(): Unit {
        Column(space: 16) {
            HeaderCard(title: "Analytics", iconName: "analytics", actionIconName: "info", subtitle: "Browse weekly, monthly, and yearly trends", dialogText: "Switch weekly, monthly, and yearly periods here and keep the analytics page read-only like the source app.", actionRoute: "")

            Row(space: 8) {
                Button("Weekly")
                    .width(31.percent)
                    .fontColor(this.modeButtonText("Weekly"))
                    .backgroundColor(this.modeButtonSurface("Weekly"))
                    .borderRadius(999)
                    .onClick({ _ =>
                        this.selectedMode = "Weekly"
                        this.selectedPage = 0
                    })
                Button("Monthly")
                    .width(31.percent)
                    .fontColor(this.modeButtonText("Monthly"))
                    .backgroundColor(this.modeButtonSurface("Monthly"))
                    .borderRadius(999)
                    .onClick({ _ =>
                        this.selectedMode = "Monthly"
                        this.selectedPage = 0
                    })
                Button("Yearly")
                    .width(31.percent)
                    .fontColor(this.modeButtonText("Yearly"))
                    .backgroundColor(this.modeButtonSurface("Yearly"))
                    .borderRadius(999)
                    .onClick({ _ =>
                        this.selectedMode = "Yearly"
                        this.selectedPage = 0
                    })
            }
            .width(100.percent)
            .justifyContent(FlexAlign.SpaceBetween)
            .padding(left: 8, right: 8, top: 8, bottom: 8)
            .borderRadius(999)
            .backgroundColor(AppTheme.surfaceSelected())

            Row(space: 10) {
                Button("Previous")
                    .width(28.percent)
                    .backgroundColor(AppTheme.surfaceSecondary())
                    .fontColor(AppTheme.textPrimary())
                    .borderRadius(20)
                    .enabled(this.selectedPage + 1 < this.pageLimit())
                    .onClick({ _ =>
                        if (this.selectedPage + 1 < this.pageLimit()) {
                            this.selectedPage += 1
                        }
                    })
                Column(space: 2) {
                    Text(this.selectedMode)
                        .fontSize(15)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppTheme.textPrimary())
                    Text("Period  / ")
                        .fontSize(12)
                        .fontColor(AppTheme.textSecondary())
                }
                .width(38.percent)
                .alignItems(HorizontalAlign.Center)
                Button("Next")
                    .width(28.percent)
                    .backgroundColor(AppTheme.surfaceSecondary())
                    .fontColor(AppTheme.textPrimary())
                    .borderRadius(20)
                    .enabled(this.selectedPage > 0)
                    .onClick({ _ =>
                        if (this.selectedPage > 0) {
                            this.selectedPage -= 1
                        }
                    })
            }
            .padding(left: 14, right: 14, top: 14, bottom: 14)
            .width(100.percent)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .borderRadius(24)
            .backgroundColor(AppTheme.surfacePrimary())

            ChartsSection(page: this.selectedPage, recurrenceName: this.selectedMode, title: this.selectedMode)
        }
        .width(100.percent)
    }
}