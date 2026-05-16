package ohos_app_cangjie_entry.pages

import std.collection.ArrayList
import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.navigation.BottomNavItem
import ohos_app_cangjie_entry.runtime.RouteState

@Component
public class MainPage {
    private func navItems(): ArrayList<BottomNavItem> {
        let items = ArrayList<BottomNavItem>()
        items.add(BottomNavItem("Expenses", "W", "expenses"))
        items.add(BottomNavItem("Reports", "R", "reports"))
        items.add(BottomNavItem("Analytics", "A", "analytics"))
        items.add(BottomNavItem("Settings", "S", "settings"))
        items
    }

    private func isTabSelected(route: String): Bool {
        if (route == "expenses") {
            return RouteState.currentRoute == "expenses" || RouteState.currentRoute == "expenses/add_expenses"
        }
        if (route == "settings") {
            return RouteState.currentRoute == "settings" || RouteState.currentRoute == "settings/languages" || RouteState.currentRoute == "settings/about" || RouteState.currentRoute == "settings/about/web" || RouteState.currentRoute == "settings/categories"
        }
        RouteState.currentRoute == route
    }

    private func showBottomBar(): Bool {
        RouteState.currentRoute != "settings/about/web"
    }

    private func showFloatingAdd(): Bool {
        RouteState.currentRoute == "expenses"
    }

    private func contentBottomPadding(): Int64 {
        if (this.showBottomBar()) {
            return 126
        }
        return 28
    }

    public func build(): Unit {
        Stack() {
            Column() {
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
            }
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(0xFFF6F1FA)

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
                .padding(right: 24, bottom: 98)
            }

            if (this.showBottomBar()) {
                Column() {
                    Row(space: 8) {
                        ForEach(this.navItems(), itemGeneratorFunc: { item: BottomNavItem, _: Int64 =>
                            Column(space: 6) {
                                Row() {
                                    Text(item.iconGlyph)
                                        .fontSize(15)
                                        .fontWeight(FontWeight.Medium)
                                        .fontColor(if (this.isTabSelected(item.route)) { 0xFFFFFFFF } else { 0xFF7B7388 })
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
                .margin(left: 16, right: 16, bottom: 16)
                .align(Alignment.Bottom)
            }
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xFFF6F1FA)
    }
}