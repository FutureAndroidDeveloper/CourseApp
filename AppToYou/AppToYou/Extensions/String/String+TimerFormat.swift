import Foundation


extension String {
    static let timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        return formatter
    }()

    func toTimerFormat() -> String? {
        guard
            let ellapsed = Double(self),
            let timerValue = Self.timeFormatter.string(from: ellapsed)
        else {
            return nil
        }
        return timerValue
    }
}
