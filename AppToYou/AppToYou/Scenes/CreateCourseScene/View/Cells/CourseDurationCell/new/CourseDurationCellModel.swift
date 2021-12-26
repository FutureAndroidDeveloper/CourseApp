import Foundation


class CourseDurationCellModel: TaskDurationCellModel {
    
    let isInfiniteModel: TitledCheckBoxModel
    
    init(isInfiniteModel: TitledCheckBoxModel, durationModel: TaskDurationModel, timerCallback: @escaping () -> Void) {
        self.isInfiniteModel = isInfiniteModel
        super.init(durationModel: durationModel, timerCallback: timerCallback)
    }
    
}
