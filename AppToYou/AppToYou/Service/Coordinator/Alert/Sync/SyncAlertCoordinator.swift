import UIKit
import XCoordinator
import JGProgressHUD


enum SyncRoute: Route {
    
}


class SyncAlertCoordinator: ViewCoordinator<SyncRoute> {
    
    private let hud = JGProgressHUD()
    
    init() {
        let testVc = UIViewController()
        testVc.modalPresentationStyle = .overFullScreen
        testVc.view.backgroundColor = .clear
        super.init(rootViewController: testVc)
        
        configure()
    }
    
    func loading() {
        let abc = JGProgressHUDIndeterminateIndicatorView()
        hud.indicatorView = abc
        hud.textLabel.text = "Синхронизация данных"
        hud.detailTextLabel.text = "Дождитесь обновления данных"
    }
    
    func finished() {
        let successIndicator = JGProgressHUDSuccessIndicatorView()
        successIndicator.tintColor = .white
        set(indicator: successIndicator, message: nil)
    }
    
    func error(message: String?) {
        let errorIndicator = JGProgressHUDErrorIndicatorView()
        errorIndicator.tintColor = R.color.failureColor()
        set(indicator: errorIndicator, message: message)
    }
    
    private func set(indicator: JGProgressHUDIndicatorView, message: String?) {
        UIView.animate(withDuration: 0.3) {
            self.hud.indicatorView = indicator
            self.hud.textLabel.text = message
            self.hud.detailTextLabel.text = nil
        }
    }
    
    private func configure() {
        hud.contentView.backgroundColor = .lightGray
        hud.interactionType = .blockAllTouches
        hud.show(in: rootViewController.view)
    }
    
}
