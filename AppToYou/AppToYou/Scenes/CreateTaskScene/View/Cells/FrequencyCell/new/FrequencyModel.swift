import Foundation


class FrequencyModel {
    let value: FrequncyValueModel
    let taskMode: CreateTaskMode
    let frequencyPicked : ((Frequency) -> Void)
    
    init(value: FrequncyValueModel, taskMode: CreateTaskMode, frequencyPicked: @escaping (Frequency) -> Void) {
        self.value = value
        self.taskMode = taskMode
        self.frequencyPicked = frequencyPicked
    }
    
}
