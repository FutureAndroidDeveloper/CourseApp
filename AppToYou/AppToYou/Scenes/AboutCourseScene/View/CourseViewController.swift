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
        
        configure()
        configureInflater()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.input.refresh()
        viewModel.input.resetContainerAppearance()
    }
    
    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func configureInflater() {
        view.backgroundColor = R.color.backgroundAppColor()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = R.color.backgroundAppColor()
        
        inflater.registerRow(model: CourseHeaderModel.self, cell: CourseHeaderCell.self)
        inflater.registerRow(model: CourseDescriptionModel.self, cell: CourseDescriptionCell.self)
        inflater.registerRow(model: CourseAdminMembersModel.self, cell: CourseAdminMembersCell.self)
        inflater.registerRow(model: JoinCourseChatModel.self, cell: JoinCourseChatCell.self)
        inflater.registerRow(model: CourseTasksModel.self, cell: CourseTasksCell.self)
        
        inflater.registerRow(model: CourseLoadingTasksModel.self, cell: CourseLoadingTasksCell.self)
        inflater.registerRow(model: CourseTaskCellModel.self, cell: CourseTaskCell.self)
        inflater.registerRow(model: CourseCounterTaskCellModel.self, cell: CourseCounterTaskCell.self)
        
        inflater.registerRow(model: CreateCourseTaskCellModel.self, cell: CreateCourseTaskCell.self)
        inflater.registerRow(model: CourseMembersModel.self, cell: CourseMembersCell.self)
        inflater.registerRow(model: ShareCourseModel.self, cell: ShareCourseCell.self)
        inflater.registerRow(model: ReportCourseModel.self, cell: ReportCourseCell.self)
        
        inflater.willDisplayCell = { cell, _ in
            cell.contentView.setNeedsLayout()
            cell.contentView.layoutIfNeeded()
        }
        
        handleRowSelection()
    }
    
    func bindViewModel() {
        viewModel.output.sections.bind { [weak self] sections in
            self?.update(sections)
        }
        viewModel.output.updatedState.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    func update(_ sections: [TableViewSection]) {
        inflater.inflate(sections: sections)
    }
    
    private func handleRowSelection() {
        inflater.addRowHandler(for: CourseTaskCellModel.self) { [weak self] model, indexPath in
            self?.viewModel.input.editCourseTask(model.courseTaskResponse)
        }
        inflater.addRowHandler(for: CourseCounterTaskCellModel.self) { [weak self] model, indexPath in
            self?.viewModel.input.editCourseTask(model.courseTaskResponse)
        }
    }
    
}
