import UIKit


class TaskDurationCell: UITableViewCell, InflatableView, ValidationErrorDisplayable {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let fieldInsets = UIEdgeInsets(top: 9, left: 20, bottom: 32, right: 20)
    }
    
    private var timerCallback: (() -> Void)?
    
    private let titleLabel = LabelFactory.getTitleLabel(title: "Длительность выполнения задачи")
    private let durationView = TaskDurationView()

//    let lockButton : UIButton = {
//        let button = UIButton()
//        button.setImage(R.image.chain()?.withRenderingMode(.alwaysTemplate), for: .normal)
//        button.imageView?.tintColor = R.color.lineViewBackgroundColor()
//        button.isHidden = true
//        return button
//    }()

    
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
        
        
        contentView.addSubview(durationView)
        durationView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.fieldInsets.top)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.fieldInsets)
        }
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(openTimePicker))
        durationView.addGestureRecognizer(tapRecognizer)

//        lockButton.addTarget(self, action: #selector(chainButtonAction(_:)), for: .touchUpInside)
//        lockButton.snp.makeConstraints { (make) in
//            make.trailing.equalToSuperview().offset(-20)
//            make.centerY.equalTo(secTextField)
//            make.height.width.equalTo(24)
//        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? TaskDurationCellModel else {
            return
        }
        
        durationView.configure(with: model.durationModel)
        timerCallback = model.timerCallback
        
        model.errorNotification = { [weak self] error in
            self?.durationView.bind(error: error)
            self?.bind(error: error)
        }
    }
    
//    @objc func chainButtonAction(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        sender.imageView?.tintColor = sender.isSelected ?  R.color.textColorSecondary() : R.color.lineViewBackgroundColor()
//    }
    
    @objc
    private func openTimePicker() {
        timerCallback?()
    }
    
}
