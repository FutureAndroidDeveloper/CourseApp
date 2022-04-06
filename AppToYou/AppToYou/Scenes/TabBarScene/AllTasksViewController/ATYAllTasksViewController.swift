import UIKit
import XCoordinator


class ATYAllTasksViewController: UIViewController, BindableType {
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        static let switchInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 20)
        static let tableInsets = UIEdgeInsets(top: 30, left: 20, bottom: 0, right: 20)
        static let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        
        struct CreateButton {
            static let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 13, right: 18)
            static let size = CGSize(width: 44, height: 44)
        }
    }
    
    var viewModel: AllTasksViewModel!
    
    private let refreshControl = UIRefreshControl()
    private let tasksTableView = UITableView()
    private var isCanEdit = true

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Отображать только мои задачи"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    private let switchButton: UISwitch = {
        let switchButton = UISwitch()
        switchButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        switchButton.onTintColor = R.color.textColorSecondary()
        return switchButton
    }()
    
    private lazy var createTaskButton: UIButton = {
        let button = UIButton()
        let icon = R.image.vBth_add()?.withRenderingMode(.alwaysTemplate)
        button.setImage(icon, for: .normal)
        button.tintColor = R.color.backgroundTextFieldsColor()
        button.backgroundColor = R.color.buttonColor()
        return button
    }()
    
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        view.backgroundColor = R.color.backgroundAppColor()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.input.refresh()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        createTaskButton.layer.cornerRadius = createTaskButton.bounds.height / 2
    }

    private func setup() {
        view.addSubview(switchButton)
        switchButton.snp.makeConstraints {
            $0.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.switchInsets)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.trailing.equalTo(self.switchButton.snp.leading)
            $0.centerY.equalTo(self.switchButton)
            $0.leading.equalToSuperview().inset(Constants.titleInsets)
        }
        
        tasksTableView.addSubview(refreshControl)
        view.addSubview(tasksTableView)
        tasksTableView.snp.makeConstraints {
            $0.top.equalTo(self.switchButton.snp.bottom).inset(Constants.tableInsets)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.tableInsets)
        }
        
        view.addSubview(createTaskButton)
        createTaskButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(Constants.CreateButton.edgeInsets)
            $0.size.equalTo(Constants.CreateButton.size)
        }
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        createTaskButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        switchButton.addTarget(self, action: #selector(switchButtonAction), for: .valueChanged)
    }

    private func configure() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        tasksTableView.contentInset = Constants.contentInsets
        tasksTableView.backgroundColor = R.color.backgroundAppColor()
        tasksTableView.separatorStyle = .none
        tasksTableView.showsVerticalScrollIndicator = false
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        
        tasksTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseIdentifier)
        tasksTableView.register(CounterTaskCell.self, forCellReuseIdentifier: CounterTaskCell.reuseIdentifier)
        tasksTableView.register(TimerTaskCell.self, forCellReuseIdentifier: TimerTaskCell.reuseIdentifier)
    }
    
    func bindViewModel() {
        viewModel.output.update.bind { [weak self] in
            self?.tasksTableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    @objc
    private func switchButtonAction() {
        viewModel.input.showMyTasks(switchButton.isOn)
    }
    
    @objc
    private func refresh(_ sender: AnyObject) {
        viewModel.input.refresh()
    }

    @objc
    private func addButtonAction() {
        viewModel.input.createTask()
    }
}


extension ATYAllTasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: TaskCell?
        let model = viewModel.output.tasks[indexPath.row]
        
        switch model.task.taskType {
        case .CHECKBOX, .TEXT:
            cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier, for: indexPath) as? TaskCell
        case .RITUAL:
            cell = tableView.dequeueReusableCell(withIdentifier: CounterTaskCell.reuseIdentifier, for: indexPath) as? CounterTaskCell
        case .TIMER:
            cell = tableView.dequeueReusableCell(withIdentifier: TimerTaskCell.reuseIdentifier, for: indexPath) as? TimerTaskCell
        }
        
        cell?.configure(with: model)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.input.edit(indexPath.row)
    }
    
    // MARK: - Swipe
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        isCanEdit = true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return isCanEdit
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        if let swipeContainerView = tableView.subviews.first(where: { String(describing: type(of: $0)) == "_UITableViewCellSwipeContainerView" }) {
            let backView = UIView()
            backView.backgroundColor = R.color.buttonColor()
            
            swipeContainerView.insertSubview(backView, at: 0)
            backView.snp.makeConstraints {
                $0.top.trailing.bottom.equalToSuperview().inset(UIEdgeInsets(top: 9, left: 0, bottom: 6, right: 0))
                $0.width.equalToSuperview().multipliedBy(0.7)
            }
        }
        isCanEdit = false
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completion in
            self?.viewModel.input.remove(indexPath.row)
            completion(true)
        }
        deleteAction.image = R.image.deleteImage()
        deleteAction.backgroundColor = R.color.transparent()
        
        
        let editAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completion in
            self?.viewModel.input.edit(indexPath.row)
            completion(true)
        }
        editAction.image = R.image.editImage()
        editAction.backgroundColor = R.color.transparent()
        
        let configuration = UISwipeActionsConfiguration(actions: [editAction, deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
}
