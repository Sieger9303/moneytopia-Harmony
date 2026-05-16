package ohos_app_cangjie_entry.pages

import std.collection.ArrayList
import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.header.AppIcon
import ohos_app_cangjie_entry.components.navigation.BottomNavItem
import ohos_app_cangjie_entry.runtime.RouteState

@Component
public class MainPage {
    private func navItems(): ArrayList<BottomNavItem> {
        let items = ArrayList<BottomNavItem>()
        items.add(BottomNavItem("Expenses", "wallet", "expenses"))
        items.add(BottomNavItem("Reports", "report", "reports"))
        items.add(BottomNavItem("Analytics", "analytics", "analytics"))
        items.add(BottomNavItem("Settings", "settings", "settings"))
        items
    }

    private func isTabSelected(route: String): Bool {
        if (route == "expenses") {
            return RouteState.currentRoute == "expenses" || RouteState.currentRoute == "expenses/add_expenses"
        }
        if (route == "settings") {
            return RouteState.currentRoute == "settings" || RouteState.currentRoute == "settings/languages" || RouteState.currentRoute == "settings/about" || RouteState.currentRoute == "settings/about/web" || RouteState.currentRoute == "settings/categories"
        }
        return RouteState.currentRoute == route
    }

    private func showBottomBar(): Bool {
        return RouteState.currentRoute != "settings/about/web"
    }

    private func showFloatingAdd(): Bool {
        return RouteState.currentRoute == "expenses"
    }

    private func contentBottomPadding(): Int64 {
        if (this.showFloatingAdd()) {
            return 104
        }
        return 24
    }

    public func build(): Unit {
        Column() {
            if (this.showBottomBar()) {
                Stack() {
                    Scroll() {
                        Column() {
                            if (RouteState.currentRoute == "expenses") {
                                ExpensesPage()
                            }
                            if (RouteState.currentRoute == "expenses/add_expenses") {
                                AddExpensePage()
                            }
                            if (RouteState.currentRoute == "reports") {
                                ReportsPage()
                            }
                            if (RouteState.currentRoute == "analytics") {
                                AnalyticsPage()
                            }
                            if (RouteState.currentRoute == "settings") {
                                SettingsPage()
                            }
                            if (RouteState.currentRoute == "settings/languages") {
                                LanguagesPage()
                            }
                            if (RouteState.currentRoute == "settings/about") {
                                AboutPage()
                            }
                            if (RouteState.currentRoute == "settings/about/web") {
                                WebLinkPage()
                            }
                            if (RouteState.currentRoute == "settings/categories") {
                                CategoryPage()
                            }
                        }
                        .padding(left: 16, right: 16, top: 18, bottom: this.contentBottomPadding())
                        .width(100.percent)
                        .alignItems(HorizontalAlign.Center)
                    }
                    .scrollBar(BarState.Off)
                    .width(100.percent)
                    .height(100.percent)

                    if (this.showFloatingAdd()) {
                        Column() {
                            Button("+")
                                .width(58)
                                .height(58)
                                .fontSize(26)
                                .fontWeight(FontWeight.Medium)
                                .fontColor(0xFFFFFFFF)
                                .backgroundColor(0xFF6750A4)
                                .borderRadius(20)
                                .onClick({ _ =>
                                    RouteState.navigate("expenses/add_expenses")
                                })
                        }
                        .width(100.percent)
                        .height(100.percent)
                        .alignItems(HorizontalAlign.End)
                        .justifyContent(FlexAlign.End)
                        .padding(right: 24, bottom: 24)
                    }
                }
                .width(100.percent)
                .height(88.percent)
                .backgroundColor(0xFFF6F1FA)

                Column() {
                    Row(space: 8) {
                        ForEach(this.navItems(), itemGeneratorFunc: { item: BottomNavItem, _: Int64 =>
                            Column(space: 6) {
                                Row() {
                                    AppIcon(name: item.iconName, size: 15, color: if (this.isTabSelected(item.route)) { 0xFFFFFFFF } else { 0xFF7B7388 })
                                }
                                .width(40)
                                .height(40)
                                .justifyContent(FlexAlign.Center)
                                .alignItems(VerticalAlign.Center)
                                .borderRadius(20)
                                .backgroundColor(if (this.isTabSelected(item.route)) { 0xFF6750A4 } else { 0xFFF3EDF8 })

                                Text(item.title)
                                    .fontSize(12)
                                    .fontWeight(if (this.isTabSelected(item.route)) { FontWeight.Medium } else { FontWeight.Regular })
                                    .fontColor(if (this.isTabSelected(item.route)) { 0xFF1C1B1F } else { 0xFF7B7388 })
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
                .backgroundColor(0xFFFDF8FF)
                .margin(left: 16, right: 16, top: 4, bottom: 16)
            } else {
                Scroll() {
                    Column() {
                        if (RouteState.currentRoute == "expenses") {
                            ExpensesPage()
                        }
                        if (RouteState.currentRoute == "expenses/add_expenses") {
                            AddExpensePage()
                        }
                        if (RouteState.currentRoute == "reports") {
                            ReportsPage()
                        }
                        if (RouteState.currentRoute == "analytics") {
                            AnalyticsPage()
                        }
                        if (RouteState.currentRoute == "settings") {
                            SettingsPage()
                        }
                        if (RouteState.currentRoute == "settings/languages") {
                            LanguagesPage()
                        }
                        if (RouteState.currentRoute == "settings/about") {
                            AboutPage()
                        }
                        if (RouteState.currentRoute == "settings/about/web") {
                            WebLinkPage()
                        }
                        if (RouteState.currentRoute == "settings/categories") {
                            CategoryPage()
                        }
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
        .backgroundColor(0xFFF6F1FA)
    }
}