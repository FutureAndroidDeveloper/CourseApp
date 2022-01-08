import Foundation
import XCoordinator
import FittedSheets


enum BottomSheetRoute: Route {
    case show(_ viewController: UIViewController)
    case close
//    case timePicker(type: TimePickerType, pickerDelegate: TimePickerDelegate?)
//    case addCourseTask
}


class BottomSheetCoordinator: ViewCoordinator<BottomSheetRoute> {
    
    private struct Constants {
        static let pullBarHeight: CGFloat = 32
        static let cornerRadius: CGFloat = 20
    }
    
    private var maxTopOffset: CGFloat {
        return UIScreen.main.bounds.height / 3
    }
    
    
    init(rootViewController: RootViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    override func prepareTransition(for route: BottomSheetRoute) -> ViewTransition {
        switch route {
        case .show(let viewController):
            let options = getDedaultOptions()
            let sheetController = SheetViewController(controller: viewController, sizes: [.intrinsic], options: options)
            configureSheet(sheetController)
            return .present(sheetController)
            
        case .close:
            return .dismiss()
        }
    }
    
    private func getDedaultOptions() -> SheetOptions {
        let options = SheetOptions(pullBarHeight: Constants.pullBarHeight,
                                   useFullScreenMode: false,
                                   shrinkPresentingViewController: false)
        return options
    }
    
    private func configureSheet(_ sheetController: SheetViewController) {
        sheetController.allowPullingPastMaxHeight = false
        sheetController.minimumSpaceAbovePullBar = maxTopOffset
        sheetController.cornerRadius = Constants.cornerRadius
        sheetController.pullBarBackgroundColor = R.color.backgroundTextFieldsColor()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        sheetController.blurEffect = blurEffect
        sheetController.blurVisualEffectView = blurEffectView
        sheetController.hasBlurBackground = true
        
        sheetController.shouldDismiss = { [weak self] lol in
            self?.trigger(.close)
            return true
        }
    }
    
}
