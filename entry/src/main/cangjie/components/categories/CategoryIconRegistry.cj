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
    icons.add(CategoryIconItem(name: "Payments", symbol: "$"))
    icons.add(CategoryIconItem(name: "CreditCard", symbol: "CARD"))
    icons.add(CategoryIconItem(name: "ShoppingBag", symbol: "BAG"))
    icons.add(CategoryIconItem(name: "ShoppingCart", symbol: "CART"))
    icons.add(CategoryIconItem(name: "ReceiptLong", symbol: "NOTE"))
    icons.add(CategoryIconItem(name: "Savings", symbol: "SAVE"))
    icons.add(CategoryIconItem(name: "PointOfSale", symbol: "POS"))
    icons.add(CategoryIconItem(name: "Paid", symbol: "PAID"))
    icons.add(CategoryIconItem(name: "AccountBalance", symbol: "BANK"))
    icons.add(CategoryIconItem(name: "MonetizationOn", symbol: "COIN"))
    icons.add(CategoryIconItem(name: "Fastfood", symbol: "FOOD"))
    icons.add(CategoryIconItem(name: "LocalCafe", symbol: "CAFE"))
    icons.add(CategoryIconItem(name: "Restaurant", symbol: "MEAL"))
    icons.add(CategoryIconItem(name: "LunchDining", symbol: "LUNCH"))
    icons.add(CategoryIconItem(name: "Cake", symbol: "CAKE"))
    icons.add(CategoryIconItem(name: "EmojiFoodBeverage", symbol: "DRINK"))
    icons.add(CategoryIconItem(name: "Cottage", symbol: "HOME"))
    icons.add(CategoryIconItem(name: "House", symbol: "HOUSE"))
    icons.add(CategoryIconItem(name: "Lightbulb", symbol: "IDEA"))
    icons.add(CategoryIconItem(name: "WaterDrop", symbol: "DROP"))
    icons.add(CategoryIconItem(name: "Wifi", symbol: "WIFI"))
    icons.add(CategoryIconItem(name: "Phone", symbol: "CALL"))
    icons.add(CategoryIconItem(name: "Build", symbol: "FIX"))
    icons.add(CategoryIconItem(name: "LocalTaxi", symbol: "TAXI"))
    icons.add(CategoryIconItem(name: "DirectionsCar", symbol: "CAR"))
    icons.add(CategoryIconItem(name: "LocalGasStation", symbol: "GAS"))
    icons.add(CategoryIconItem(name: "Train", symbol: "TRAIN"))
    icons.add(CategoryIconItem(name: "Flight", symbol: "FLY"))
    icons.add(CategoryIconItem(name: "MonitorHeart", symbol: "HEALTH"))
    icons.add(CategoryIconItem(name: "FitnessCenter", symbol: "FIT"))
    icons.add(CategoryIconItem(name: "Spa", symbol: "SPA"))
    icons.add(CategoryIconItem(name: "MedicalServices", symbol: "MED"))
    icons.add(CategoryIconItem(name: "Diversity1", symbol: "GROUP"))
    icons.add(CategoryIconItem(name: "Theaters", symbol: "SHOW"))
    icons.add(CategoryIconItem(name: "SportsEsports", symbol: "GAME"))
    icons.add(CategoryIconItem(name: "MusicNote", symbol: "MUSIC"))
    icons.add(CategoryIconItem(name: "Celebration", symbol: "PARTY"))
    icons.add(CategoryIconItem(name: "ConfirmationNumber", symbol: "TICKET"))
    icons.add(CategoryIconItem(name: "School", symbol: "SCHOOL"))
    icons.add(CategoryIconItem(name: "FamilyRestroom", symbol: "FAMILY"))
    icons.add(CategoryIconItem(name: "ChildFriendly", symbol: "KID"))
    icons.add(CategoryIconItem(name: "Pets", symbol: "PET"))
    icons.add(CategoryIconItem(name: "AddCard", symbol: "TOPUP"))
    icons.add(CategoryIconItem(name: "Redeem", symbol: "GIFT"))
    icons.add(CategoryIconItem(name: "DryCleaning", symbol: "CLEAN"))
    icons.add(CategoryIconItem(name: "Category", symbol: "ITEM"))
    icons
}

public func resolveCategoryIcon(name: String): String {
    for (icon in availableCategoryIcons()) {
        if (icon.name == name) {
            return icon.symbol
        }
    }
    "ITEM"
}