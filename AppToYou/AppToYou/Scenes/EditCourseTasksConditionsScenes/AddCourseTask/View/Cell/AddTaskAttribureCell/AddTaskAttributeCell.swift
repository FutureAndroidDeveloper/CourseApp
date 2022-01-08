import UIKit


class AddTaskAttributeCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: 32, right: 20)
    }
    
    private let titleLabel = LabelFactory.getAddTaskDescriptionLabel(title: nil)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
        
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.titleInsets)
        }
    }
    
    
    func inflate(model: AnyObject) {
        guard let model = model as? AddTaskAttributeModel else {
            return
        }
        titleLabel.text = model.title
    }
    
}
