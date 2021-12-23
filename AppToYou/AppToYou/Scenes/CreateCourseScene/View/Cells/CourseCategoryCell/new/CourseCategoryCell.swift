import UIKit


class CourseCategoryCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        static let pickerHeight: CGFloat = 50
    }
    
    private let categoryPicker = CategoryPickerView()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Категория курса"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()


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
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Constants.edgeInsets)
        }
        
        contentView.addSubview(categoryPicker)
        categoryPicker.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.edgeInsets.top)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.edgeInsets)
            $0.height.equalTo(Constants.pickerHeight)
        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? CourseCategoryModel else {
            return
        }
        
        categoryPicker.configure(with: model)
    }
    
}
