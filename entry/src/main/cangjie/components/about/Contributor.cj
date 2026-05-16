package ohos_app_cangjie_entry.components.about

public class Contributor {
    public var name: String = ""
    public var role: String = ""

    public init() {}

    public init(name!: String, role!: String) {
        this.name = name
        this.role = role
    }
}