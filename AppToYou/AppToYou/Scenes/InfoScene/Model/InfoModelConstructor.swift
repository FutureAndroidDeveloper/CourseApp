import Foundation
import UIKit


protocol InfoModelDataSourse: AnyObject {
    func getTitleModel() -> InfoTitleModel
    func getInfoImage() -> UIImage?
    func getDescription() -> String?
    func getSanctionTimerForTask() -> Int
    func getDoneTitle() -> String?
}


protocol InfoModelDelegate: AnyObject {
    func doneTapped()
    func payTapped()
    func laterTapped()
}


class InfoModelConstructor {
    let infoModel: InfoModel
    
    private let notification: UserInfoNotification
    private weak var dataSource: InfoModelDataSourse?
    private weak var delegate: InfoModelDelegate?
    
    init(notification: UserInfoNotification, infoModel: InfoModel) {
        self.notification = notification
        self.infoModel = infoModel
    }
    
    deinit {
        infoModel.timerModel?.stopTimer()
    }
    
    func setDataSource(dataSource: InfoModelDataSourse?) {
        self.dataSource = dataSource
    }
    
    func setDelegate(delegate: InfoModelDelegate?) {
        self.delegate = delegate
    }
    
    func construct() {
        guard let dataSource = dataSource else {
            return
        }
        
        switch notification {
        case .courseTaskAdded, .allCourseTasksAdded:
            break
        case .failureSanction:
            addImage(dataSource)
        case .paySanction:
            addTimer(dataSource)
            addPayLaterModel()
        }
        addTitleModel(dataSource)
        addDescription(dataSource)
        addDoneModel(dataSource)
    }
    
    func getModels() -> [AnyObject] {
        return infoModel.prepare()
    }
    
    private func addTitleModel(_ dataProvider: InfoModelDataSourse) {
        let model = dataProvider.getTitleModel()
        infoModel.addTitle(model: model)
    }
    
    private func addImage(_ dataProvider: InfoModelDataSourse) {
        let image = dataProvider.getInfoImage()
        infoModel.addImage(image)
    }
    
    private func addTimer(_ dataProvider: InfoModelDataSourse) {
        let taskId = dataProvider.getSanctionTimerForTask()
        infoModel.addTimer(for: taskId)
    }
    
    private func addDescription(_ dataProvider: InfoModelDataSourse) {
        let description = dataProvider.getDescription()
        infoModel.addDescription(text: description, notificationType: notification)
    }
    
    private func addDoneModel(_ dataProvider: InfoModelDataSourse) {
        let title = dataProvider.getDoneTitle()
        infoModel.addDone(title: title) { [weak self] in
            self?.delegate?.doneTapped()
        }
    }
    
    private func addPayLaterModel() {
        infoModel.addPayLater { [weak self] in
            self?.delegate?.laterTapped()
        }
    }
}
