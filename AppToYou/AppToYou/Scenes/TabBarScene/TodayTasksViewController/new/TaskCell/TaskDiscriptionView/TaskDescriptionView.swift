import UIKit

class TaskDescriptionModel {
    let title: String
    let description: String
    
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}

class TaskDescriptionView: UIView {
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configure(with model: TaskDescriptionModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
}
