import UIKit


class ATYCreateTaskViewController: UIViewController, BindableType {
    private struct Constants {
        static let saveInsets = UIEdgeInsets(top: 0, left: 20, bottom: 13, right: 20)
    }
    
    var viewModel: CreateTaskViewModel!
    
    private let createTaskTableView = ContentSizedTableView()
    private let contentContainer = TopBottomBlocksContainerView()
    private var inflater: UITableViewIflater!
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(R.color.backgroundTextFieldsColor(), for: .normal)
        button.setTitle(R.string.localizable.save(), for: .normal)
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        button.layer.cornerRadius = 22.5
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundAppColor()
        
        configure()
        configureInflater()
        viewModel.input.loadFields()
    }
    
    private func configure() {
        view.addSubview(contentContainer)
        contentContainer.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentContainer.addTop(content: createTaskTableView)
        contentContainer.addBottom(content: saveButton, insets: Constants.saveInsets)
        
        saveButton.snp.makeConstraints {
            $0.height.equalTo(45)
        }
    }
    
    private func configureInflater() {
        createTaskTableView.separatorStyle = .none
        createTaskTableView.isScrollEnabled = false
        createTaskTableView.allowsSelection = false
        createTaskTableView.backgroundColor = R.color.backgroundAppColor()
        
        inflater = UITableViewIflater(createTaskTableView)
        
        // common
        inflater.registerRow(model: TaskNameModel.self, cell: TaskNameCell.self)
        inflater.registerRow(model: FrequencyModel.self, cell: FrequencyCell.self)
        inflater.registerRow(model: NotificationAboutTaskModel.self, cell: NotificationAboutTaskCell.self)
        inflater.registerRow(model: TaskSanctionModel.self, cell: TaskSanctionCell.self)
        
        // optional
        inflater.registerRow(model: SelectWeekdayModel.self, cell: SelectWeekdayCell.self)
        inflater.registerRow(model: SelectDateModel.self, cell: SelectDateCell.self)
        inflater.registerRow(model: TaskPeriodModel.self, cell: TaskPeriodCell.self)
        
        // timer
        inflater.registerRow(model: TaskDurationCellModel.self, cell: TaskDurationCell.self)
        
        // text
        inflater.registerRow(model: DescriptionModel.self, cell: DescriptionTaskCell.self)
        inflater.registerRow(model: MinimumSymbolsModel.self, cell: MinimumSymbolsCell.self)

        // counting
        inflater.registerRow(model: RepeatCounterModel.self, cell: RepeatCounterCell.self)
        
        // course
        inflater.registerRow(model: CourseTaskMinSanctionModel.self, cell: CourseTaskMinSanctionCell.self)
        inflater.registerRow(model: CourseTaskLockModel.self, cell: CourseTaskLockHeaderCell.self)
        inflater.registerRow(model: CourseTaskNameModel.self, cell: CourseTaskNameCell.self)
        inflater.registerRow(model: CourseTaskDurationModel.self, cell: CourseTaskDurationCell.self)
    }
    
    func bindViewModel() {
        viewModel.output.sections.bind(self.update(_:))
        viewModel.output.updatedState.bind { [weak self] _ in
            self?.createTaskTableView.reloadData()
        }
        viewModel.output.title.bind { [weak self] title in
            self?.title = title
        }
    }
    
    func update(_ sections: [TableViewSection]) {
        inflater.inflate(sections: sections)
    }
    
    @objc
    private func saveTapped() {
        viewModel.input.saveDidTapped()
    }
}
