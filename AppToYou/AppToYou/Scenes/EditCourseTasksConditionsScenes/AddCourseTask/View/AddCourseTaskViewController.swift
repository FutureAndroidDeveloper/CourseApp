import UIKit


class AddCourseTaskViewController: UIViewController, BindableType {
    private struct Constants {
        static let createButtonInsets = UIEdgeInsets(top: 30, left: 20, bottom: 0, right: 20)
        static let buttonHeight: CGFloat = 75
    }

    var viewModel: AddCourseTaskViewModel!
    
    private var inflater: UITableViewIflater?
    private let tableView = ContentSizedTableView()
    private let footerView = UIView()
    
    private lazy var createTaskButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(R.color.backgroundTextFieldsColor(), for: .normal)
        button.setTitle("Добавить задачу", for: .normal)
        button.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureInflater()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createTaskButton.layer.cornerRadius = createTaskButton.frame.height / 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.sheetViewController?.handleScrollView(tableView)
    }
    
    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        footerView.addSubview(createTaskButton)
        createTaskButton.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.createButtonInsets)
        }
        footerView.frame = CGRect(x: 0.0, y: 0.0, width: .greatestFiniteMagnitude, height: Constants.buttonHeight)
        tableView.tableFooterView = footerView
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    private func configureInflater() {
        inflater = UITableViewIflater(tableView)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.backgroundColor = R.color.backgroundTextFieldsColor()
        
        inflater?.registerRow(model: AddTaskTitleModel.self, cell: AddTaskTitleCell.self)
        inflater?.registerRow(model: AddTaskDescriptionModel.self, cell: AddTaskDescriptionCell.self)
        inflater?.registerRow(model: AddTaskAttributeModel.self, cell: AddTaskAttributeCell.self)
        inflater?.registerRow(model: TaskSanctionModel.self, cell: TaskSanctionCell.self)
        inflater?.registerRow(model: MinimumSymbolsModel.self, cell: MinimumSymbolsCell.self)
        inflater?.registerRow(model: TaskDurationCellModel.self, cell: TaskDurationCell.self)
        inflater?.registerRow(model: RepeatCounterModel.self, cell: RepeatCounterCell.self)
        
    }
    
    func bindViewModel() {
        viewModel.output.sections.bind(self.update(_:))
        viewModel.output.updatedState.bind { [weak self] _ in
            self?.tableView.beginUpdates()
            self?.tableView.endUpdates()
        }
    }
    
    func update(_ sections: [TableViewSection]) {
        inflater?.inflate(sections: sections)
    }

    @objc
    private func createTapped() {
        viewModel.input.saveDidTapped()
    }
    
}
