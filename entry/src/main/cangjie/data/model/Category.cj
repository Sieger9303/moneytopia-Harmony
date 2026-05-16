package ohos_app_cangjie_entry.data.model

public class Category {
    public var id: String = ""
    public var name: String = ""
    public var icon: String = ""

    public init() {}

    public init(id!: String, name!: String, icon!: String) {
        this.id = id
        this.name = name
        this.icon = icon
    }
}