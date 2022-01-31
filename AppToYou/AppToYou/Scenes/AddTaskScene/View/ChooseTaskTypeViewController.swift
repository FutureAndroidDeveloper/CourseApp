import UIKit


class ChooseTaskTypeViewController: UIViewController, BindableType {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 32, left: 20, bottom: 0, right: 20)
        static let tableContentInsets = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
    }
    
    var viewModel: ChooseTaskTypeViewModel!
    private let taskTypesTableview = ContentSizedTableView()
    private let inflater: UITableViewIflater
    private let titleLabel = LabelFactory.getAddTaskTitleLabel(title: R.string.localizable.selectTheTypeOfTask())
    
    
    init() {
        inflater = UITableViewIflater(taskTypesTableview)
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
    
    private func configure() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Constants.titleInsets)
        }
        
        view.addSubview(taskTypesTableview)
        taskTypesTableview.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configureInflater() {
        taskTypesTableview.separatorStyle = .none
        taskTypesTableview.bounces = false
        taskTypesTableview.allowsSelection = true
        taskTypesTableview.backgroundColor = R.color.backgroundTextFieldsColor()
        inflater.registerRow(model: ChooseTaskTypeModel.self, cell: ChooseTaskTypeCell.self)
        taskTypesTableview.contentInset = Constants.tableContentInsets
        
        inflater.addRowHandler(for: ChooseTaskTypeModel.self) { [weak self] model, _ in
            self?.viewModel.input.typePicked(model.taskType)
        }
    }
    
    func bindViewModel() {
        viewModel.output.sections.bind(self.update(_:))
        viewModel.output.updatedState.bind { [weak self] _ in
            self?.taskTypesTableview.reloadData()
        }
    }
    
    func update(_ sections: [TableViewSection]) {
        inflater.inflate(sections: sections)
    }
}
