import XCoordinator
import FittedSheets


enum BottomSheetRoute: Route {
    case close
}


class BottomSheetCoordinator: ViewCoordinator<BottomSheetRoute>, FlowEndHandlerDelegate {
    private let config: BottomSheetConfiguration
    
    init(content: Presentable, config: BottomSheetConfiguration = .init()) {
        self.config = config

        let options = SheetOptions(
            pullBarHeight: config.pullBarHeight,
            useFullScreenMode: false,
            shrinkPresentingViewController: false
        )
        let sheetController = SheetViewController(controller: content.viewController, sizes: [.intrinsic], options: options)
        
        super.init(rootViewController: sheetController)
        configureSheet(sheetController)
        addChild(content)
    }
    
    override func prepareTransition(for route: BottomSheetRoute) -> ViewTransition {
        switch route {
        case .close:
            return .dismiss()
        }
    }
    
    private func configureSheet(_ sheetController: SheetViewController) {
        sheetController.allowPullingPastMaxHeight = false
        sheetController.minimumSpaceAbovePullBar = config.maxTopOffset
        sheetController.cornerRadius = config.cornerRadius
        sheetController.pullBarBackgroundColor = R.color.backgroundTextFieldsColor()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        sheetController.blurEffect = blurEffect
        sheetController.blurVisualEffectView = blurEffectView
        sheetController.hasBlurBackground = true
        
        sheetController.shouldDismiss = { [weak self] _ in
            self?.trigger(.close)
            return false
        }
    }
    
    func flowDidEnd() {
        trigger(.close)
    }
    
}
