package ohos_app_cangjie_entry.components.settings

public class MenuSettingItem {
    public var headlineContent: String = ""
    public var supportingContent: String = ""

    public init() {}

    public init(headlineContent!: String, supportingContent!: String) {
        this.headlineContent = headlineContent
        this.supportingContent = supportingContent
    }
}