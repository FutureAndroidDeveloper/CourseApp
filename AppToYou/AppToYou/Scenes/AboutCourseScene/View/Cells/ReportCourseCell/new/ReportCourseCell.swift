import UIKit


class ReportCourseCell: UITableViewCell, InflatableView {

    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 32, right: 0)
        static let iconSize = CGSize(width: 24, height: 24)
        static let spacing: CGFloat = 12
    }
    
    private var model: ReportCourseModel?
    
    private let reportImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.reportImage()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let reportLabel = UILabel()
        reportLabel.text = "Пожаловаться на курс"
        reportLabel.font = UIFont.systemFont(ofSize: 15)
        return reportLabel
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        selectionStyle = .none
        backgroundColor = R.color.backgroundAppColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(reportImageView)
        reportImageView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(Constants.edgeInsets)
            $0.size.equalTo(Constants.iconSize)
        }

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(reportImageView.snp.trailing).offset(Constants.spacing)
            $0.trailing.equalToSuperview().inset(Constants.edgeInsets)
            $0.centerY.equalTo(reportImageView)
        }
        
        titleLabel.isUserInteractionEnabled = true
        reportImageView.isUserInteractionEnabled = true
        titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(reportDidTap)))
        reportImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(reportDidTap)))
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? ReportCourseModel else {
            return
        }
        self.model = model
    }
    
    @objc
    private func reportDidTap() {
        model?.reportTapped()
    }
    
}
