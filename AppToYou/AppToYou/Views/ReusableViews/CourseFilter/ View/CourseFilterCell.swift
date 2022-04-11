import UIKit


class CourseFilterCell: UICollectionViewCell {
    private struct Constants {
        static let textInsets = UIEdgeInsets(top: 8, left: 16, bottom: 10, right: 16)
        static let height: CGFloat = 36
    }
    
    private var filter: CourseFilter?
    private var tapHandler: ((CourseFilter) -> Void)?
    private let tapRecognzer = UITapGestureRecognizer()

    private let backgroundCellView: UIView = {
        let view = UIView()
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundCellView.layer.cornerRadius = bounds.height / 2
    }

    private func setup() {
        contentView.addSubview(backgroundCellView)
        backgroundCellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(Constants.height)
        }

        backgroundCellView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.textInsets)
        }
        
        tapRecognzer.addTarget(self, action: #selector(didTap))
        backgroundCellView.addGestureRecognizer(tapRecognzer)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        filter = nil
    }
    
    func configure(with filter: CourseFilter, _ tapHandler: @escaping (CourseFilter) -> Void) {
        self.filter = filter
        self.tapHandler = tapHandler
        titleLabel.text = filter.title
        
        if filter.isSelected {
            select()
        } else {
            deselect()
        }
        titleLabel.sizeToFit()
    }
    
    func select() {
        backgroundCellView.backgroundColor = R.color.textColorSecondary()
        titleLabel.textColor = R.color.backgroundTextFieldsColor()
    }
    
    func deselect() {
        backgroundCellView.backgroundColor = R.color.backgroundTextFieldsColor()
        titleLabel.textColor = R.color.titleTextColor()
    }
    
    @objc
    private func didTap() {
        guard let filter = filter else {
            return
        }
        tapHandler?(filter)
    }
}
