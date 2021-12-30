import UIKit


class HighlitedTieleView: UIView {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 1, left: 8, bottom: 4, right: 8)
    }
    
    private let style: HighlitedTieleStyle
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    init(style: HighlitedTieleStyle) {
        self.style = style
        super.init(frame: .zero)
        
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    private func setup() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.edgeInsets)
        }
        backgroundColor = style.backgroundColor
        titleLabel.textColor = style.titleColor
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
}
