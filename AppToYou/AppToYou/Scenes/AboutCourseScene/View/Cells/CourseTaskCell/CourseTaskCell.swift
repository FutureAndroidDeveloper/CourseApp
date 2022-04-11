import UIKit


class CourseTaskCell: UITableViewCell, InflatableView {
    private struct Constants {
        struct Background {
            static let cornerRadius: CGFloat = 20
            static let insets = UIEdgeInsets(top: 9, left: 20, bottom: 6, right: 20)
        }
        static let iconSize = CGSize(width: 16, height: 16)
        static let contentInsets = UIEdgeInsets(top: 10, left: 0, bottom: 11, right: 16)
    }
    
    var progressView: TaskProgressView {
        return defaultProgreesView
    }
    
    private let defaultProgreesView = TaskProgressView()
    private let descriptionView = TaskDescriptionView()
    private let currencyIcon = UIImageView()
    private let backContentView = UIView()
    private let switchView = UISwitch()
    private let contentStack = UIStackView()
    private var model: CourseTaskCellModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = R.color.backgroundAppColor()
        
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backContentView.layer.cornerRadius = Constants.Background.cornerRadius
        backContentView.clipsToBounds = true
    }
    
    private func setup() {
        backgroundColor = .clear
        backContentView.backgroundColor = R.color.backgroundTextFieldsColor()

        contentView.addSubview(backContentView)
        backContentView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.Background.insets)
        }
        
        contentView.addSubview(currencyIcon)
        currencyIcon.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(35)
            $0.size.equalTo(Constants.iconSize)
        }
        
        backContentView.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.size.equalTo(60)
        }
        
        contentStack.axis = .horizontal
        backContentView.addSubview(contentStack)
        contentStack.snp.makeConstraints {
            $0.leading.equalTo(progressView.snp.trailing).offset(16)
            $0.top.trailing.bottom.equalToSuperview().inset(Constants.contentInsets)
        }
        
        contentStack.addArrangedSubview(descriptionView)
        contentStack.addArrangedSubview(switchView)
        
        switchView.addTarget(self, action: #selector(stateChanged), for: .valueChanged)
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? CourseTaskCellModel else {
            return
        }
        self.model = model
        progressView.configure(with: model.progressModel)
        descriptionView.configure(with: model.descriptionModel)
        currencyIcon.image = model.currencyIcon
        switchView.isOn = model.isSelected
        layoutIfNeeded()
    }
    
    @objc
    private func stateChanged() {
        guard let task = model?.progressModel.task else {
            return
        }
        model?.selectionDidChange?(task, switchView.isOn)
    }
}
