import Foundation


/**
 Класс, отвечающий за работу таймера.
 */
class TaskTimer {
    private struct Constants {
        static let interval: TimeInterval = 1
        static let tolerance: TimeInterval = 0.1
    }
    
    var tick: (() -> Void)?
    
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
        RunLoop.current.add(timer, forMode: .common)
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    @objc
    private func updateTimer() {
        tick?()
    }
    
}
