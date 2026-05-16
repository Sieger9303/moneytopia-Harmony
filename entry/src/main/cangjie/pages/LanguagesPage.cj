package ohos_app_cangjie_entry.pages

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import ohos_app_cangjie_entry.components.header.HeaderCard
import ohos_app_cangjie_entry.data.local.PreferenceStore
import ohos_app_cangjie_entry.runtime.RouteState

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
        Scroll() {
            Column(space: 12) {
                HeaderCard(title: "Language")
                Text("Supported locales: English, German, French, Indonesian, Italian, Japanese, Korean, Chinese.")
                Text("Selected: ${this.selectedLanguageLabel()}")
                Text("The Android source page is unfinished, so this Harmony translation stores the intended locale choice in app preferences and keeps the screen functional instead of leaving it empty.")

                ForEach(this.options(), itemGeneratorFunc: { option: LanguageOption, _: Int64 =>
                    Button(option.label)
                        .onClick({ _ =>
                            this.selectLanguage(option.code)
                        })
                }, keyGeneratorFunc: { option: LanguageOption, _: Int64 =>
                    option.code
                })
                Text(this.statusMessage)
                Button("Back to Settings")
                    .onClick({ _ =>
                        RouteState.navigate("settings")
                    })
            }
            .padding(16)
        }
    }
}