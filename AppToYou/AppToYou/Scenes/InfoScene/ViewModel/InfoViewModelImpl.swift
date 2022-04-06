import Foundation
import XCoordinator
import UIKit


class InfoViewModelImpl: InfoViewModel, InfoViewModelInput, InfoViewModelOutput, InfoModelDataSourse, InfoModelDelegate {
        
    var sections: Observable<[TableViewSection]> = Observable([])
    var updatedState: Observable<Void> = Observable(Void())
    
    private let infoRouter: UnownedRouter<UserInfoRoute>
    private let constructor: InfoModelConstructor
    private let notification: UserInfoNotification
    
    init(notification: UserInfoNotification, constructor: InfoModelConstructor, infoRouter: UnownedRouter<UserInfoRoute>) {
        self.notification = notification
        self.constructor = constructor
        self.infoRouter = infoRouter
        
        loadFields()
    }
    
    private func loadFields() {
        constructor.setDataSource(dataSource: self)
        constructor.setDelegate(delegate: self)
        constructor.construct()
        update()
    }
    
    func update() {
        let models = constructor.getModels()
        let section = TableViewSection(models: models)
        sections.value = [section]
    }
    
    func updateState() {
        updatedState.value = ()
    }
    
    func getTitleModel() -> InfoTitleModel {
        let title = notification.title
        let icon = notification.icon
        return InfoTitleModel(title: title, icon: icon, notificationType: notification)
    }
    
    func getInfoImage() -> UIImage? {
        return R.image.infoSanctionPayment()
    }
    
    func getDescription() -> String? {
        return notification.descriptionText
    }
    
    func getSanctionTimerForTask() -> Int {
        if case .paySanction(let task) = notification {
            return task.identifier.id ?? .zero
        } else {
            return .zero
        }
    }
    
    func getDoneTitle() -> String? {
        return notification.doneTitle
    }
    
    func doneTapped() {
        infoRouter.trigger(.done)
    }
    
    func payTapped() {
        infoRouter.trigger(.pay)
    }
    
    func laterTapped() {
        infoRouter.trigger(.payLater)
    }
    
}
