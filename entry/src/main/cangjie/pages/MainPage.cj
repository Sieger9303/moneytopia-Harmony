package ohos_app_cangjie_entry.pages

import std.collection.ArrayList
import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.header.AppIcon
import ohos_app_cangjie_entry.components.navigation.BottomNavItem
import ohos_app_cangjie_entry.runtime.RouteState
import ohos_app_cangjie_entry.theme.AppTheme

@Component
public class MainPage {
    @State var currentRoute: String = RouteState.currentRoute
    @State var routeVersion: Int64 = 0

    private func navItems(): ArrayList<BottomNavItem> {
        let items = ArrayList<BottomNavItem>()
        items.add(BottomNavItem("Expenses", "wallet", "expenses"))
        items.add(BottomNavItem("Reports", "report", "reports"))
        items.add(BottomNavItem("Analytics", "analytics", "analytics"))
        items.add(BottomNavItem("Settings", "settings", "settings"))
        items
    }

    private func syncRoute(): Unit {
        this.currentRoute = RouteState.currentRoute
        this.routeVersion += 1
    }

    private func isTabSelected(route: String): Bool {
        if (route == "expenses") {
            return this.currentRoute == "expenses" || this.currentRoute == "expenses/add_expenses"
        }
        return this.currentRoute == route
    }

    private func showBottomBar(): Bool {
        return this.currentRoute == "expenses" || this.currentRoute == "reports" || this.currentRoute == "analytics" || this.currentRoute == "settings"
    }

    private func showFloatingAdd(): Bool {
        return this.currentRoute == "expenses"
    }

    public func aboutToAppear(): Unit {
        RouteState.setChangeHandler({ =>
            this.syncRoute()
        })
        this.syncRoute()
    }

    @Builder
    private func activePage(): Unit {
        if (this.currentRoute == "expenses") {
            ExpensesPage()
        }
        if (this.currentRoute == "expenses/add_expenses") {
            AddExpensePage()
        }
        if (this.currentRoute == "reports") {
            ReportsPage()
        }
        if (this.currentRoute == "analytics") {
            AnalyticsPage()
        }
        if (this.currentRoute == "settings") {
            SettingsPage()
        }
        if (this.currentRoute == "settings/languages") {
            LanguagesPage()
        }
        if (this.currentRoute == "settings/about") {
            AboutPage()
        }
        if (this.currentRoute == "settings/about/web") {
            WebLinkPage()
        }
        if (this.currentRoute == "settings/categories") {
            CategoryPage()
        }
    }

    public func build(): Unit {
        Column() {
            if (this.showBottomBar()) {

                Stack(alignContent: Alignment.BottomEnd) {
                    Column() {
                        this.activePage()
                    }
                    .width(100.percent)
                    .height(100.percent)

                    if (this.showFloatingAdd()) {
                        Button("+")
                            .width(58)
                            .height(58)
                            .fontSize(26)
                            .fontWeight(FontWeight.Medium)
                            .fontColor(AppTheme.onBrandPrimary())
                            .backgroundColor(AppTheme.brandPrimary())
                            .borderRadius(20)
                            .margin(right: 24, bottom: 24)
                            .onClick({ _ =>
                                RouteState.navigate("expenses/add_expenses")
                            })
                    }
                }
                .width(100.percent)
                .height(88.percent)
                .backgroundColor(AppTheme.appBackground())

                Column() {
                    Row(space: 8) {
                        ForEach(this.navItems(), itemGeneratorFunc: { item: BottomNavItem, _: Int64 =>
                            Column(space: 6) {
                                Row() {
                                    AppIcon(name: item.iconName, size: 15, color: if (this.isTabSelected(item.route)) { Int64(AppTheme.onBrandPrimary()) } else { Int64(AppTheme.textSecondary()) })
                                }
                                .width(40)
                                .height(40)
                                .justifyContent(FlexAlign.Center)
                                .alignItems(VerticalAlign.Center)
                                .borderRadius(20)
                                .backgroundColor(if (this.isTabSelected(item.route)) { AppTheme.brandPrimary() } else { AppTheme.surfaceSecondary() })

                                Text(item.title)
                                    .fontSize(12)
                                    .fontWeight(if (this.isTabSelected(item.route)) { FontWeight.Medium } else { FontWeight.Regular })
                                    .fontColor(if (this.isTabSelected(item.route)) { AppTheme.textPrimary() } else { AppTheme.textSecondary() })
                            }
                            .width(23.percent)
                            .alignItems(HorizontalAlign.Center)
                            .padding(top: 8, bottom: 8)
                            .onClick({ _ =>
                                RouteState.navigate(item.route)
                            })
                        }, keyGeneratorFunc: { item: BottomNavItem, _: Int64 =>
                            item.route
                        })
                    }
                    .width(100.percent)
                    .justifyContent(FlexAlign.SpaceBetween)
                    .alignItems(VerticalAlign.Center)
                }
                .width(100.percent)
                .padding(left: 14, right: 14, top: 10, bottom: 12)
                .borderRadius(30)
                .backgroundColor(AppTheme.surfacePrimary())
                .margin(left: 16, right: 16, top: 4, bottom: 16)
            } else {
                Scroll() {
                    Column() {
                        this.activePage()
                    }
                    .padding(left: 16, right: 16, top: 18, bottom: 24)
                    .width(100.percent)
                    .alignItems(HorizontalAlign.Center)
                }
                .scrollBar(BarState.Off)
                .width(100.percent)
                .height(100.percent)
            }
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(AppTheme.appBackground())
    }
}
