import Foundation


class FrequncyValueModel {
    private struct Constants {
        static let defaultValue = ATYFrequencyTypeEnum.EVERYDAY
    }
    
    private(set) var frequency: ATYFrequencyTypeEnum
    
    convenience init() {
        self.init(frequency: Constants.defaultValue)
    }
    
    init(frequency: ATYFrequencyTypeEnum) {
        self.frequency = frequency
    }
    
    func update(_ frequency: ATYFrequencyTypeEnum) {
        self.frequency = frequency
    }
    
}
