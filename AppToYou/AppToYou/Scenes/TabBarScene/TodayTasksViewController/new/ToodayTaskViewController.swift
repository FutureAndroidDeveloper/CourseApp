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
    private let emptyTasksHint = UIImageView.init(image: R.image.tip())

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
        loadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        createTaskButton.layer.cornerRadius = createTaskButton.bounds.height / 2
    }
    
    private func configure() {
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
        tasksTableView.backgroundColor = R.color.backgroundAppColor()
        tasksTableView.showsVerticalScrollIndicator = false
        tasksTableView.separatorStyle = .none
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        tasksTableView.register(ATYTaskTableViewCell.self, forCellReuseIdentifier: ATYTaskTableViewCell.reuseIdentifier)
        
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
    
    private func loadData() {
    }
    
    func bindViewModel() {
        
    }
    
    private func updateProgressView() {
        let tmpStates: [CurrentStateTask] = [.didNotStart, .done, .failed, .performed]
        progressView.update(states: tmpStates)
    }

    @objc
    private func addButtonAction() {
        viewModel.input.addTask()
    }
    
}


extension ToodayTaskViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
