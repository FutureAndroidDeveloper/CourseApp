import UIKit


class CollectionCategoryCourseCell: UICollectionViewCell {
    
    private struct Constants {
        static let textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 6)
        static let height: CGFloat = 28
        static let removeSize = CGSize(width: 20, height: 20)
    }
    
    private var category: ATYCourseCategory?
    private var didRemove: ((ATYCourseCategory) -> Void)?

    private let backgroundCellView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.backgroundTextFieldsColor()
        
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textAlignment = .center
        label.textColor = R.color.textSecondaryColor()
        return label
    }()
    
    private let removeButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.removeCategory(), for: .normal)
        return button
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
        backgroundCellView.layer.borderColor = R.color.borderColor()?.cgColor
        backgroundCellView.layer.borderWidth = 1
        backgroundCellView.layer.cornerRadius = bounds.height / 2
    }

    private func setup() {
        contentView.addSubview(backgroundCellView)
        backgroundCellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(Constants.height)
        }
        
        backgroundCellView.addSubview(removeButton)
        removeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(3)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(Constants.removeSize)
        }
        
        backgroundCellView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.trailing.equalTo(removeButton.snp.leading).inset(-Constants.textInsets.right)
            $0.leading.equalToSuperview().inset(Constants.textInsets)
            $0.centerY.equalToSuperview()
        }
        
        removeButton.addTarget(self, action: #selector(removeCategory), for: .touchUpInside)
    }
    
    func configure(with category: ATYCourseCategory, _ didRemove: @escaping (ATYCourseCategory) -> Void) {
        self.category = category
        self.didRemove = didRemove
        
        titleLabel.text = category.title
    }
    
    @objc
    private func removeCategory() {
        guard let category = category else {
            return
        }
        
        didRemove?(category)
    }
    
}
