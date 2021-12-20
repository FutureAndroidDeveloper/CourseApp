import Foundation


class FrequencyModel {
    let value: FrequncyValueModel
    let frequencyPicked : ((ATYFrequencyTypeEnum) -> Void)
    
    init(value: FrequncyValueModel, frequencyPicked: @escaping (ATYFrequencyTypeEnum) -> Void) {
        self.value = value
        self.frequencyPicked = frequencyPicked
    }
    
}
