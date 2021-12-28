import UIKit


class MembersView: UIView {
    private struct Constants {
        static let memberSize = CGSize(width: 50, height: 50)
        static let betweenOffset: CGFloat = -20
        static let borderWidth: CGFloat = 2
    }
    
    private var model: CourseMembersViewModel?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        drowParticipants()
    }

    func configure(with model: CourseMembersViewModel) {
        self.model = model
        
        setNeedsLayout()
        layoutIfNeeded()
    }

    private func drowParticipants() {
        guard let model = model else {
            return
        }
        let membersCount = model.members.count + 1
        var xOffset: CGFloat = 0

        for index in 0..<membersCount {
            var memberLayer = CALayer()
            xOffset = CGFloat(index) * (Constants.memberSize.width + Constants.betweenOffset)
            
            if index == model.members.count {
                let amountMembersLayer = LCTextLayer()
                amountMembersLayer.string = "+ \(model.amountMembers.formattedWithSeparator)"
                
                let font = UIFont.systemFont(ofSize: 12)
                amountMembersLayer.font = font
                amountMembersLayer.fontSize = font.pointSize
                
                amountMembersLayer.alignmentMode = .center
                amountMembersLayer.rasterizationScale = UIScreen.main.scale
                amountMembersLayer.contentsScale = UIScreen.main.scale
                amountMembersLayer.backgroundColor = R.color.textColorSecondary()?.cgColor
                amountMembersLayer.foregroundColor = R.color.backgroundTextFieldsColor()?.cgColor
                memberLayer = amountMembersLayer
                
            } else {
                memberLayer = CALayer()
                memberLayer.contents = model.members[index].avatar?.cgImage
                memberLayer.contentsGravity = .resize
                memberLayer.magnificationFilter = .linear
            }
            
            memberLayer.frame = CGRect(origin: CGPoint(x: xOffset, y: 0), size: Constants.memberSize)
            memberLayer.masksToBounds = true
            memberLayer.cornerRadius = Constants.memberSize.height / 2
            memberLayer.borderWidth = Constants.borderWidth
            memberLayer.borderColor = R.color.backgroundAppColor()?.cgColor

            layer.insertSublayer(memberLayer, at: UInt32(index))
        }
    }
    
}
