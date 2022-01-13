import UIKit


class ValidatableViewWrapper: UIView, ValidationErrorDisplayable {
    
    private let content: UIView
    
    init(content: UIView = UIView()) {
        self.content = content
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(content)
        content.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
