import UIKit


/**
  Модель прогресса для задачи с иконкой.
 */
class IconProgressModel: TaskProgressModel {
    
    /**
     Получить иконку прогресса задачи.
     */
    override func getProgressValue() -> Any? {
        var image: UIImage?
        
        switch type {
        case .CHECKBOX:
            image = R.image.checkBoxWithoutBackground()
        case .TEXT:
            image = R.image.text()
        case .TIMER:
            image = R.image.timer()
            
            if result == nil {
                break
            }
            if state == .inProgress {
                image = R.image.timerPause()
            } else if state == .notStarted {
                image = R.image.timerStart()
            }
        default:
            break
        }
        
        return image
    }
}
