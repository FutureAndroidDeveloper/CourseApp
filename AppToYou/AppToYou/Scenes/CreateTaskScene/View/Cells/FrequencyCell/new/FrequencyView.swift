import UIKit


class FrequencyView: UIView {
    
    private struct Constants {
        static let rowSpacing: CGFloat = 9
        static let buttonSpacing: CGFloat = 12
        static let buttonHeight: CGFloat = 35
    }
    
    private var model: FrequencyModel?
    
    private let frequencyOrder: [[ATYFrequencyTypeEnum]] = [
        [.EVERYDAY, .WEEKDAYS],
        [.MONTHLY, .YEARLY],
        [.ONCE, .CERTAIN_DAYS],
    ]
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.spacing = Constants.rowSpacing
        return stack
    }()
    
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: FrequencyModel) {
        self.model = model
        self.select(model.initialFrequency)
    }
    
    private func setup() {
        frequencyOrder
            .map(convertToRowStack(_:))
            .forEach { contentStack.addArrangedSubview($0) }
        
        addSubview(contentStack)
        contentStack.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
    }
    
    private func convertToRowStack(_ types: [ATYFrequencyTypeEnum]) -> UIStackView {
        let rowStack = UIStackView()
        rowStack.distribution = .fillProportionally
        rowStack.spacing = Constants.buttonSpacing
        
        types
            .map(createButton(type:))
            .forEach { rowStack.addArrangedSubview($0) }
        
        return rowStack
    }
    
    private func createButton(type: ATYFrequencyTypeEnum) -> FrequencyButton {
        let button = FrequencyButton(type: type)
        button.setTitle(getTitle(of: type), for: .normal)
        button.addTarget(self, action: #selector(frequencyDidChange(_:)), for: .touchUpInside)
        button.snp.makeConstraints {
            $0.height.equalTo(Constants.buttonHeight)
        }
        return button
    }
    
    private func getTitle(of type: ATYFrequencyTypeEnum) -> String? {
        var title: String?
        
        switch type {
        case .ONCE:
            title = R.string.localizable.once()
        case .EVERYDAY:
            title = R.string.localizable.daily()
        case .WEEKDAYS:
            title = R.string.localizable.onWeekdays()
        case .MONTHLY:
            title = R.string.localizable.monthly()
        case .YEARLY:
            title = R.string.localizable.everyYear()
        case .CERTAIN_DAYS:
            title = R.string.localizable.selectDaysWeek()
        }
        return title
    }
    
    private func select(_ frequency: ATYFrequencyTypeEnum) {
        guard let selectedButton = getButtons().first(where: { $0.type == frequency }) else {
            return
        }
        selectedButton.sendActions(for: .touchUpInside)
    }
    
    private func deselect() {
        getButtons().forEach { $0.isSelected = false }
    }
    
    private func getButtons() -> [FrequencyButton] {
        return contentStack.arrangedSubviews
            .compactMap { $0 as? UIStackView }
            .flatMap { $0.arrangedSubviews }
            .compactMap { $0 as? FrequencyButton }
    }
    
    @objc
    private func frequencyDidChange(_ sender: FrequencyButton) {
        deselect()
        sender.isSelected = true
        model?.frequencyPicked(sender.type)
    }
    
}
