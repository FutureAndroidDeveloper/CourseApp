import UIKit


class CourseTypeCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        static let rowSpacing: CGFloat = 16
    }
    
    private let courseTypeOrder: [ATYCourseType] = [.PUBLIC, .PRIVATE, .PAID]
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Тип курса"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalCentering
        stack.spacing = Constants.rowSpacing
        return stack
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        
        configure()
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }

    private func configure() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Constants.edgeInsets)
        }
        
        contentView.addSubview(contentStack)
        contentStack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.edgeInsets.top)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.edgeInsets)
        }
    }
    
    private func setup() {
        courseTypeOrder.compactMap { [weak self] courseType -> CourseTypeModel? in
            guard let self = self else {
                return nil
            }
            return CourseTypeModel(value: courseType, courseTypePicked: self.courseTypeChanged)
        }
        .map { CourseTypeView(model: $0) }
        .forEach { [unowned self] courseTypeView in
            self.contentStack.addArrangedSubview(courseTypeView)
        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? CourseTypeModel else {
            return
        }
        
        courseTypeChanged(model.value)
    }
    
    private func courseTypeChanged(_ courseType: ATYCourseType) {
        print(courseType)
        deselect()
        
        let selectedView = contentStack.arrangedSubviews
            .compactMap { $0 as? CourseTypeView }
            .first { $0.model.value == courseType }
        
        selectedView?.changeSelected(true)
    }
    
    private func deselect() {
        contentStack.arrangedSubviews
            .compactMap { $0 as? CourseTypeView }
            .forEach { $0.changeSelected(false) }
    }
    
}
