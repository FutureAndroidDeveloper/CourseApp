import UIKit


class TitledSectionHeader: UITableViewHeaderFooterView {
    private let titleLabel = UILabel()
    
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
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func set(title: String) {
        titleLabel.text = title
    }
}
