package ohos_app_cangjie_entry.components.categories

import std.collection.ArrayList

public class CategoryIconItem {
    public var name: String = ""
    public var symbol: String = ""

    public init() {}

    public init(name!: String, symbol!: String) {
        this.name = name
        this.symbol = symbol
    }
}

public func availableCategoryIcons(): ArrayList<CategoryIconItem> {
    let icons = ArrayList<CategoryIconItem>()
    icons.add(CategoryIconItem(name: "Payments", symbol: "¤"))
    icons.add(CategoryIconItem(name: "CreditCard", symbol: "▭"))
    icons.add(CategoryIconItem(name: "ShoppingBag", symbol: "◧"))
    icons.add(CategoryIconItem(name: "ShoppingCart", symbol: "▣"))
    icons.add(CategoryIconItem(name: "ReceiptLong", symbol: "▤"))
    icons.add(CategoryIconItem(name: "Savings", symbol: "◌"))
    icons.add(CategoryIconItem(name: "PointOfSale", symbol: "⌗"))
    icons.add(CategoryIconItem(name: "Paid", symbol: "◍"))
    icons.add(CategoryIconItem(name: "AccountBalance", symbol: "⌂"))
    icons.add(CategoryIconItem(name: "MonetizationOn", symbol: "◎"))
    icons.add(CategoryIconItem(name: "Fastfood", symbol: "◔"))
    icons.add(CategoryIconItem(name: "LocalCafe", symbol: "◒"))
    icons.add(CategoryIconItem(name: "Restaurant", symbol: "◐"))
    icons.add(CategoryIconItem(name: "LunchDining", symbol: "◑"))
    icons.add(CategoryIconItem(name: "Cake", symbol: "◈"))
    icons.add(CategoryIconItem(name: "EmojiFoodBeverage", symbol: "◕"))
    icons.add(CategoryIconItem(name: "Cottage", symbol: "⌂"))
    icons.add(CategoryIconItem(name: "House", symbol: "⌂"))
    icons.add(CategoryIconItem(name: "Lightbulb", symbol: "✦"))
    icons.add(CategoryIconItem(name: "WaterDrop", symbol: "◍"))
    icons.add(CategoryIconItem(name: "Wifi", symbol: "⌁"))
    icons.add(CategoryIconItem(name: "Phone", symbol: "◓"))
    icons.add(CategoryIconItem(name: "Build", symbol: "⚒"))
    icons.add(CategoryIconItem(name: "LocalTaxi", symbol: "▥"))
    icons.add(CategoryIconItem(name: "DirectionsCar", symbol: "▦"))
    icons.add(CategoryIconItem(name: "LocalGasStation", symbol: "▧"))
    icons.add(CategoryIconItem(name: "Train", symbol: "═"))
    icons.add(CategoryIconItem(name: "Flight", symbol: "✈"))
    icons.add(CategoryIconItem(name: "MonitorHeart", symbol: "♡"))
    icons.add(CategoryIconItem(name: "FitnessCenter", symbol: "✚"))
    icons.add(CategoryIconItem(name: "Spa", symbol: "✿"))
    icons.add(CategoryIconItem(name: "MedicalServices", symbol: "✚"))
    icons.add(CategoryIconItem(name: "Diversity1", symbol: "◫"))
    icons.add(CategoryIconItem(name: "Theaters", symbol: "◭"))
    icons.add(CategoryIconItem(name: "SportsEsports", symbol: "▨"))
    icons.add(CategoryIconItem(name: "MusicNote", symbol: "♪"))
    icons.add(CategoryIconItem(name: "Celebration", symbol: "✦"))
    icons.add(CategoryIconItem(name: "ConfirmationNumber", symbol: "▩"))
    icons.add(CategoryIconItem(name: "School", symbol: "◨"))
    icons.add(CategoryIconItem(name: "FamilyRestroom", symbol: "◪"))
    icons.add(CategoryIconItem(name: "ChildFriendly", symbol: "◬"))
    icons.add(CategoryIconItem(name: "Pets", symbol: "♢"))
    icons.add(CategoryIconItem(name: "AddCard", symbol: "⊞"))
    icons.add(CategoryIconItem(name: "Redeem", symbol: "⬢"))
    icons.add(CategoryIconItem(name: "DryCleaning", symbol: "◰"))
    icons.add(CategoryIconItem(name: "Category", symbol: "◫"))
    icons
}

public func resolveCategoryIcon(name: String): String {
    for (icon in availableCategoryIcons()) {
        if (icon.name == name) {
            return icon.symbol
        }
    }
    "◫"
}