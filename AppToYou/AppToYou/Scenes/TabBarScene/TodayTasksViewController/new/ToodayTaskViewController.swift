import UIKit
import XCoordinator


final class ToodayTaskViewController: UIViewController, BindableType {
    
    func bindViewModel() {
    }
    

    private var transition: PanelTransition!
//    private let taskRouter: UnownedRouter<TasksRoute>

    var viewModel : TodayTasksViewModel!

    var calendarCollectionView: UICollectionView!
    var tasksTableView = UITableView()
    
    private let inflater: UITableViewIflater
    
    var calendarCollectionViewController: ATYCalendarCollectionViewController!

    let typeButton = UIButton()
    let tipImageView = UIImageView()
    let progressView = ATYStackProgressView()

    var temporaryArray = [TemporaryData(typeTask: .CHECKBOX,
                                        courseName: "Бокс",
                                        hasSanction: true,
                                        titleLabel: "Медитация",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .failed, date: Date.dateFormatter.date(from: "2021/08/14")),
                          TemporaryData(typeTask: .RITUAL,
                                        courseName: nil,
                                        hasSanction: true,
                                        titleLabel: "Сходить на площадку",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .performed, date: Date.dateFormatter.date(from: "2021/08/14")),
                          TemporaryData(typeTask: .TEXT,
                                        courseName: "Спорт",
                                        hasSanction: true,
                                        titleLabel: "Отжимания",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .performed, date: Date.dateFormatter.date(from: "2021/08/14")),
                          TemporaryData(typeTask: .CHECKBOX,
                                        courseName: nil,
                                        hasSanction: true,
                                        titleLabel: "Прочитать книгу",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .performed, date: Date.dateFormatter.date(from: "2021/08/15")),
                          TemporaryData(typeTask: .RITUAL,
                                        courseName: "Здоровье",
                                        hasSanction: false,
                                        titleLabel: "Отжимания",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "20 раз",
                                        state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/15")),
                          TemporaryData(typeTask: .CHECKBOX,
                                        courseName: "Шитье",
                                        hasSanction: false,
                                        titleLabel: "Большой текст тест текст на длину длинный текст",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .failed, date: Date.dateFormatter.date(from: "2021/08/16")),
                          TemporaryData(typeTask: .TIMER,
                                        courseName: nil,
                                        hasSanction: true,
                                        titleLabel: "Медитация",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .performed, date: Date.dateFormatter.date(from: "2021/08/16")),
                          TemporaryData(typeTask: .CHECKBOX,
                                        courseName: "Здоровье",
                                        hasSanction: false,
                                        titleLabel: "Приседания",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "10 раз",
                                        state: .didNotStart, date: Date.dateFormatter.date(from: "2021/08/16")),
                          TemporaryData(typeTask: .TIMER,
                                        courseName: nil,
                                        hasSanction: false,
                                        titleLabel: "Медитация",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .failed, date: Date.dateFormatter.date(from: "2021/08/17")),
                          TemporaryData(typeTask: .TIMER,
                                        courseName: nil,
                                        hasSanction: false,
                                        titleLabel: "Медитация",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .failed, date: Date.dateFormatter.date(from: "2021/08/17")),
                          TemporaryData(typeTask: .CHECKBOX,
                                        courseName: nil,
                                        hasSanction: false,
                                        titleLabel: "Медитация",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .done, date: Date.dateFormatter.date(from: "2021/08/17")),
                          TemporaryData(typeTask: .TEXT,
                                        courseName: nil,
                                        hasSanction: false,
                                        titleLabel: "Медитация",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .failed, date: Date.dateFormatter.date(from: "2021/08/17")),
                          TemporaryData(typeTask: .RITUAL,
                                        courseName: nil,
                                        hasSanction: false,
                                        titleLabel: "Медитация",
                                        firstSubtitleLabel: "Каждый день",
                                        secondSubtitleLabel: "60 мин",
                                        state: .performed, date: Date.dateFormatter.date(from: "2021/08/17"))]

    var completedTask = [TemporaryData(typeTask: .CHECKBOX,
                                       courseName: "Электрика",
                                       hasSanction: true,
                                       titleLabel: "Велосипед",
                                       firstSubtitleLabel: "пт, cуб, вскр",
                                       secondSubtitleLabel: "60 мин",
                                       state: .done, date: Date.dateFormatter.date(from: "2021/08/14")),
                         TemporaryData(typeTask: .TEXT,
                                       courseName: "Машиностроение",
                                       hasSanction: false,
                                       titleLabel: "Тех обслуживание",
                                       firstSubtitleLabel: "пт, cуб, вскр",
                                       secondSubtitleLabel: "60 мин",
                                       state: .done, date: Date.dateFormatter.date(from: "2021/08/14")),
                         TemporaryData(typeTask: .TIMER,
                                       courseName: nil,
                                       hasSanction: true,
                                       titleLabel: "Пробежка",
                                       firstSubtitleLabel: "пт, cуб, вскр",
                                       secondSubtitleLabel: "60 мин",
                                       state: .done, date: Date.dateFormatter.date(from: "2021/08/13")),
                         TemporaryData(typeTask: .RITUAL,
                                       courseName: "Английский",
                                       hasSanction: false,
                                       titleLabel: "Учить глаголы",
                                       firstSubtitleLabel: "пт, cуб, вскр",
                                       secondSubtitleLabel: "60 мин",
                                       state: .done, date: Date.dateFormatter.date(from: "2021/08/17")),
                         TemporaryData(typeTask: .RITUAL,
                                       courseName: "Английский",
                                       hasSanction: false,
                                       titleLabel: "Учить глаголы",
                                       firstSubtitleLabel: "пт, cуб, вскр",
                                       secondSubtitleLabel: "60 мин",
                                       state: .done, date: Date.dateFormatter.date(from: "2021/08/17")),
                         TemporaryData(typeTask: .TEXT,
                                       courseName: "Английский",
                                       hasSanction: false,
                                       titleLabel: "Учить глаголы",
                                       firstSubtitleLabel: "пт, cуб, вскр",
                                       secondSubtitleLabel: "60 мин",
                                       state: .done, date: Date.dateFormatter.date(from: "2021/08/17")),
                         TemporaryData(typeTask: .TIMER,
                                       courseName: "Английский",
                                       hasSanction: false,
                                       titleLabel: "Учить глаголы",
                                       firstSubtitleLabel: "пт, cуб, вскр",
                                       secondSubtitleLabel: "60 мин",
                                       state: .done, date: Date.dateFormatter.date(from: "2021/08/17"))]

    var filteredArrayCurrent = [TemporaryData]()
    var filteredArrayDoneTasks = [TemporaryData]()


    init(title: String?) {
        inflater = UITableViewIflater(tasksTableView)
        
        super.init(nibName: nil, bundle: nil)
        self.title = title
        view.backgroundColor = R.color.backgroundAppColor()
        
//        self.viewModel = ATYTodayTasksViewModel(router: taskRouter)
//        self.viewModel.delegate = self
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.transition = PanelTransition(y: view.bounds.height * 0.4 , height: view.bounds.height * 0.6)
        configureViewControllers()
        addBlurEffect()
        confgigureStackView()
        configureTableView()
        configureAddButtonAndTipImage()

        filteredArrayCurrent = temporaryArray
        filteredArrayDoneTasks = completedTask
        
        updateProgressView()
        loadData()
    }
    
    private func loadData() {
//        let firstModels = filteredArrayCurrent.map { task -> TaskCellModel in
//            let myBool = Int.random(in: 0...100).isMultiple(of: 2)
//            let taskType: TaskCell.UserOrCourseTask = myBool ? .user : .course
//            return TaskCellModel(model: task, task: taskType)
//            
//        }
//        let firstSection = TableViewSection(models: firstModels, header: nil)
//        
//        let secondModels = filteredArrayDoneTasks.map { task -> TaskCellModel in
//            let myBool = Int.random(in: 0...100).isMultiple(of: 2)
//            let taskType: TaskCell.UserOrCourseTask = myBool ? .user : .course
//            return TaskCellModel(model: task, task: taskType)
//            
//        }
//        let doneSection = TitleSectionModel(title: "Выполненные задачи")
//        let secondSection = TableViewSection(models: secondModels, header: doneSection)
//        
//        inflater.inflate(sections: [firstSection, secondSection])
    }

    func addBlurEffect() {
        let bounds = self.navigationController?.navigationBar.bounds
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = bounds ?? CGRect.zero
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.navigationController?.navigationBar.addSubview(visualEffectView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.viewModel.getData()

        self.tipImageView.isHidden = !(filteredArrayCurrent.isEmpty && filteredArrayDoneTasks.isEmpty)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.calendarCollectionViewController.updateData()
        self.calendarCollectionViewController.dateCallback = { [weak self] dateString in
            let date = dateString.toDate(dateFormat: .calendarFormat)

            self?.filteredArrayCurrent = self?.temporaryArray.filter({ Calendar.current.compare( $0.date ?? Date(), to: date ?? Date(), toGranularity: .day) == .orderedSame}) ?? []

            self?.filteredArrayDoneTasks = self?.completedTask.filter({ Calendar.current.compare( $0.date ?? Date(), to: date ?? Date(), toGranularity: .day) == .orderedSame}) ?? []
            
//            self?.tasksTableView.reloadData()
            
            self?.updateProgressView()
            print("CallbackDate: \(String(describing: date))")
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.typeButton.layer.cornerRadius = self.typeButton.frame.height/2
        typeButton.layer.masksToBounds = false
        typeButton.layer.shadowColor = UIColor.black.cgColor
        typeButton.layer.shadowPath = UIBezierPath(roundedRect: typeButton.bounds, cornerRadius: typeButton.layer.cornerRadius).cgPath
        typeButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        typeButton.layer.shadowOpacity = 0.5
        typeButton.layer.shadowRadius = 1.0

        self.tipImageView.isHidden = !(filteredArrayCurrent.isEmpty && filteredArrayDoneTasks.isEmpty)
    }
    
    private func updateProgressView() {
        let states = (self.filteredArrayCurrent + self.filteredArrayDoneTasks)
        let filteredStates = states.compactMap { (temporaryData) -> CurrentStateTask? in
            return temporaryData.state
        }
        progressView.countOfViews = (count: self.filteredArrayCurrent.count + self.filteredArrayDoneTasks.count, typeState: filteredStates)
        progressView.layoutSubviews()
    }

    private func configureAddButtonAndTipImage() {
        let icon = R.image.vBth_add()?.withRenderingMode(.alwaysTemplate)
        self.typeButton.setImage(icon, for: .normal)
        self.typeButton.tintColor = R.color.backgroundTextFieldsColor()
        self.typeButton.backgroundColor = R.color.buttonColor()
        self.typeButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)

        view.addSubview(self.typeButton)
        self.typeButton.snp.makeConstraints { (make) in
            make.bottom.trailing.equalToSuperview().offset(-25)
            make.height.width.equalTo(50)
        }

        tipImageView.image = R.image.tip()
        view.addSubview(tipImageView)

        self.tipImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(typeButton.snp.leading).offset(-10)
            make.centerY.equalTo(typeButton)
        }
    }

    private func configureViewControllers() {
        self.calendarCollectionViewController = ATYCalendarCollectionViewController()
        self.calendarCollectionView = self.calendarCollectionViewController.collectionView

        view.addSubview(self.calendarCollectionView)
        addChild(self.calendarCollectionViewController)
        self.calendarCollectionViewController.didMove(toParent: self)


        self.calendarCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.height.equalTo(100)
        }
    }

    private func confgigureStackView() {
        view.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(calendarCollectionView.snp.bottom)
            make.height.equalTo(3)
        }
    }

    private func configureTableView() {
        
        inflater.registerHeaderFooter(model: TitleSectionModel.self, headerFooter: TitledSectionHeader.self)
        inflater.registerRow(model: TaskCellModel.self, cell: TaskCell.self)
        
        view.addSubview(tasksTableView)
        tasksTableView.backgroundColor = R.color.backgroundAppColor()
        tasksTableView.showsVerticalScrollIndicator = false
        tasksTableView.separatorStyle = .none
//        tasksTableView.delegate = self
//        tasksTableView.dataSource = self
//        tasksTableView.register(ATYTaskTableViewCell.self, forCellReuseIdentifier: ATYTaskTableViewCell.reuseIdentifier)
        tasksTableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(progressView.snp.bottom).offset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
    }

    @objc
    private func addButtonAction() {
        viewModel.input.addTask()
    }
    
}

extension ToodayTaskViewController : ATYTodayTasksViewModelDelegate {
    func updateData() {
        self.tasksTableView.reloadData()
    }
}


