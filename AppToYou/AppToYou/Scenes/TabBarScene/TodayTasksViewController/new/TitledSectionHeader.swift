import UIKit


class TitleSectionModel {
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
}

class TitledSectionHeader: UITableViewHeaderFooterView, InflatableView {
    
    private let titleLabel = UILabel()
    
    static var staticHeight: CGFloat? {
        return 40
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        confugire()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func confugire() {
        contentView.backgroundColor = R.color.backgroundAppColor()
        
        titleLabel.backgroundColor = R.color.backgroundAppColor()
        titleLabel.textColor = R.color.textSecondaryColor()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.centerY.equalToSuperview()
        }
        
//        titleLabel.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? TitleSectionModel else {
            return
        }
        
        titleLabel.text = model.title
    }
    
}
