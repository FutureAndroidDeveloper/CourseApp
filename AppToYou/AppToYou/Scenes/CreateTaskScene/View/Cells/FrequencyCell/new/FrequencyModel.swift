import Foundation


class FrequencyModel {
    let value: FrequncyValueModel
    let taskMode: CreateTaskMode
    let frequencyPicked : ((ATYFrequencyTypeEnum) -> Void)
    
    init(value: FrequncyValueModel, taskMode: CreateTaskMode, frequencyPicked: @escaping (ATYFrequencyTypeEnum) -> Void) {
        self.value = value
        self.taskMode = taskMode
        self.frequencyPicked = frequencyPicked
    }
    
}
