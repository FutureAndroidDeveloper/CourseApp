import Foundation


class FrequncyValueModel {
    private struct Constants {
        static let defaultValue = Frequency.EVERYDAY
    }
    
    private(set) var frequency: Frequency
    
    convenience init() {
        self.init(frequency: Constants.defaultValue)
    }
    
    init(frequency: Frequency) {
        self.frequency = frequency
    }
    
    func update(_ frequency: Frequency) {
        self.frequency = frequency
    }
    
}
