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
        items.add(BottomNavItem("Expenses", "expenses", "expenses", "expenses"))
        items.add(BottomNavItem("Reports", "reports", "reports", "reports"))
        items.add(BottomNavItem("Analytics", "analytics", "analytics", "analytics"))
        items.add(BottomNavItem("Settings", "settings", "settings", "settings"))
        items
    }

    public func build(): Unit {
        Column(space: 12) {
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

            ForEach(this.navItems(), itemGeneratorFunc: { item: BottomNavItem, _: Int64 =>
                Button(item.title)
                    .onClick({ _ =>
                        RouteState.navigate(item.route)
                    })
            }, keyGeneratorFunc: { item: BottomNavItem, _: Int64 =>
                item.route
            })

            Button("Add")
                .onClick({ _ =>
                    RouteState.navigate("expenses/add_expenses")
                })
            Button("Languages")
                .onClick({ _ =>
                    RouteState.navigate("settings/languages")
                })
            Button("About")
                .onClick({ _ =>
                    RouteState.navigate("settings/about")
                })
            Button("Categories")
                .onClick({ _ =>
                    RouteState.navigate("settings/categories")
                })
        }
        .padding(16)
        .width(100.percent)
        .height(100.percent)
    }
}