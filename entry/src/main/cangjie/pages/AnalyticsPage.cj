package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.charts.ChartsSection
import ohos_app_cangjie_entry.runtime.RouteState

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

    public func build(): Unit {
        Scroll() {
            Column(space: 12) {
                Text("Analytics")
                    .fontSize(24)

                Row(space: 8) {
                    Button("Weekly")
                        .onClick({ _ =>
                            this.selectedMode = "Weekly"
                            this.selectedPage = 0
                        })
                    Button("Monthly")
                        .onClick({ _ =>
                            this.selectedMode = "Monthly"
                            this.selectedPage = 0
                        })
                    Button("Yearly")
                        .onClick({ _ =>
                            this.selectedMode = "Yearly"
                            this.selectedPage = 0
                        })
                }

                Row(space: 8) {
                    Button("Previous")
                        .enabled(this.selectedPage + 1 < this.pageLimit())
                        .onClick({ _ =>
                            if (this.selectedPage + 1 < this.pageLimit()) {
                                this.selectedPage += 1
                            }
                        })
                    Button("Next")
                        .enabled(this.selectedPage > 0)
                        .onClick({ _ =>
                            if (this.selectedPage > 0) {
                                this.selectedPage -= 1
                            }
                        })
                    Text("Page ${this.selectedPage + 1} / ${this.pageLimit()}")
                }

                ChartsSection(page: this.selectedPage, recurrenceName: this.selectedMode, title: this.selectedMode)

                Button("Back to Expenses")
                    .onClick({ _ =>
                        RouteState.navigate("expenses")
                    })
            }
            .padding(16)
        }
    }
}