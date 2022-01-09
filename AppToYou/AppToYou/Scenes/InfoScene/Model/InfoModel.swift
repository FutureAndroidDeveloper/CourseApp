import UIKit


class InfoModel {
    var titleModel: InfoTitleModel!
    var imageModel: InfoImageModel?
    var timerModel: InfoSanctionTimerModel?
    var descriptionModel: InfoDescriptionModel!
    var doneModel: InfoDoneModel!
    var additionalActionModel: InfoPayLaterModel?
    
    func addTitle(model: InfoTitleModel) {
        titleModel = model
    }
    
    func addImage(_ image: UIImage?) {
        imageModel = InfoImageModel(image: image)
    }
    
    func addTimer(for taskId: Int) {
        timerModel = InfoSanctionTimerModel(taskId: taskId)
    }
    
    func addDescription(text: String?, notificationType: UserInfoNotification) {
        descriptionModel = InfoDescriptionModel(text: text, notificationType: notificationType)
    }
    
    func addDone(title: String?, _ action: @escaping () -> Void) {
        doneModel = InfoDoneModel(title: title, action: action)
    }
    
    func addPayLater(action: @escaping () -> Void) {
        additionalActionModel = InfoPayLaterModel(action: action)
    }
    
    func prepare() -> [AnyObject] {
        let models: [AnyObject?] = [titleModel, imageModel, timerModel, descriptionModel, doneModel, additionalActionModel]
        return models.compactMap { $0 }
    }
    
}
