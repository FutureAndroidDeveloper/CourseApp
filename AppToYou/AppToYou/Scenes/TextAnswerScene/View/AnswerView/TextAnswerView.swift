import UIKit


class TextAnswerView: UIView {
    private struct Constants {
        static let edgeInses = UIEdgeInsets(top: 8, left: 20, bottom: 16, right: 20)
        static let answerViewHeight: CGFloat = 284
    }
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private let textLengthLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.textSecondaryColor()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.titleTextColor()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.titleTextColor()
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    private let answerTextView = PlaceholderTextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = R.color.backgroundAppColor()
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.edgeInses)
        }
        
        answerTextView.snp.makeConstraints {
            $0.height.equalTo(Constants.answerViewHeight)
        }
        
        stackView.addArrangedSubview(textLengthLabel)
        stackView.setCustomSpacing(16, after: textLengthLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.setCustomSpacing(16, after: descriptionLabel)
        stackView.addArrangedSubview(nameLabel)
        stackView.setCustomSpacing(8, after: nameLabel)
        stackView.addArrangedSubview(answerTextView)
    }
    
    func configure(with model: TextAnswerModel) {
        textLengthLabel.text = "Напишите минимум \(model.length) символов"
        descriptionLabel.text = model.description
        nameLabel.text = model.name
        
        let answerModel = PlaceholderTextViewModel(value: model.answer, placeholder: "Введите ваш ответ")
        answerTextView.configure(with: answerModel)
        model.setAnswerModel(answerModel)
    }
}
