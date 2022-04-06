import UIKit


class ToodayTaskViewController: UIViewController, BindableType {
    private struct Constants {
        static let calendarHeight: CGFloat = 100
        static let progressHeight: CGFloat = 3
        
        static let edgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let hintOffset: CGFloat = -8
        
        struct CreateButton {
            static let edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 13, right: 18)
            static let size = CGSize(width: 44, height: 44)
        }
    }
    
    var viewModel : TodayTasksViewModel!
    
    private let tasksTableView = UITableView()
    private let calendarViewController = CalendarViewController()
    private let progressView = ATYStackProgressView()
    private let emptyTasksHint = UIImageView(image: R.image.tip())
    private var canEditAt: (Bool, IndexPath) = (true, .empty)

    private lazy var createTaskButton: UIButton = {
        let button = UIButton()
        let icon = R.image.vBth_add()?.withRenderingMode(.alwaysTemplate)
        button.setImage(icon, for: .normal)
        button.tintColor = R.color.backgroundTextFieldsColor()
        button.backgroundColor = R.color.buttonColor()
        return button
    }()
    
    
    init(title: String?) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        view.backgroundColor = R.color.backgroundAppColor()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        updateProgressView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emptyTasksHint.isHidden = viewModel.output.getTaskHintState()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        createTaskButton.layer.cornerRadius = createTaskButton.bounds.height / 2
    }
    
    private func configure() {
        calendarViewController.getProgress = { [weak self] date in
            return self?.viewModel.output.getProgress(for: date) ?? .future
        }
        
        calendarViewController.dateDidSelect = { [weak self] date in
            self?.viewModel.input.dateChanged(date)
        }
        
        addChild(calendarViewController)
        view.addSubview(calendarViewController.view)
        calendarViewController.didMove(toParent: self)
        calendarViewController.view.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            $0.height.equalTo(Constants.calendarHeight)
        }
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.top.equalTo(self.calendarViewController.view.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(Constants.edgeInsets)
            $0.height.equalTo(Constants.progressHeight)
        }
        
        view.addSubview(tasksTableView)
        tasksTableView.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(Constants.edgeInsets)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
        
        tasksTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        tasksTableView.backgroundColor = R.color.backgroundAppColor()
        tasksTableView.showsVerticalScrollIndicator = false
        tasksTableView.separatorStyle = .none
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        
        tasksTableView.register(TitledSectionHeader.self, forHeaderFooterViewReuseIdentifier: TitledSectionHeader.reuseIdentifier)
        tasksTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseIdentifier)
        tasksTableView.register(CounterTaskCell.self, forCellReuseIdentifier: CounterTaskCell.reuseIdentifier)
        tasksTableView.register(TimerTaskCell.self, forCellReuseIdentifier: TimerTaskCell.reuseIdentifier)
        
        view.addSubview(createTaskButton)
        createTaskButton.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(Constants.CreateButton.edgeInsets)
            $0.size.equalTo(Constants.CreateButton.size)
        }
        createTaskButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        
        view.addSubview(emptyTasksHint)
        emptyTasksHint.snp.makeConstraints {
            $0.trailing.equalTo(createTaskButton.snp.leading).offset(Constants.hintOffset)
            $0.centerY.equalTo(createTaskButton)
        }
    }
    
    func bindViewModel() {
        viewModel.output.update.bind { [weak self] _ in
            self?.tasksTableView.reloadData()
            self?.updateProgressView()
        }
        
        viewModel.output.refreshDate.bind { [weak self] _ in
            self?.calendarViewController.viewDidAppear(false)
        }
        
        viewModel.output.insertUpdate.bind { [weak self] indexPath in
            self?.updateTaskRow(indexPath: indexPath, update: .insert)
            self?.updateProgressView()
            self?.calendarViewController.updateTodayProgress()
        }
        
        viewModel.output.removeUpdate.bind { [weak self] indexPath in
            self?.updateTaskRow(indexPath: indexPath, update: .remove)
            self?.updateProgressView()
            self?.calendarViewController.updateTodayProgress()
        }
        
        viewModel.output.reloadUpdate.bind { [weak self] indexPath in
            self?.updateTaskRow(indexPath: indexPath, update: .reload)
        }
        
        viewModel.output.dateIsOver.bind { [weak self] in
            self?.calendarViewController.dateIsOver()
        }
    }
    
    private func updateProgressView() {
        let optionalViewModel = viewModel
        guard let source = optionalViewModel?.output else {
            return
        }
        let states = (source.inProgress + source.completed).map { $0.progressModel.state }
        progressView.update(states: states)
    }
    
    private func updateTaskRow(indexPath: IndexPath, update: TaskUpdate) {
        guard indexPath != .empty else {
            return
        }
        tasksTableView.performBatchUpdates({ [weak self] in
            switch update {
            case .insert:
                self?.tasksTableView.insertRows(at: [indexPath], with: .automatic)
            case .remove:
                self?.tasksTableView.deleteRows(at: [indexPath], with: .automatic)
            case .reload:
                // не перезагружать ячейку в режими редактирования
                if indexPath == canEditAt.1, canEditAt.0 == false {
                    return
                }
                self?.tasksTableView.reloadRows(at: [indexPath], with: .none)
            }
        }, completion: nil)
    }
    
    @objc
    private func refresh(_ sender: AnyObject) {
        viewModel.input.refresh()
    }

    @objc
    private func addButtonAction() {
        viewModel.input.addTask()
    }
}


extension ToodayTaskViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.output.inProgress.count
        } else if section == 1 {
            return viewModel.output.completed.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: TaskCell?
        var model: TaskCellModel
        
        if indexPath.section == .zero {
            model = viewModel.output.inProgress[indexPath.row]
        } else {
            model = viewModel.output.completed[indexPath.row]
        }
        
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            if viewModel.output.inProgress.isEmpty {
                return 0
            } else {
                return 10
            }
        case 1:
            if viewModel.output.completed.isEmpty {
                return 0
            } else {
                return 32
            }
        default:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitledSectionHeader.reuseIdentifier) as? TitledSectionHeader else {
            return nil
        }
        
        var title = String()
        if section == 1, viewModel.output.completed.isEmpty {
            return nil
        } else if section == 1, !viewModel.output.completed.isEmpty {
            title = "Выполненные задачи"
        }
        headerView.set(title: title)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.input.edit(task: indexPath)
    }
    
    // MARK: - Swipe Editing
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        canEditAt = (true, indexPath ?? .empty)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return canEditAt.0
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
        canEditAt = (false, indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completion in
            self?.viewModel.input.remove(task: indexPath)
            completion(true)
        }
        deleteAction.image = R.image.deleteImage()
        deleteAction.backgroundColor = R.color.transparent()
        
        let editAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, completion in
            self?.viewModel.input.edit(task: indexPath)
            completion(true)
        }
        editAction.image = R.image.editImage()
        editAction.backgroundColor = R.color.transparent()
        
        let configuration = UISwipeActionsConfiguration(actions: [editAction, deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
}
