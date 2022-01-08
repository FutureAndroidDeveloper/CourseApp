import UIKit


class AddTaskTitleCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        static let subtitleInsets = UIEdgeInsets(top: 6, left: 20, bottom: 32, right: 0)
        static let iconInsets = UIEdgeInsets(top: 9, left: 8, bottom: 0, right: 20)
        
        static let iconSize = CGSize(width: 30, height: 30)
    }
    
    private let taskTitleLabel = LabelFactory.getAddTaskTitleLabel(title: nil)
    private let taskSubtitleLabel = LabelFactory.getAddTaskSubtitleLabel(title: nil)
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = R.color.textColorSecondary()
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
        
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(taskTitleLabel)
        taskTitleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(Constants.titleInsets)
        }
        
        contentView.addSubview(taskSubtitleLabel)
        taskSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(taskTitleLabel.snp.bottom).offset(Constants.subtitleInsets.top)
            $0.trailing.equalTo(taskTitleLabel)
            $0.leading.bottom.equalToSuperview().inset(Constants.subtitleInsets)
        }
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Constants.iconInsets)
            $0.leading.equalTo(taskTitleLabel.snp.trailing).offset(Constants.iconInsets.left)
            $0.size.equalTo(Constants.iconSize)
        }
    }
    
    
    func inflate(model: AnyObject) {
        guard let model = model as? AddTaskTitleModel else {
            return
        }
        
        taskTitleLabel.text = model.title
        taskSubtitleLabel.text = model.subtitle
        iconView.image = model.icon
    }
    
}
