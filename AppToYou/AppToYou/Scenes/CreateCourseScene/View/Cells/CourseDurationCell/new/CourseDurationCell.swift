import UIKit


class CourseDurationCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 24, bottom: 6, right: 20)
        static let descriptionInsets = UIEdgeInsets(top: 0, left: 24, bottom: 24, right: 16)
        static let durationInsets = UIEdgeInsets(top: 0, left: 20, bottom: 14, right: 0)
        static let infiniteInsets = UIEdgeInsets(top: 0, left: 20, bottom: 34, right: 0)
        
        static let defualtDuration = DurationTime(hour: "0", min: "0", sec: "0")
    }
    
    private var model: CourseDurationCellModel?
    
    private let durationView = TaskDurationView()
    private let infiniteView = TitledCheckBox()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Длительность курса"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

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
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(Constants.titleInsets)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.titleInsets.bottom)
            $0.leading.trailing.equalToSuperview().inset(Constants.descriptionInsets)
        }
        
        contentView.addSubview(durationView)
        durationView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(Constants.descriptionInsets.bottom)
            $0.leading.trailing.equalToSuperview().inset(Constants.durationInsets)
        }
        
        contentView.addSubview(infiniteView)
        infiniteView.snp.makeConstraints {
            $0.top.equalTo(durationView.snp.bottom).offset(Constants.durationInsets.bottom)
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
        infiniteView.configure(with: model.isInfiniteModel) { [weak self] isInfinite in
            self?.infiniteStateChanged(isInfinite)
        }
    }
    
    private func infiniteStateChanged(_ isInfinite: Bool) {
        guard let durationModel = model?.durationModel else {
            return
        }

        durationModel.update(durationTime: Constants.defualtDuration)
        durationView.configure(with: durationModel)
    }
    
    @objc
    private func openTimePicker() {
        model?.timerCallback()
    }
    
}
