import UIKit


class CourseCategoryCell: UITableViewCell, InflatableView, ValidationErrorDisplayable {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let pickerInsets = UIEdgeInsets(top: 9, left: 20, bottom: 32, right: 20)
        static let pickerHeight: CGFloat = 50
    }
    
    private let titleInsets = LabelFactory.getTitleLabel(title: "Категория курса")
    private let categoryPicker = CategoryPickerView()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(titleInsets)
        titleInsets.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Constants.titleInsets)
        }
        
        contentView.addSubview(categoryPicker)
        categoryPicker.snp.makeConstraints {
            $0.top.equalTo(titleInsets.snp.bottom).offset(Constants.pickerInsets.top)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.pickerInsets)
            $0.height.equalTo(Constants.pickerHeight)
        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? CourseCategoryModel else {
            return
        }
        
        categoryPicker.configure(with: model)
        model.errorNotification = { [weak self] error in
            self?.categoryPicker.bind(error: error)
            self?.bind(error: error)
        }
    }
    
}
