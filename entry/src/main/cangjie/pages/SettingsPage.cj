package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import std.collection.ArrayList
import ohos_app_cangjie_entry.components.header.AppIcon
import ohos_app_cangjie_entry.components.header.HeaderCard
import ohos_app_cangjie_entry.components.settings.CurrencyDialog
import ohos_app_cangjie_entry.components.settings.DeleteConfirmDialog
import ohos_app_cangjie_entry.components.settings.MenuSettingItem
import ohos_app_cangjie_entry.data.local.ExpenseStore
import ohos_app_cangjie_entry.data.local.PreferenceStore
import ohos_app_cangjie_entry.runtime.RouteState

@Component
public class SettingsPage {
    @State var showDeleteDialog: Bool = false
    @State var showLanguageDialog: Bool = false
    @State var showCurrencyDialog: Bool = false
    @State var currencyDraft: String = ""
    @State var statusMessage: String = ""
    @State var languageSummary: String = "English"

    private let expenseStore = ExpenseStore()
    private let preferenceStore = PreferenceStore()

    private func menuItems(): ArrayList<MenuSettingItem> {
        let items = ArrayList<MenuSettingItem>()
        items.add(MenuSettingItem(headlineContent: "Delete Transactions", supportingContent: "Remove all saved expenses"))
        items.add(MenuSettingItem(headlineContent: "Language", supportingContent: "Choose your app locale"))
        items.add(MenuSettingItem(headlineContent: "Categories", supportingContent: "Add, edit, or remove categories"))
        items.add(MenuSettingItem(headlineContent: "Currency", supportingContent: "Update the currency symbol"))
        items.add(MenuSettingItem(headlineContent: "About", supportingContent: "App details and social links"))
        items
    }

    private func iconNameFor(headline: String): String {
        if (headline == "Delete Transactions") { return "delete" }
        if (headline == "Language") { return "language" }
        if (headline == "Categories") { return "categories" }
        if (headline == "Currency") { return "currency" }
        return "info"
    }

    private func languageLabel(languageCode: String): String {
        if (languageCode == "de") { return "German" }
        if (languageCode == "fr") { return "French" }
        if (languageCode == "in") { return "Indonesian" }
        if (languageCode == "it") { return "Italian" }
        if (languageCode == "ja") { return "Japanese" }
        if (languageCode == "ko") { return "Korean" }
        if (languageCode == "zh") { return "Chinese" }
        "English"
    }

    private func refreshSummaries(): Unit {
        this.languageSummary = this.languageLabel(this.preferenceStore.getLanguageCode())
        this.currencyDraft = this.preferenceStore.getCurrencySymbol()
    }

    private func eraseAllTransactions(): Unit {
        this.expenseStore.deleteAllExpenses()
        this.showDeleteDialog = false
        this.statusMessage = "All transactions were deleted."
    }

    private func confirmLanguageReset(): Unit {
        this.expenseStore.deleteAllExpenses()
        this.showLanguageDialog = false
        RouteState.navigate("settings/languages")
    }

    private func saveCurrency(): Unit {
        if (this.currencyDraft == "") {
            this.statusMessage = "Enter a currency symbol first"
            return
        }
        this.preferenceStore.saveCurrencySymbol(this.currencyDraft)
        this.showCurrencyDialog = false
        this.statusMessage = "Currency updated to ${this.preferenceStore.getCurrencySymbol()}"
    }

    public func aboutToAppear(): Unit {
        this.refreshSummaries()
    }

    public func build(): Unit {
        Column(space: 16) {
            HeaderCard(title: "Settings", iconName: "settings", actionIconName: "info", subtitle: "Manage preferences and app data")

            Row(space: 12) {
                Column(space: 5) {
                    Text("Currency")
                        .fontSize(12)
                        .fontColor(0xFF7B7388)
                    Text(this.preferenceStore.getCurrencySymbol())
                        .fontSize(20)
                        .fontColor(0xFF1C1B1F)
                }
                .width(48.percent)
                .padding(left: 18, right: 18, top: 18, bottom: 18)
                .borderRadius(24)
                .backgroundColor(0xFFFDF8FF)

                Column(space: 5) {
                    Text("Language")
                        .fontSize(12)
                        .fontColor(0xFF7B7388)
                    Text(this.languageSummary)
                        .fontSize(20)
                        .fontColor(0xFF1C1B1F)
                }
                .width(48.percent)
                .padding(left: 18, right: 18, top: 18, bottom: 18)
                .borderRadius(24)
                .backgroundColor(0xFFFDF8FF)
            }
            .width(100.percent)
            .justifyContent(FlexAlign.SpaceBetween)

            ForEach(this.menuItems(), itemGeneratorFunc: { item: MenuSettingItem, _: Int64 =>
                Row(space: 12) {
                    Row() {
                        AppIcon(name: this.iconNameFor(item.headlineContent), size: 15, color: 0xFF6750A4)
                    }
                    .width(38)
                    .height(38)
                    .justifyContent(FlexAlign.Center)
                    .alignItems(VerticalAlign.Center)
                    .borderRadius(19)
                    .backgroundColor(0xFFEFE6FD)

                    Column(space: 3) {
                        Text(item.headlineContent)
                            .fontSize(16)
                            .fontColor(0xFF1C1B1F)
                        Text(item.supportingContent)
                            .fontSize(12)
                            .fontColor(0xFF7B7388)
                    }
                    .width(68.percent)
                    .alignItems(HorizontalAlign.Start)
                }
                .padding(left: 14, right: 14, top: 14, bottom: 14)
                .width(100.percent)
                .alignItems(VerticalAlign.Center)
                .borderRadius(24)
                .backgroundColor(0xFFFDF8FF)
                .onClick({ _ =>
                    if (item.headlineContent == "Delete Transactions") {
                        this.showDeleteDialog = true
                        this.statusMessage = ""
                    }
                    if (item.headlineContent == "Language") {
                        this.showLanguageDialog = true
                        this.statusMessage = ""
                    }
                    if (item.headlineContent == "Categories") {
                        RouteState.navigate("settings/categories")
                    }
                    if (item.headlineContent == "Currency") {
                        this.currencyDraft = this.preferenceStore.getCurrencySymbol()
                        this.showCurrencyDialog = true
                        this.statusMessage = ""
                    }
                    if (item.headlineContent == "About") {
                        RouteState.navigate("settings/about")
                    }
                })
            }, keyGeneratorFunc: { item: MenuSettingItem, _: Int64 =>
                item.headlineContent
            })

            if (this.showDeleteDialog) {
                DeleteConfirmDialog(title: "Delete transactions?", message: "All transaction history that you have created will be deleted and cannot be canceled.")
                Row(space: 8) {
                    Button("Cancel").backgroundColor(0xFFF3EDF8).borderRadius(18).onClick({ _ => this.showDeleteDialog = false })
                    Button("Delete").fontColor(0xFFFFFFFF).backgroundColor(0xFFC84C58).borderRadius(18).onClick({ _ => this.eraseAllTransactions() })
                }
            }

            if (this.showLanguageDialog) {
                DeleteConfirmDialog(title: "Caution", message: "Changing language clears transaction history first. Continue?")
                Row(space: 8) {
                    Button("Cancel").backgroundColor(0xFFF3EDF8).borderRadius(18).onClick({ _ => this.showLanguageDialog = false })
                    Button("Continue").fontColor(0xFFFFFFFF).backgroundColor(0xFF6750A4).borderRadius(18).onClick({ _ => this.confirmLanguageReset() })
                }
            }

            if (this.showCurrencyDialog) {
                CurrencyDialog(currentSymbol: this.preferenceStore.getCurrencySymbol())
                TextInput(placeholder: "$", text: this.currencyDraft)
                    .backgroundColor(0xFFFDF8FF)
                    .borderRadius(20)
                    .padding(left: 14, right: 14, top: 12, bottom: 12)
                    .onChange({ text =>
                        this.currencyDraft = text
                    })
                Row(space: 8) {
                    Button("Cancel").backgroundColor(0xFFF3EDF8).borderRadius(18).onClick({ _ => this.showCurrencyDialog = false })
                    Button("Save").fontColor(0xFFFFFFFF).backgroundColor(0xFF6750A4).borderRadius(18).onClick({ _ => this.saveCurrency() })
                }
            }

            if (this.statusMessage != "") {
                Text(this.statusMessage)
                    .fontSize(12)
                    .fontColor(0xFF7B7388)
            }
        }
        .width(100.percent)
    }
}