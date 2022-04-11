import UIKit


class CourseLoadingTasksCell: UITableViewCell, InflatableView {
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 20)
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = R.color.textSecondaryColor()
        label.textAlignment = .center
        return label
    }()
    
    private let loaderView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    private var model: CourseLoadingTasksModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.titleInsets)
            $0.height.equalTo(60)
        }
        
        contentView.addSubview(loaderView)
        loaderView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(60)
        }
        
        
        titleLabel.isHidden = true
        loaderView.color = R.color.textColorSecondary()
        loaderView.startAnimating()
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? CourseLoadingTasksModel else {
            return
        }
        self.model = model
        
        model.stopLoading = {
            self.loaderView.stopAnimating()
            self.loaderView.isHidden = true
        }
        
        model.setHint = { title in
            self.titleLabel.text = title
            self.titleLabel.isHidden = false
        }
        layoutIfNeeded()
    }
    
}
