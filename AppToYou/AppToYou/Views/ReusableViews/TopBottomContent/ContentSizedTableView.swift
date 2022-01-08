import UIKit


final class ContentSizedTableView: UITableView {
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        let insets = (adjustedContentInset.bottom + adjustedContentInset.top)
        let height = insets + contentSize.height
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
    
}
