package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.runtime.RouteState
import std.collection.ArrayList
import ohos_app_cangjie_entry.components.header.HeaderCard
import ohos_app_cangjie_entry.components.header.InfoDialog
import ohos_app_cangjie_entry.components.settings.CurrencyDialog
import ohos_app_cangjie_entry.components.settings.DeleteConfirmDialog
import ohos_app_cangjie_entry.components.settings.MenuSettingItem
import ohos_app_cangjie_entry.data.local.ExpenseStore
import ohos_app_cangjie_entry.data.local.PreferenceStore

@Component
public class SettingsPage {
    @State var showDeleteDialog: Bool = false
    @State var showLanguageDialog: Bool = false
    @State var showCurrencyDialog: Bool = false
    @State var currencyDraft: String = ""
    @State var statusMessage: String = ""
    @State var showInfoDialog: Bool = false
    @State var languageSummary: String = "English"

    private let expenseStore = ExpenseStore()
    private let preferenceStore = PreferenceStore()

    private func menuItems(): ArrayList<MenuSettingItem> {
        let items = ArrayList<MenuSettingItem>()
        items.add(MenuSettingItem(headlineContent: "Delete", supportingContent: "Delete All Transactions"))
        items.add(MenuSettingItem(headlineContent: "Language", supportingContent: "Change Language"))
        items.add(MenuSettingItem(headlineContent: "Categories", supportingContent: "Manage Categories"))
        items.add(MenuSettingItem(headlineContent: "Currency", supportingContent: "Change Currency"))
        items.add(MenuSettingItem(headlineContent: "About", supportingContent: "Moneytopia"))
        items
    }

    private func languageLabel(languageCode: String): String {
        if (languageCode == "de") {
            return "German"
        }
        if (languageCode == "fr") {
            return "French"
        }
        if (languageCode == "in") {
            return "Indonesian"
        }
        if (languageCode == "it") {
            return "Italian"
        }
        if (languageCode == "ja") {
            return "Japanese"
        }
        if (languageCode == "ko") {
            return "Korean"
        }
        if (languageCode == "zh") {
            return "Chinese"
        }
        "English"
    }

    private func refreshSummaries(): Unit {
        this.languageSummary = this.languageLabel(this.preferenceStore.getLanguageCode())
        this.currencyDraft = this.preferenceStore.getCurrencySymbol()
    }

    private func eraseAllTransactions(): Unit {
        this.expenseStore.getExpenses().clear()
        this.showDeleteDialog = false
        this.statusMessage = "The entire transaction history was successfully deleted"
    }

    private func confirmLanguageReset(): Unit {
        this.expenseStore.getExpenses().clear()
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
        Scroll() {
            Column(space: 12) {
                HeaderCard(title: "Settings")
                Button("About This Page")
                    .onClick({ _ =>
                        this.showInfoDialog = !this.showInfoDialog
                    })
                Text("Currency: ${this.preferenceStore.getCurrencySymbol()}")
                Text("Language: ${this.languageSummary}")

                ForEach(this.menuItems(), itemGeneratorFunc: { item: MenuSettingItem, _: Int64 =>
                    Button("${item.headlineContent}: ${item.supportingContent}")
                        .onClick({ _ =>
                            if (item.headlineContent == "Delete") {
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

                if (this.showInfoDialog) {
                    InfoDialog(title: "Settings", message: "On this page you can delete the entire transaction history, change the app language, manage categories, edit the currency symbol, and view information about the app.")
                }

                if (this.showDeleteDialog) {
                    DeleteConfirmDialog(title: "Delete transactions?", message: "All transaction history that you have created will be deleted and cannot be canceled.")
                    Row(space: 8) {
                        Button("Cancel")
                            .onClick({ _ =>
                                this.showDeleteDialog = false
                            })
                        Button("Delete")
                            .onClick({ _ =>
                                this.eraseAllTransactions()
                            })
                    }
                }

                if (this.showLanguageDialog) {
                    DeleteConfirmDialog(title: "Caution!", message: "To change the app language, all existing transaction history will be deleted first. Do you want to continue?")
                    Row(space: 8) {
                        Button("Cancel")
                            .onClick({ _ =>
                                this.showLanguageDialog = false
                            })
                        Button("Yes, continue")
                            .onClick({ _ =>
                                this.confirmLanguageReset()
                            })
                    }
                }

                if (this.showCurrencyDialog) {
                    CurrencyDialog(currentSymbol: this.preferenceStore.getCurrencySymbol())
                    TextInput(placeholder: "$", text: this.currencyDraft)
                        .onChange({ text =>
                            this.currencyDraft = text
                        })
                    Row(space: 8) {
                        Button("Cancel")
                            .onClick({ _ =>
                                this.showCurrencyDialog = false
                            })
                        Button("Save")
                            .onClick({ _ =>
                                this.saveCurrency()
                            })
                    }
                }

                if (this.statusMessage != "") {
                    Text(this.statusMessage)
                }
            }
            .padding(16)
        }
    }
}