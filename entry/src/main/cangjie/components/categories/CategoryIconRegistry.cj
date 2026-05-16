package ohos_app_cangjie_entry.components.categories

import std.collection.ArrayList

public class CategoryIconItem {
    public var name: String = ""
    public var iconName: String = ""

    public init() {}

    public init(name!: String, iconName!: String) {
        this.name = name
        this.iconName = iconName
    }
}

public func availableCategoryIcons(): ArrayList<CategoryIconItem> {
    let icons = ArrayList<CategoryIconItem>()
    icons.add(CategoryIconItem(name: "Payments", iconName: "currency"))
    icons.add(CategoryIconItem(name: "CreditCard", iconName: "wallet"))
    icons.add(CategoryIconItem(name: "ShoppingBag", iconName: "categories"))
    icons.add(CategoryIconItem(name: "ShoppingCart", iconName: "categories"))
    icons.add(CategoryIconItem(name: "ReceiptLong", iconName: "report"))
    icons.add(CategoryIconItem(name: "Savings", iconName: "wallet_simple"))
    icons.add(CategoryIconItem(name: "PointOfSale", iconName: "currency"))
    icons.add(CategoryIconItem(name: "Paid", iconName: "currency"))
    icons.add(CategoryIconItem(name: "AccountBalance", iconName: "wallet"))
    icons.add(CategoryIconItem(name: "MonetizationOn", iconName: "currency"))
    icons.add(CategoryIconItem(name: "Fastfood", iconName: "receipt"))
    icons.add(CategoryIconItem(name: "LocalCafe", iconName: "receipt"))
    icons.add(CategoryIconItem(name: "Restaurant", iconName: "receipt"))
    icons.add(CategoryIconItem(name: "LunchDining", iconName: "receipt"))
    icons.add(CategoryIconItem(name: "Cake", iconName: "receipt"))
    icons.add(CategoryIconItem(name: "EmojiFoodBeverage", iconName: "receipt"))
    icons.add(CategoryIconItem(name: "Cottage", iconName: "categories"))
    icons.add(CategoryIconItem(name: "House", iconName: "categories"))
    icons.add(CategoryIconItem(name: "Lightbulb", iconName: "info"))
    icons.add(CategoryIconItem(name: "WaterDrop", iconName: "info"))
    icons.add(CategoryIconItem(name: "Wifi", iconName: "info"))
    icons.add(CategoryIconItem(name: "Phone", iconName: "info"))
    icons.add(CategoryIconItem(name: "Build", iconName: "settings"))
    icons.add(CategoryIconItem(name: "LocalTaxi", iconName: "analytics"))
    icons.add(CategoryIconItem(name: "DirectionsCar", iconName: "analytics"))
    icons.add(CategoryIconItem(name: "LocalGasStation", iconName: "analytics"))
    icons.add(CategoryIconItem(name: "Train", iconName: "analytics"))
    icons.add(CategoryIconItem(name: "Flight", iconName: "analytics"))
    icons.add(CategoryIconItem(name: "MonitorHeart", iconName: "info"))
    icons.add(CategoryIconItem(name: "FitnessCenter", iconName: "info"))
    icons.add(CategoryIconItem(name: "Spa", iconName: "info"))
    icons.add(CategoryIconItem(name: "MedicalServices", iconName: "info"))
    icons.add(CategoryIconItem(name: "Diversity1", iconName: "categories"))
    icons.add(CategoryIconItem(name: "Theaters", iconName: "report"))
    icons.add(CategoryIconItem(name: "SportsEsports", iconName: "analytics"))
    icons.add(CategoryIconItem(name: "MusicNote", iconName: "analytics"))
    icons.add(CategoryIconItem(name: "Celebration", iconName: "info"))
    icons.add(CategoryIconItem(name: "ConfirmationNumber", iconName: "receipt"))
    icons.add(CategoryIconItem(name: "School", iconName: "report"))
    icons.add(CategoryIconItem(name: "FamilyRestroom", iconName: "categories"))
    icons.add(CategoryIconItem(name: "ChildFriendly", iconName: "categories"))
    icons.add(CategoryIconItem(name: "Pets", iconName: "categories"))
    icons.add(CategoryIconItem(name: "AddCard", iconName: "add"))
    icons.add(CategoryIconItem(name: "Redeem", iconName: "wallet_simple"))
    icons.add(CategoryIconItem(name: "DryCleaning", iconName: "receipt"))
    icons.add(CategoryIconItem(name: "Category", iconName: "categories"))
    icons
}

public func resolveCategoryIconName(name: String): String {
    for (icon in availableCategoryIcons()) {
        if (icon.name == name) {
            return icon.iconName
        }
    }
    "categories"
}