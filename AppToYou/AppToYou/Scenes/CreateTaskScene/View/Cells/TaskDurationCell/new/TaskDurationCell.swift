import UIKit

class TaskDurationCellModel {
    let durationModel: TaskDurationModel
    
    /**
     Обработчик выбора времени для представления длительности выполнения задачи.
     */
    let timerCallback: () -> Void
    
    init(durationModel: TaskDurationModel, timerCallback: @escaping () -> Void) {
        self.durationModel = durationModel
        self.timerCallback = timerCallback
    }
}

class TaskDurationCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }

    private let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Длительность выполнения задачи"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = R.color.titleTextColor()
        return label
    }()

    private let durationView = TaskDurationView()
    
    private var timerCallback: (() -> Void)?

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
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(Constants.edgeInsets)
        }
        
        
        contentView.addSubview(durationView)
        durationView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.edgeInsets.top)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.edgeInsets)
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
