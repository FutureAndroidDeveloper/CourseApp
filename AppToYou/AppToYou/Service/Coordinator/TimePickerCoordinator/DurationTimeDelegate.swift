import Foundation


protocol DurationTimeDelegate: AnyObject {
    func userTaskdurationPicked(_ duration: DurationTime)
    func courseDurationPicked(_ duration: Duration)
    func courseTaskDurationPicked(_ duration: Duration)
}


