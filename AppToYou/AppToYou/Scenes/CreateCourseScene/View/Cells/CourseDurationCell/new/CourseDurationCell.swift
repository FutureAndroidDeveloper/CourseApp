import UIKit


class CourseDurationCell: UITableViewCell, InflatableView, ValidationErrorDisplayable {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let descriptionInsets = UIEdgeInsets(top: 9, left: 20, bottom: 24, right: 20)
        static let durationInsets = UIEdgeInsets(top: 24, left: 20, bottom: 0, right: 0)
        static let infiniteInsets = UIEdgeInsets(top: 12, left: 25, bottom: 32, right: 20)
    }
    
    private var model: CourseDurationCellModel?
    
    private let titleLabel = LabelFactory.getTitleLabel(title: "Длительность курса")
    private let durationView = TaskDurationView()
    private let infiniteView = TitledCheckBox()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Срок, в течение которого пользователь будет выполнить все задачи курса после их добавления (срок, на который рассчитан курс)"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = R.color.textSecondaryColor()
        label.numberOfLines = 0
        return label
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
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
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.descriptionInsets.top)
            $0.leading.trailing.equalToSuperview().inset(Constants.descriptionInsets)
        }
        
        contentView.addSubview(durationView)
        durationView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(Constants.durationInsets.top)
            $0.leading.trailing.equalToSuperview().inset(Constants.durationInsets)
        }
        
        contentView.addSubview(infiniteView)
        infiniteView.snp.makeConstraints {
            $0.top.equalTo(durationView.snp.bottom).offset(Constants.infiniteInsets.top)
            $0.bottom.leading.trailing.equalTo(Constants.infiniteInsets)
        }
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(openTimePicker))
        durationView.addGestureRecognizer(tapRecognizer)
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? CourseDurationCellModel else {
            return
        }
        self.model = model
        
        durationView.configure(with: model.durationModel)
        durationView.updateStyle(model.style)
        infiniteView.configure(with: model.isInfiniteModel) { [weak self] isInfinite in
            self?.infiniteStateChanged(isInfinite)
        }
        
        model.errorNotification = { [weak self] error in
            self?.durationView.bind(error: error)
            self?.bind(error: error)
        }
    }
    
    private func infiniteStateChanged(_ isInfinite: Bool) {
        durationView.isUserInteractionEnabled = !isInfinite
    }
    
    @objc
    private func openTimePicker() {
        model?.timerCallback()
    }
    
}
