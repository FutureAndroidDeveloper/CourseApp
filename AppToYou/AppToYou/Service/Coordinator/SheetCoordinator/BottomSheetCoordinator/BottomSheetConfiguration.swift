import UIKit


struct BottomSheetConfiguration {
    private struct Constants {
        static let pullBarHeight: CGFloat = 32
        static let cornerRadius: CGFloat = 20
    }
    
    
    let maxTopOffset: CGFloat
    let pullBarHeight: CGFloat
    let cornerRadius: CGFloat
    
    init(maxTopOffset: CGFloat? = nil, pullBarHeight: CGFloat? = nil, cornerRadius: CGFloat? = nil) {
        self.maxTopOffset = maxTopOffset ?? UIScreen.main.bounds.height / 3
        self.pullBarHeight = pullBarHeight ?? Constants.pullBarHeight
        self.cornerRadius = cornerRadius ?? Constants.pullBarHeight
    }
    
}
