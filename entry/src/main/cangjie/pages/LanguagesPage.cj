package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.header.AppIcon
import ohos_app_cangjie_entry.components.header.HeaderCard
import ohos_app_cangjie_entry.data.local.PreferenceStore

public class LanguageOption {
    public var code: String = ""
    public var label: String = ""

    public init() {}

    public init(code!: String, label!: String) {
        this.code = code
        this.label = label
    }
}

@Component
public class LanguagesPage {
    @State var selectedLanguageCode: String = "en"
    @State var statusMessage: String = "Choose the language you want to use for the app shell."

    private let preferenceStore = PreferenceStore()

    private func options() {
        let items = [
            LanguageOption(code: "en", label: "English"),
            LanguageOption(code: "de", label: "German"),
            LanguageOption(code: "fr", label: "French"),
            LanguageOption(code: "in", label: "Indonesian"),
            LanguageOption(code: "it", label: "Italian"),
            LanguageOption(code: "ja", label: "Japanese"),
            LanguageOption(code: "ko", label: "Korean"),
            LanguageOption(code: "zh", label: "Chinese")
        ]
        items
    }

    private func selectedLanguageLabel(): String {
        for (option in this.options()) {
            if (option.code == this.selectedLanguageCode) {
                return option.label
            }
        }
        "English"
    }

    private func selectLanguage(languageCode: String): Unit {
        this.selectedLanguageCode = languageCode
        this.preferenceStore.saveLanguageCode(languageCode)
        this.statusMessage = "Language preference saved as ${this.selectedLanguageLabel()}."
    }

    public func aboutToAppear(): Unit {
        this.selectedLanguageCode = this.preferenceStore.getLanguageCode()
        this.statusMessage = "Current language preference: ${this.selectedLanguageLabel()}."
    }

    public func build(): Unit {
        Column(space: 16) {
            HeaderCard(title: "Language", iconName: "language", actionIconName: "info", subtitle: "Select the app locale preference", dialogText: "Language preference is stored locally in this Harmony pass. The source caution flow remains on the settings screen before entering this page.", actionRoute: "")

            Column(space: 6) {
                Text("Supported locales")
                    .fontSize(16)
                    .fontColor(0xFF1C1B1F)
                Text("English, German, French, Indonesian, Italian, Japanese, Korean, Chinese.")
                    .fontSize(12)
                    .fontColor(0xFF7B7388)
                Text("Selected: ${this.selectedLanguageLabel()}")
                    .fontSize(13)
                    .fontColor(0xFF1C1B1F)
            }
            .padding(left: 18, right: 18, top: 18, bottom: 18)
            .width(100.percent)
            .borderRadius(24)
            .backgroundColor(0xFFFDF8FF)

            ForEach(this.options(), itemGeneratorFunc: { option: LanguageOption, _: Int64 =>
                Row(space: 12) {
                    Row() {
                        if (option.code == this.selectedLanguageCode) {
                            AppIcon(name: "info", size: 16, color: 0xFFFFFFFF)
                        } else {
                            AppIcon(name: "language", size: 16, color: 0xFF6750A4)
                        }
                    }
                    .width(36)
                    .height(36)
                    .justifyContent(FlexAlign.Center)
                    .alignItems(VerticalAlign.Center)
                    .borderRadius(18)
                    .backgroundColor(if (option.code == this.selectedLanguageCode) { 0xFF6750A4 } else { 0xFFEFE6FD })

                    Text(option.label)
                        .fontSize(16)
                        .fontColor(0xFF1C1B1F)
                }
                .padding(left: 14, right: 14, top: 14, bottom: 14)
                .width(100.percent)
                .alignItems(VerticalAlign.Center)
                .borderRadius(24)
                .backgroundColor(0xFFFDF8FF)
                .onClick({ _ =>
                    this.selectLanguage(option.code)
                })
            }, keyGeneratorFunc: { option: LanguageOption, _: Int64 =>
                option.code
            })

            Text(this.statusMessage)
                .fontSize(12)
                .fontColor(0xFF7B7388)
        }
        .width(100.percent)
    }
}