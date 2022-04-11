import UIKit


class CoursePreviewViewController: UIViewController, BindableType {
    private struct Constants {
        static let createButtonInsets = UIEdgeInsets(top: 30, left: 20, bottom: 0, right: 20)
        static let buttonHeight: CGFloat = 75
    }

    var viewModel: CoursePreviewViewModel!
    
    private let inflater: UITableViewIflater
    private let tableView = ContentSizedTableView()
    private let footerView = UIView()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(R.color.backgroundTextFieldsColor(), for: .normal)
        button.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        return button
    }()
    
    init() {
        inflater = UITableViewIflater(tableView)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureInflater()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        actionButton.layer.cornerRadius = actionButton.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.sheetViewController?.pullBarBackgroundColor = .clear
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

        footerView.addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.createButtonInsets)
        }
        footerView.frame = CGRect(x: 0.0, y: 0.0, width: .greatestFiniteMagnitude, height: Constants.buttonHeight)
        tableView.tableFooterView = footerView
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    private func configureInflater() {
        tableView.alwaysBounceVertical = false
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.backgroundColor = R.color.backgroundTextFieldsColor()
        
        inflater.registerRow(model: CourseImageHeaderModel.self, cell: CourseImageHeaderCell.self)
        inflater.registerRow(model: CourseDescriptionHeaderModel.self, cell: CourseDescriptionHeaderView.self)
        inflater.registerRow(model: CourseLoadingTasksModel.self, cell: CourseLoadingTasksCell.self)
        inflater.registerRow(model: CoursePreviewTaskModel.self, cell: CoursePreviewTaskCell.self)
        inflater.registerRow(model: CoursePreviewTaskModelCounter.self, cell: CoursePreviewTaskCellCounter.self)
    }
    
    func bindViewModel() {
        viewModel.output.sections.bind(self.update(_:))
        viewModel.output.updatedState.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        viewModel.output.title.bind { [weak self] buttonTitle in
            self?.actionButton.setTitle(buttonTitle, for: .normal)
        }
    }
    
    func update(_ sections: [TableViewSection]) {
        inflater.inflate(sections: sections)
        sheetViewController?.updateIntrinsicHeight()
    }

    @objc
    private func actionTapped() {
        viewModel.input.buttonDidTap()
    }
    
}
