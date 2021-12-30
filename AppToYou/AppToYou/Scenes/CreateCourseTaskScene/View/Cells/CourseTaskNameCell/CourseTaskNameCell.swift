import UIKit


class CourseTaskNameCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 32, left: 20, bottom: 32, right: 0)
        static let courseViewInsets = UIEdgeInsets(top: 24, left: 10, bottom: 0, right: 20)
        static let courseViewHeight: CGFloat = 16
    }
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = R.color.titleTextColor()
        return label
    }()
    
    private let courseView: UIView = {
        let view = HighlitedTieleView(style: .courseName)
        view.configure(title: "курс")
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = R.color.backgroundAppColor()
        
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(Constants.titleInsets)
        }
        
        contentView.addSubview(courseView)
        courseView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.courseViewInsets)
            $0.leading.equalTo(titleLabel.snp.trailing).inset(Constants.courseViewInsets.left)
            $0.trailing.lessThanOrEqualToSuperview().inset(Constants.courseViewInsets)
            $0.height.equalTo(Constants.courseViewHeight)
        }
        courseView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? CourseTaskNameModel else {
            return
        }
        titleLabel.text = model.courseName
    }
    
}

