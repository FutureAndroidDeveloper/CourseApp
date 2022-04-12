import UIKit


class CoursePreviewTaskCell: UITableViewCell, InflatableView {
    private struct Constants {
        struct Background {
            static let cornerRadius: CGFloat = 20
            static let insets = UIEdgeInsets(top: 7, left: 20, bottom: 7, right: 20)
        }
        static let iconSize = CGSize(width: 16, height: 16)
        static let titleInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 24)
    }
    
    var progressView: TaskProgressView {
        return defaultProgreesView
    }
    
    private let defaultProgreesView = TaskProgressView()
    private let currencyIcon = UIImageView()
    private let titleLabel = UILabel()
    private let backContentView = UIView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = R.color.backgroundAppColor()
        
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backContentView.layer.cornerRadius = Constants.Background.cornerRadius
        backContentView.clipsToBounds = true
    }
    
    private func setup() {
        backgroundColor = .clear
        backContentView.backgroundColor = R.color.backgroundTableCellColor()

        contentView.addSubview(backContentView)
        backContentView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.Background.insets)
        }
        
        contentView.addSubview(currencyIcon)
        currencyIcon.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(35)
            $0.size.equalTo(Constants.iconSize)
        }
        
        backContentView.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.size.equalTo(60)
        }
        
        backContentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(progressView.snp.trailing).offset(Constants.titleInsets.left)
            $0.trailing.equalToSuperview().inset(Constants.titleInsets)
            $0.centerY.equalToSuperview()
        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? CoursePreviewTaskModel else {
            return
        }
        progressView.configure(with: model.progressModel)
        titleLabel.text = model.title
        currencyIcon.image = model.currencyIcon
        layoutIfNeeded()
    }
    
}
