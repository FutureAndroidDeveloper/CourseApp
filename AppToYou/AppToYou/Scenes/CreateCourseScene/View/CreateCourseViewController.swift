import UIKit


class CreateCourseViewController: UIViewController, BindableType {
    private struct Constants {
        static let saveInsets = UIEdgeInsets(top: 0, left: 20, bottom: 13, right: 20)
    }
    
    var viewModel: CreateCourseViewModel!
    
    private let createCourseTableView = ContentSizedTableView()
    private let contentContainer = TopBottomBlocksContainerView()
    private let inflater: UITableViewIflater

    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(R.color.backgroundTextFieldsColor(), for: .normal)
        button.setTitle(R.string.localizable.save(), for: .normal)
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        button.layer.cornerRadius = 22.5
        return button
    }()
    
    
    init() {
        self.inflater = UITableViewIflater(createCourseTableView)
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
        view.addSubview(contentContainer)
        contentContainer.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentContainer.addTop(content: createCourseTableView)
        contentContainer.addBottom(content: doneButton, insets: Constants.saveInsets)
        doneButton.snp.makeConstraints {
            $0.height.equalTo(45)
        }
    }

    
    private func configureInflater() {
        createCourseTableView.separatorStyle = .none
        createCourseTableView.isScrollEnabled = false
        createCourseTableView.allowsSelection = false
        createCourseTableView.backgroundColor = R.color.backgroundAppColor()
        
        inflater.registerRow(model: TaskNameModel.self, cell: TaskNameCell.self)
        inflater.registerRow(model: DescriptionModel.self, cell: DescriptionTaskCell.self)
        inflater.registerRow(model: SelectPhotoModel.self, cell: SelectPhotoCell.self)
        inflater.registerRow(model: CourseCategoryModel.self, cell: CourseCategoryCell.self)
        inflater.registerRow(model: CourseTypeModel.self, cell: CourseTypeCell.self)
        inflater.registerRow(model: PayForCourseModel.self, cell: PayForCourseCell.self)
        inflater.registerRow(model: CourseDurationCellModel.self, cell: CourseDurationCell.self)
        inflater.registerRow(model: CourseChatModel.self, cell: CourseChatCell.self)
        inflater.registerRow(model: DeleteCourseModel.self, cell: DeleteCourseCell.self)
    }
    
    func bindViewModel() {
        viewModel.output.data.bind(self.update(_:))
        viewModel.output.updatedState.bind { [weak self] _ in
            self?.createCourseTableView.reloadData()
        }
        
        doneButton.setTitle(viewModel.output.doneButtonTitle, for: .normal)
        title = viewModel.output.title
    }
    
    func update(_ data: [AnyObject]) {
        let section = TableViewSection(models: data)
        inflater.inflate(sections: [section])
    }
    
    @objc func saveTapped() {
        viewModel.input.doneDidTapped()
    }
}
