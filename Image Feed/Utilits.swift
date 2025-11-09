import Foundation

enum DateFormatters {
    static let dayMonthYear: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        return df
    }()
}
