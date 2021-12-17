import Foundation


class FrequencyModel {
    let initialFrequency: ATYFrequencyTypeEnum
    let frequencyPicked : ((ATYFrequencyTypeEnum) -> Void)
    
    init(frequency: ATYFrequencyTypeEnum, frequencyPicked: @escaping (ATYFrequencyTypeEnum) -> Void) {
        initialFrequency = frequency
        self.frequencyPicked = frequencyPicked
    }
    
}
