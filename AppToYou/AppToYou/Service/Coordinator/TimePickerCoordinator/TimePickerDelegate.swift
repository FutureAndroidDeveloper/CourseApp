import Foundation


protocol TimePickerDelegate: DurationTimeDelegate, NotificationTimeDelegate {
    
}


extension TimePickerDelegate {
    func userTaskdurationPicked(_ duration: DurationTime) {
        return
    }
    
    func courseDurationPicked(_ duration: Duration){
        return
    }
    
    func courseTaskDurationPicked(_ duration: Duration) {
        return
    }
    
    func notificationPicked(_ notification: NotificationTime) {
        return
    }
    
}
