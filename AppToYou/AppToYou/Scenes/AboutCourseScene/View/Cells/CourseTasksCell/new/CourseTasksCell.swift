import UIKit


class CourseTasksCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let choosed: String? = "выбрано"
        
        static let titleInsets = UIEdgeInsets(top: 32, left: 20, bottom: 0, right: 20)
        
        struct Add {
            static let insets = UIEdgeInsets(top: 8, left: 20, bottom: 21, right: 0)
            static let spacing: CGFloat = 4
            static let buttonSize = CGSize(width: 18, height: 18)
        }
    }
    
    private var model: CourseTasksModel?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Задания курса"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    private let addAllLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавить все задачи"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    private let addAllButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.plusButtonImage(), for: .normal)
        return button
    }()

    private let choosedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = R.color.textSecondaryColor()
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(Constants.titleInsets)
        }
        
        let addAllStack = UIStackView(arrangedSubviews: [addAllLabel, addAllButton])
        addAllStack.axis = .horizontal
        addAllStack.spacing = Constants.Add.spacing
        
        contentView.addSubview(addAllStack)
        addAllStack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.Add.insets.top)
            $0.leading.bottom.equalToSuperview().inset(Constants.Add.insets)
            $0.height.equalTo(Constants.Add.buttonSize.height)
        }
        addAllButton.snp.makeConstraints {
            $0.size.equalTo(Constants.Add.buttonSize)
        }
        
        contentView.addSubview(choosedLabel)
        choosedLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Constants.titleInsets)
            $0.centerY.equalTo(addAllStack)
        }
        
        addAllButton.addTarget(self, action: #selector(addAllDidTap), for: .touchUpInside)
        addAllStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addAllDidTap)))
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? CourseTasksModel else {
            return
        }
        self.model = model
        choosedLabel.text = "\(Constants.choosed ?? String()) \(model.addedCount) / \(model.amont)"
    }
    
    @objc
    private func addAllDidTap() {
        model?.addAllTapped()
    }
    
}
