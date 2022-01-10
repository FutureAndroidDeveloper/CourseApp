import UIKit


class CreateCourseTaskCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 38, right: 20)
        static let height: CGFloat = 44
    }
    
    private var model: CreateCourseTaskCellModel?
    
    private let createTaskButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.setTitle("Создать задачу курса", for: .normal)
        button.setTitleColor(R.color.backgroundTextFieldsColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createTaskButton.layer.cornerRadius = createTaskButton.bounds.height / 2
    }
    
    private func setup() {
        contentView.addSubview(createTaskButton)
        createTaskButton.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.edgeInsets)
            $0.height.equalTo(Constants.height)
        }
        
        createTaskButton.addTarget(self, action: #selector(createDidTap), for: .touchUpInside)
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? CreateCourseTaskCellModel else {
            return
        }
        self.model = model
    }
    
    @objc
    private func createDidTap() {
        model?.createTapped()
    }
    
}
