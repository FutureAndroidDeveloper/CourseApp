import UIKit


class SelectWeekdayCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let buttonHeight: CGFloat = 38
        static let edgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20)
    }

    private let buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = 5
        return stack
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(buttonStack)
        buttonStack.snp.makeConstraints {
            $0.height.equalTo(Constants.buttonHeight)
            $0.edges.equalToSuperview().inset(Constants.edgeInsets)
        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? SelectWeekdayModel else {
            return
        }
        
        buttonStack.removeFullyAllArrangedSubviews()
        model.weekdayModels
            .map { WeekdayButton(model: $0) }
            .forEach { self.buttonStack.addArrangedSubview($0) }
    }
    
    func getResult() -> String {
        // TODO: нужно возвращать модели кнопок и из их свойст уже получать строку
        return buttonStack.arrangedSubviews
            .compactMap { $0 as? WeekdayButton }
            .map { $0.getModel() }
            .map { $0.isSelected ? "1" : "0" }
            .joined()
    }

}
