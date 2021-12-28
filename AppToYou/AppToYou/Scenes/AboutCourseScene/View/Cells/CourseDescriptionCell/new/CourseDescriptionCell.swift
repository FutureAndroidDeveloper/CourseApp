import Foundation
import UIKit


class CourseDescriptionCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        struct CourseType {
            static let edgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 0, right: 0)
        }
        
        struct Name {
            static let edgeInsets = UIEdgeInsets(top: 2, left: 20, bottom: 0, right: 10)
        }
        
        struct Description {
            static let edgeInsets = UIEdgeInsets(top: 16, left: 20, bottom: 12, right: 20)
        }
        
        struct LikeContent {
            static let edgeInsets = UIEdgeInsets(top: 17, left: 0, bottom: 0, right: 20)
            static let spacing: CGFloat = 6
            static let buttonSize = CGSize(width: 20, height: 20)
            
        }
    }
    
    private var model: CourseDescriptionModel?
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = R.color.textColorSecondary()
        return label
    }()

    private let nameCourseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = R.color.titleTextColor()
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel : UILabel = {
        let label = UILabel()
        label.textColor = R.color.titleTextColor()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 3
        return label
    }()

    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.likesView(), for: .normal)
        button.setImage(R.image.filledRedLike(), for: .selected)
        return button
    }()

    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = R.color.textSecondaryColor()
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let stack = UIStackView(arrangedSubviews: [likesLabel, likeButton])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Constants.LikeContent.spacing
        stack.snp.contentHuggingHorizontalPriority = 250
        
        contentView.addSubview(stack)
        stack.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Constants.LikeContent.edgeInsets)
        }
        likeButton.snp.makeConstraints {
            $0.size.equalTo(Constants.LikeContent.buttonSize)
        }
        likesLabel.snp.contentHuggingHorizontalPriority = 249
        
        contentView.addSubview(typeLabel)
        typeLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(Constants.CourseType.edgeInsets)
        }
        
        contentView.addSubview(nameCourseLabel)
        nameCourseLabel.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(Constants.Name.edgeInsets.top)
            $0.leading.equalToSuperview().inset(Constants.Name.edgeInsets)
            $0.trailing.equalTo(stack.snp.leading).offset(-Constants.Name.edgeInsets.right)
        }
        nameCourseLabel.snp.contentHuggingHorizontalPriority = 248
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameCourseLabel.snp.bottom).offset(Constants.Description.edgeInsets.top)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.Description.edgeInsets)
        }
        
        likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? CourseDescriptionModel else {
            return
        }
        let typeTitle = model.courseType.title?.lowercased() ?? String()
        let isMineTitle = model.isMine ? "| мой курс" : String()
        
        typeLabel.text = "\(typeTitle) \(isMineTitle)"
        nameCourseLabel.text = model.name
        descriptionLabel.text = model.description
        likesLabel.text = "\(model.likes)"
        likeButton.isSelected = model.isFavorite
        self.model = model
        
        layoutIfNeeded()
    }
    
    @objc
    private func likeTapped() {
        likeButton.isSelected.toggle()
        model?.likeTapped?(likeButton.isSelected)
    }
    
}
