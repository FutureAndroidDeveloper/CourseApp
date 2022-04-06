import UIKit


/**
 Базовая реализация ячейки задачи.
 */
class TaskCell: UITableViewCell {
    private struct Constants {
        struct Background {
            static let cornerRadius: CGFloat = 20
            static let insets = UIEdgeInsets(top: 9, left: 0, bottom: 6, right: 0)
        }
        static let contentInsets = UIEdgeInsets(top: 10, left: 0, bottom: 11, right: 16)
    }
    
    var progressView: TaskProgressView {
        return defaultProgreesView
    }
    
    var actionView: TaskActionView? {
        return nil
    }
    
    private let defaultProgreesView = TaskProgressView()
    private let descriptionView = TaskDescriptionView()
    private let courseHintView = CourseTaskHintView()
    private let backContentView = UIView()
    private let contentStack = UIStackView()
    
    
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
        
        contentView.addSubview(courseHintView)
        courseHintView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(13)
            $0.height.equalTo(18)
        }
        
        backContentView.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(60)
        }
        
        contentStack.axis = .horizontal
        backContentView.addSubview(contentStack)
        contentStack.snp.makeConstraints {
            $0.leading.equalTo(progressView.snp.trailing).offset(16)
            $0.top.trailing.bottom.equalToSuperview().inset(Constants.contentInsets)
        }
        
        contentStack.addArrangedSubview(descriptionView)
        
        if let actionView = actionView {
            actionView.snp.makeConstraints {
                $0.width.equalTo(60)
            }
            contentStack.addArrangedSubview(actionView)
        }
        
        progressView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(progressTap)))
    }
    
    func configure(with model: TaskCellModel) {
        progressView.configure(with: model.progressModel)
        descriptionView.configure(with: model.descriptionModel)
        
        if let hintModel = model.hintModel {
            courseHintView.configure(with: hintModel)
        }
        
        if let actionModel = model.actionModel {
            actionView?.configure(with: actionModel)
        }
        
        if model.progressModel.state == .inProgress {
            highlight()
        } else {
            removeHighlight()
        }
    }
    
    private func highlight() {
        backContentView.layer.borderWidth = 1
        backContentView.layer.borderColor = R.color.textColorSecondary()?.cgColor
    }
    
    private func removeHighlight() {
        backContentView.layer.borderWidth = 0
    }
    
    @objc
    private func progressTap() {
        progressView.handleTapAction()
    }
    
}
