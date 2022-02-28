import UIKit


class NewTaskCellModel {
    let progressModel: TaskProgressModel
    let descriptionModel: TaskDescriptionModel
    let hintModel: CourseTaskHintModel?
    let taskActionModel: TaskAction?
    
    init(progressModel: TaskProgressModel, descriptionModel: TaskDescriptionModel, hintModel: CourseTaskHintModel?, taskActionModel: TaskAction?) {
        self.progressModel = progressModel
        self.descriptionModel = descriptionModel
        self.hintModel = hintModel
        self.taskActionModel = taskActionModel
    }
}


class CommonTaskCell: UITableViewCell {
    
    private(set) var model: NewTaskCellModel?
    
    var timerTapped: ((NewTaskCellModel) -> Void)?
    var countTapped: ((NewTaskCellModel) -> Void)?
    var checkTapped: ((NewTaskCellModel) -> Void)?
    var textTapped: ((NewTaskCellModel) -> Void)?
    
    private let progressView = TaskProgressView()
    private let descriptionView = TaskDescriptionView()
    private let courseHintView = CourseTaskHintView()
    private var actionView = UIView()
    private let actionViewContainer = UIView()
    
    private let contentStack = UIStackView()
    
    private let backContentView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.backgroundTextFieldsColor()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        selectionStyle = .none
//        backgroundColor = R.color.backgroundAppColor()
        
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
        backContentView.backgroundColor = .blue
        backContentView.layer.cornerRadius = 20
        backContentView.clipsToBounds = true
    }
    
    
    private func setup() {
        contentView.addSubview(backContentView)
        backContentView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 9, left: 0, bottom: 6, right: 0))
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
            $0.top.trailing.bottom.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 0, bottom: 11, right: 16))
        }
        
        actionViewContainer.backgroundColor = .red
        actionViewContainer.snp.makeConstraints {
            $0.width.equalTo(60)
        }
        contentStack.addArrangedSubview(descriptionView)
        contentStack.addArrangedSubview(actionViewContainer)
        
        progressView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(progressTap)))
    }
    
    func configure(with model: NewTaskCellModel) {
        self.model = model
        
        progressView.configure(with: model.progressModel)
        descriptionView.configure(with: model.descriptionModel)
        
        if let hintModel = model.hintModel {
            courseHintView.configure(with: hintModel)
        }
        configureActionView()
    }
    
    
    private func configureActionView() {
        actionView.removeFromSuperview()
        
        if let taskActionModel = model?.taskActionModel as? TaskTimerActionModel {
            let timerView = TaskTimerActionView()
            timerView.configure(with: taskActionModel)
            actionView = timerView
        }
        
        if let taskActionModel = model?.taskActionModel as? TaskCounterActionModel {
            let counterView = TaskCounterActionView()
            counterView.configure(with: taskActionModel)
            actionView = counterView
        }
        
        actionViewContainer.addSubview(actionView)
        actionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc
    private func progressTap() {
        guard let model = model else {
            return
        }

        switch model.progressModel.type {
        case .CHECKBOX:
            checkTapped?(model)
        case .RITUAL:
            countTapped?(model)
        case .TEXT:
            textTapped?(model)
        case .TIMER:
            timerTapped?(model)
        }
    }
    
}
