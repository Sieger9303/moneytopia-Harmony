package ohos_app_cangjie_entry.state

import ohos_app_cangjie_entry.data.model.Recurrence

public class AnalyticsState {
    public var recurrence: Recurrence = Recurrence.Weekly

    public init() {}

    public init(recurrence!: Recurrence) {
        this.recurrence = recurrence
    }
}

public func getAnalyticsSnapshot(): AnalyticsState {
    AnalyticsState(recurrence: Recurrence.Weekly)
}