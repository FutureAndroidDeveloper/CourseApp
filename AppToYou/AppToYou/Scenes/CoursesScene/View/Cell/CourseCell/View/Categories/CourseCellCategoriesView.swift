import UIKit


class CourseCellCategoriesView: UIView {
    
    private let scrollView = UIScrollView()
    private let categoriesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
    }()
    
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(categoriesStack)
        categoriesStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    
    func configure(with categories: [ATYCourseCategory]) {
        categoriesStack.removeFullyAllArrangedSubviews()
        
        categories
            .map { CourseCellCategoryView(category: $0) }
            .forEach { self.categoriesStack.addArrangedSubview($0) }
    }
    
}
