import Foundation


protocol TimePickerDelegate: DurationTimeDelegate, NotificationTimeDelegate {
    
}


extension TimePickerDelegate {
    func durationPicked(_ duration: DurationTime) {
        return
    }
    
    func notificationPicked(_ notification: NotificationTime) {
        return
    }
}
