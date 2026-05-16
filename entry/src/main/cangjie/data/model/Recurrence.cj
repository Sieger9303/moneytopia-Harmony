package ohos_app_cangjie_entry.data.model

public enum Recurrence {
    | None
    | Daily
    | Weekly
    | Monthly
    | Yearly
}

public func recurrenceName(recurrence: Recurrence): String {
    match (recurrence) {
        case Recurrence.None => "None"
        case Recurrence.Daily => "Daily"
        case Recurrence.Weekly => "Weekly"
        case Recurrence.Monthly => "Monthly"
        case Recurrence.Yearly => "Yearly"
    }
}

public func toRecurrence(name: String): Recurrence {
    match (name) {
        case "Daily" => Recurrence.Daily
        case "Weekly" => Recurrence.Weekly
        case "Monthly" => Recurrence.Monthly
        case "Yearly" => Recurrence.Yearly
        case _ => Recurrence.None
    }
}