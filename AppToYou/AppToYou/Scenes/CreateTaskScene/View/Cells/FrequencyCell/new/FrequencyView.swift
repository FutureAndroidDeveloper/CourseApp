import UIKit


class FrequencyView: UIView {
    
    private struct Constants {
        static let rowSpacing: CGFloat = 9
        static let buttonSpacing: CGFloat = 12
        static let buttonHeight: CGFloat = 35
    }
    
    private var model: FrequencyModel?
    
    private var frequencyChanged: ((ATYFrequencyTypeEnum) -> Void)?
    private var frequencyOrder: [[ATYFrequencyTypeEnum]]
    private var isPrepared: Bool
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.spacing = Constants.rowSpacing
        return stack
    }()
    
    
    init() {
        self.isPrepared = false
        self.frequencyOrder = []
        
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: FrequencyModel, frequencyChanged: @escaping (ATYFrequencyTypeEnum) -> Void) {
        self.model = model
        self.frequencyChanged = frequencyChanged
        
        self.prepareForMode(mode: model.taskMode, selected: model.value.frequency)
        self.select(model.value.frequency)
    }
    
    private func setup() {
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
    
    private func prepareForMode(mode: CreateTaskMode, selected: ATYFrequencyTypeEnum) {
        guard !isPrepared else {
            return
        }
        frequencyOrder = FrequencyPickerFactory.getFrequencyOrder(for: mode)
        contentStack.removeFullyAllArrangedSubviews()
        frequencyOrder
            .map(convertToRowStack(_:))
            .forEach { contentStack.addArrangedSubview($0) }
        
        let buttonsToModify = getButtons().filter { $0.type != selected }
        
        if case .editCourseTask = mode {
            getButtons().forEach { $0.disable() }
            buttonsToModify.forEach { $0.removeFromSuperview() }
        }
        if case .adminEditCourseTask = mode {
            buttonsToModify.forEach { $0.disable() }
        }
        
        isPrepared = true
    }
    
    @objc
    private func frequencyDidChange(_ sender: FrequencyButton) {
        if sender.isSelected {
            return
        }
        deselect()
        sender.isSelected.toggle()
        self.frequencyChanged?(sender.type)
        model?.value.update(sender.type)
        model?.frequencyPicked(sender.type)
    }
    
}
