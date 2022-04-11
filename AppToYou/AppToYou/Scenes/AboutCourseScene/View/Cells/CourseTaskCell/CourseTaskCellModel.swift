import UIKit


class CourseTaskCellModel {
    let progressModel: TaskProgressModel
    let descriptionModel: TaskDescriptionModel
    let isSelected: Bool
    let currencyIcon: UIImage?
    
    var selectionDidChange: ((Task, Bool)-> Void)?
    
    init(progressModel: TaskProgressModel, descriptionModel: TaskDescriptionModel, isSelected: Bool, currencyIcon: UIImage?) {
        self.progressModel = progressModel
        self.descriptionModel = descriptionModel
        self.isSelected = isSelected
        self.currencyIcon = currencyIcon
    }
}
