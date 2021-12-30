import Foundation


class CourseTaskDurationModel: TaskDurationCellModel {
    let isInfiniteModel: TitledCheckBoxModel
    
    init(durationModel: TaskDurationModel, isInfiniteModel: TitledCheckBoxModel, timerCallback: @escaping () -> Void) {
        self.isInfiniteModel = isInfiniteModel
        super.init(durationModel: durationModel, lockModel: nil, timerCallback: timerCallback)
    }
    
}
