import UIKit


class InfoViewController: UIViewController, BindableType {
    
    var viewModel: InfoViewModel!
    
    private let infoTable = ContentSizedTableView()
    private let inflater: UITableViewIflater
    
    
    init() {
        inflater = UITableViewIflater(infoTable)
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
        view.addSubview(infoTable)
        infoTable.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    private func configureInflater() {
        infoTable.separatorStyle = .none
        infoTable.showsVerticalScrollIndicator = false
        infoTable.bounces = false
        infoTable.allowsSelection = false
        infoTable.backgroundColor = R.color.backgroundTextFieldsColor()
        
        inflater.registerRow(model: InfoTitleModel.self, cell: InfoTitleCell.self)
        inflater.registerRow(model: InfoImageModel.self, cell: InfoImageCell.self)
        inflater.registerRow(model: InfoSanctionTimerModel.self, cell: InfoSanctionTimerCell.self)
        inflater.registerRow(model: InfoDescriptionModel.self, cell: InfoDescriptionCell.self)
        inflater.registerRow(model: InfoDoneModel.self, cell: InfoDoneCell.self)
        inflater.registerRow(model: InfoPayLaterModel.self, cell: InfoPayLaterCell.self)
    }
    
    func bindViewModel() {
        viewModel.output.sections.bind { [weak self] sections in
            self?.update(sections)
        }
        viewModel.output.updatedState.bind { [weak self] _ in
            self?.infoTable.reloadData()
        }
    }
    
    func update(_ sections: [TableViewSection]) {
        inflater.inflate(sections: sections)
    }
    
}
