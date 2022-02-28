import Foundation

struct TaskDuration: CustomStringConvertible {
    let hour: Int
    let min: Int
    let sec: Int
    
    var description: String {
        let hourText = hour != .zero ? "\(hour) час" : nil
        let minText = min != .zero ? "\(min) мин" : nil
        let secText = sec != .zero ? "\(sec) сек" : nil
        
        return [hourText, minText, secText]
            .compactMap { $0 }
            .joined(separator: " ")
    }
}

class TaskTimerModel {
    private let duration: TimeInterval
    private var ellapsed: TimeInterval
    
    var timeChanged: ((String) -> Void)?
    
    private lazy var timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
//        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        return formatter
    }()
    
    init(duration: TaskDuration) {
        self.duration = TimeInterval(duration.hour * 60 * 60 + duration.min * 60 + duration.sec)
        ellapsed = .zero
    }
    
    func update() {
        ellapsed += 1
        let timeRemaining = duration - ellapsed
        guard let formattedTime = timeFormatter.string(from: timeRemaining) else {
            return
        }
        timeChanged?(formattedTime)
    }
    
}



class TaskTimer {
    private struct Constants {
        static let interval: TimeInterval = 1
        static let tolerance: TimeInterval = 0.1
    }
        
    private var subscribers: [TaskTimerModel]
    
    private lazy var timer: Timer = {
        let timer = Timer.scheduledTimer(
            timeInterval: Constants.interval,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
        timer.tolerance = Constants.tolerance
        return timer
    }()
    
    
    init() {
        subscribers = []
        RunLoop.current.add(timer, forMode: .common)
    }
    
    func subscribe(_ subscriber: TaskTimerModel) {
        subscribers.append(subscriber)
    }
    
    func remove(_ subscriber: TaskTimerModel) {
        guard let index = subscribers.firstIndex(where: { $0 === subscriber }) else {
            return
        }
        subscribers.remove(at: index)
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    @objc
    private func updateTimer() {
        subscribers.forEach {
            $0.update()
        }
    }
    
}

class TaskTimerActionModel: TaskAction {
    weak var delegate: TaskActionDelegate?
    var updateTimer: ((String) -> Void)?
    
    private(set) var timerModel: TaskTimerModel
    
    init(timerModel: TaskTimerModel) {
        self.timerModel = timerModel
        configure()
    }
    
    private func configure() {
        timerModel.timeChanged = { [weak self] value in
            self?.updateTimer?(value)
        }
    }
    
    func update() {
        // TODO: - 
    }
    
    
}
