import UIKit


class CollectionCategoryCourseCell: UICollectionViewCell {
    
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
        label.textColor = R.color.titleTextColor()
        
        return label
    }()
    
    private let removeButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        
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
        backgroundCellView.layer.borderColor = R.color.textSecondaryColor()?.cgColor
        backgroundCellView.layer.borderWidth = 1
        backgroundCellView.layer.cornerRadius = bounds.height / 2
    }

    private func setup() {
        contentView.addSubview(backgroundCellView)
        
        removeButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 16, height: 16))
        }
        
        backgroundCellView.addSubview(removeButton)
        removeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
        
        backgroundCellView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalTo(removeButton.snp.leading).inset(-10)
            $0.centerY.equalToSuperview()
        }
        
        backgroundCellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(28)
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
