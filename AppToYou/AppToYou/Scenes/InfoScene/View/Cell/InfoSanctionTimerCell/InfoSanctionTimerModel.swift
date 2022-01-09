import Foundation


class InfoSanctionTimerModel {
    
    private struct Constants {
        static let duration: TimeInterval = 2 * 24 * 60 * 60
        static let keyPrefix = "sanctionStart"
        
        struct Timer {
            static let interval: TimeInterval = 1
            static let tolerance: TimeInterval = 0.1
        }
    }
    
    private let taskId: Int
    var timerChanged: ((String) -> Void)?
    
    private lazy var timer: Timer = {
        let timer = Timer.scheduledTimer(
            timeInterval: Constants.Timer.interval,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
        timer.tolerance = Constants.Timer.tolerance
        return timer
    }()
    
    private lazy var timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        return formatter
    }()
    
    private var startTimeKey: String {
        return "\(Constants.keyPrefix)\(taskId)"
    }
    
    private var startTime: TimeInterval = .zero
    private let timeToPay: TimeInterval = Constants.duration
    
    init(taskId: Int) {
        self.taskId = taskId
        
        restoreTimer()
        RunLoop.current.add(timer, forMode: .common)
    }
    
    private func restoreTimer() {
        var start = UserDefaults.standard.double(forKey: startTimeKey)
        if start == .zero {
            start = Date().timeIntervalSinceReferenceDate
            UserDefaults.standard.set(start, forKey: startTimeKey)
        }
        startTime = start
    }
    
    func stopTimer() {
        timer.invalidate()
        UserDefaults.standard.set(startTime, forKey: startTimeKey)
    }
    
    @objc
    private func updateTimer() {
        let elapsedTime = Date().timeIntervalSinceReferenceDate - startTime
        let timeRemaining = timeToPay - elapsedTime
        formatTimer(value: timeRemaining)
    }
    
    private func formatTimer(value: TimeInterval) {
        guard let formattedTimer = timeFormatter.string(from: value) else {
            return
        }
        timerChanged?(formattedTimer)
    }
    
}

