import UIKit


class CourseViewController: UIViewController, BindableType {

    var viewModel: CourseViewModel!
    
    private let tableView = UITableView()
    private let inflater: UITableViewIflater
    
    
    init() {
        inflater = UITableViewIflater(tableView)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

    private func configureNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
        navigationController?.navigationBar.isHidden = true
        navigationItem.hidesBackButton = true
        navigationItem.backBarButtonItem = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.hidesBarsOnSwipe = false
//        configureNavBar()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tableView.reloadData()
//    }

    private func setup() {
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        view.backgroundColor = R.color.backgroundAppColor()
        tableView.backgroundColor = R.color.backgroundAppColor()
        
        inflater.registerRow(model: CourseHeaderModel.self, cell: CourseHeaderCell.self)
        inflater.registerRow(model: CourseDescriptionModel.self, cell: CourseDescriptionCell.self)
        inflater.registerRow(model: CourseAdminMembersModel.self, cell: CourseAdminMembersCell.self)
        inflater.registerRow(model: JoinCourseChatModel.self, cell: JoinCourseChatCell.self)
        inflater.registerRow(model: CourseTasksModel.self, cell: CourseTasksCell.self)
        inflater.registerRow(model: TaskCellModel.self, cell: TaskCell.self)
        inflater.registerRow(model: CreateCourseTaskCellModel.self, cell: CreateCourseTaskCell.self)
        inflater.registerRow(model: CourseMembersModel.self, cell: CourseMembersCell.self)
        inflater.registerRow(model: ShareCourseModel.self, cell: ShareCourseCell.self)
        inflater.registerRow(model: ReportCourseModel.self, cell: ReportCourseCell.self)
        
        handleRowSelection()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        viewModel.output.data.bind(self.update(_:))
        viewModel.output.updatedState.bind { [weak self] _ in
            self?.tableView.beginUpdates()
            self?.tableView.endUpdates()
        }
    }
    
    private func update(_ data: [AnyObject]) {
        let section = TableViewSection(models: data)
        inflater.inflate(sections: [section])
    }
    
    private func handleRowSelection() {
        inflater.addRowHandler(for: TaskCellModel.self) { [weak self] model, indexPath in
            self?.viewModel.input.editCourseTask(index: indexPath.row)
        }
    }

    private func showTaskAddedPopup() {
        let child = ATYTaskAddedViewController(type: .oneTask)
        self.present(child, animated: true)
    }
    
}
