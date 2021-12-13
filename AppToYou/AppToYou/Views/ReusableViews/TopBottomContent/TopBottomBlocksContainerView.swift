import UIKit
import SnapKit


/**
 Контайнер с верхним и нижнем блоками контента.
 
 Если высота верхнего блока меньше, чем экран, то нижний блок находится в нижней части экрана, оставляя пустое пространство между верхних и нижним блоками.
 Если верхний контент не вмещается в размер экрана, то нижний блок располагается после верхнего блока.
 */
class TopBottomBlocksContainerView: UIView {
    
    private struct Constants {
        static let betweenOffset: CGFloat = 32
    }
    
    private var contentHeightConstraint: Constraint?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let topBlock = UIView()
    private let bottomBlock = UIView()
    
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let inset = scrollView.adjustedContentInset.top - scrollView.adjustedContentInset.bottom
        contentHeightConstraint?.update(inset: inset)
        updateConstraintsIfNeeded()
    }
    
    /**
     Добавить контент в верхний блок.
     
     - parameters:
        - content: контент, добавляемый в верхний блок.
        - insets: отступы верхнего блока. Значение по умолчания - `0`  у всех сторон.
     */
    func addTop(content: UIView, insets: UIEdgeInsets = .zero) {
        update(topBlock, with: content, and: insets)
    }
    
    /**
     Добавить контент в нижний блок.
     
     - parameters:
        - content: контент, добавляемый в нижний блок.
        - insets: отступы нижнего блока. Значение по умолчания - `0`  у всех сторон.
     */
    func addBottom(content: UIView, insets: UIEdgeInsets = .zero) {
        update(bottomBlock, with: content, and: insets)
    }
    
    private func configure() {
        scrollView.alwaysBounceVertical = true
        scrollView.contentInsetAdjustmentBehavior = .always
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { [weak self] in
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            self?.contentHeightConstraint = $0.height.equalToSuperview().priority(.low).constraint
        }
        
        contentView.addSubview(topBlock)
        topBlock.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        }
        
        contentView.addSubview(bottomBlock)
        bottomBlock.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.top.greaterThanOrEqualTo(topBlock.snp.bottom).offset(Constants.betweenOffset)
        }
    }
    
    private func update(_ block: UIView, with content: UIView, and insets: UIEdgeInsets) {
        block.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        block.addSubview(content)
        content.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(insets)
        }
    }
    
}
