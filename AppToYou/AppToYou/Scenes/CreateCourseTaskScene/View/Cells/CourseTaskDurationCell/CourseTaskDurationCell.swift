import UIKit


class CourseTaskDurationCell: UITableViewCell, InflatableView, ValidationErrorDisplayable {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let fieldInsets = UIEdgeInsets(top: 9, left: 20, bottom: 0, right: 20)
        static let checkInsets = UIEdgeInsets(top: 12, left: 20, bottom: 32, right: 20)
    }
    
    private var timerCallback: (() -> Void)?
    
    private let titleLabel = LabelFactory.getTitleLabel(title: "Длительность выполнения задачи на курсе")
    private let durationView = TaskDurationView()
    private let infiniteView = TitledCheckBox()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
        
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(Constants.titleInsets)
        }
        
        contentView.addSubview(durationView)
        durationView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.fieldInsets.top)
            $0.leading.trailing.equalToSuperview().inset(Constants.fieldInsets)
        }
        
        contentView.addSubview(infiniteView)
        infiniteView.snp.makeConstraints {
            $0.top.equalTo(durationView.snp.bottom).offset(Constants.checkInsets.top)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.checkInsets)
        }
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(openTimePicker))
        durationView.addGestureRecognizer(tapRecognizer)
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? CourseTaskDurationModel else {
            return
        }
        
        durationView.configure(with: model.durationModel)
        durationView.updateStyle(model.style)
        timerCallback = model.timerCallback
        
        infiniteView.configure(with: model.isInfiniteModel) { [weak self] isInfinite in
            self?.durationView.isUserInteractionEnabled = !isInfinite
        }
        
        model.errorNotification = { [weak self] error in
            self?.durationView.bind(error: error)
            self?.bind(error: error)
        }
    }
    
    @objc
    private func openTimePicker() {
        timerCallback?()
    }
    
}
