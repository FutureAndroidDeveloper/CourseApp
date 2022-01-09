import UIKit


class InfoImageCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let insets = UIEdgeInsets(top: 22, left: 0, bottom: 0, right: 0)
    }
    
    private let infoImageView = UIImageView()
    
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
        contentView.addSubview(infoImageView)
        infoImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Constants.insets)
            $0.center.equalToSuperview()
        }
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? InfoImageModel else {
            return
        }
        infoImageView.image = model.image
    }
    
}
