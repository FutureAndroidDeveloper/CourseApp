import UIKit


class CourseCellCategoryView: UIView {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 3, left: 10, bottom: 5, right: 10)
        static let borderWidth: CGFloat = 1
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.textColor = R.color.textSecondaryColor()
        return label
    }()

    
    init(category: ATYCourseCategory) {
        super.init(frame: .zero)
        titleLabel.text = category.title
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = R.color.borderColor()?.cgColor
        layer.borderWidth = Constants.borderWidth
        layer.cornerRadius = bounds.height / 2
    }

    private func setup() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalTo(Constants.titleInsets)
        }
    }
    
}
