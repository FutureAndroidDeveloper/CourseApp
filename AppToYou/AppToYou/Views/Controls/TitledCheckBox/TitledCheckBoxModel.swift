import Foundation


class TitledCheckBoxModel {
    let title: String
    private(set) var isSelected: Bool
    
    init(title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
    
    func chandeSelectedState(_ isSelected: Bool) {
        self.isSelected = isSelected
    }
    
}
