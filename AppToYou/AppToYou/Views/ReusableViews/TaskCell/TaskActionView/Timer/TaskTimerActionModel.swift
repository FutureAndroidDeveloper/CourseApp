import UIKit


/**
  Модель действий над задачей с таймером.
 */
class TaskTimerActionModel: TaskActionModel {
    private struct Constants {
        static let timeSeparator: Character = ":"
        static let failedNotStartedTimer = "00:00"
    }
    
    /**
     Получить конфигурацию таймера для представления.
     */
    override func getConfiguration() -> Any? {
        var timerValue = result?.result?.toTimerFormat()
        var isHidden = false
        var color: UIColor? = .gray
        
        switch state {
        case .notStarted:
            if timerValue == nil {
                isHidden = true
            }
            
        case .inProgress:
            color = .black
            
        case .done:
            break
            
        case .failed:
            if timerValue == nil {
                timerValue = Constants.failedNotStartedTimer
            }
        }
        return TimerActionConfiguration(isHidden: isHidden, timerValue: timerValue, color: color)
    }
}
