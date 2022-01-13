import UIKit


class LabelFactory {
    
    static let errorTag = 3_12_12_0_12
    static let errorInsets = UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20)
    
    static func getTitleLabel(title: String?) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }
    
    static func getErrorLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = R.color.failureColor()
        label.textAlignment = .right
        label.tag = Self.errorTag
        return label
    }
    
    static func getAddTaskTitleLabel(title: String?) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }
    
    static func getAddTaskSubtitleLabel(title: String?) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = R.color.textSecondaryColor()
        return label
    }
    
    static func getAddTaskDescriptionLabel(title: String?) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = R.color.titleTextColor()
        label.numberOfLines = 2
        return label
    }
    
    static func getChooseTaskTypeTitleLable(title: String?) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }
    
    static func getChooseTaskDescriptionLable(title: String?) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = R.color.textSecondaryColor()
        label.numberOfLines = 0
        return label
    }
    
    
    static func createHeaderLabel(title: String?) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }
    
}
