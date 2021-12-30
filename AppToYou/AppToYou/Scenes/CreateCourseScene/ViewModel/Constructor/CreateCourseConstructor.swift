import UIKit


class CreateCourseConstructor {
    
    private weak var delegate: CreateCourseDelegate?
    private(set) var createCourseModel: CreateCourseModel
    private let mode: CreateCourseMode
    
    init(mode: CreateCourseMode, delegate: CreateCourseDelegate) {
        self.delegate = delegate
        self.mode = mode
        createCourseModel = CreateCourseModel()
        
        construct()
    }
    
    func construct() {
        guard let dataProvider = delegate else {
            return
        }
        
        addName(dataProvider)
        addDescription(dataProvider)
        addPhoto(dataProvider)
        addCategories(dataProvider)
        addTypeHandler(dataProvider)
        addDuration(dataProvider)
        addChat(dataProvider)
        
        if mode == .editing {
            addRemoveHandler()
        }
    }
    
    func getModels() -> [AnyObject] {
        return createCourseModel.prepare()
    }
    
    private func addName(_ dataProvider: CreateCourseDataSource) {
        let nameModel = dataProvider.getNameModel()
        createCourseModel.addName(model: nameModel)
    }

    private func addDescription(_ dataProvider: CreateCourseDataSource) {
        let descriptionModel = dataProvider.getDescriptionModel()
        createCourseModel.addDescription(model: descriptionModel)
    }
    
    private func addPhoto(_ dataProvider: CreateCourseDataSource) {
        let (photo, placeholder) = dataProvider.getPhoto()
        createCourseModel.addPhoto(photo, placeholder) { [weak self] in
            self?.delegate?.showPhotoPicker()
        }
    }
    
    private func addCategories(_ dataProvider: CreateCourseDataSource) {
        let categoriesModel = dataProvider.getCategoriesModel()
        createCourseModel.addCategories(model: categoriesModel)
    }
    
    private func addTypeHandler(_ dataProvider: CreateCourseDataSource) {
        let selectedType = dataProvider.getCourseType()
        
        createCourseModel.addTypeModel(selectedType) { [weak self] courseType in
            if courseType == .PAID {
                self?.addPayment(dataProvider)
            } else {
                self?.createCourseModel.removePayModel()
            }
            self?.delegate?.updateStructure()
        }
    }
    
    private func addPayment(_ dataProvider: CreateCourseDataSource) {
        let paymentModel = dataProvider.getPaymentModel()
        createCourseModel.addPay(model: paymentModel)
    }
    
    private func addDuration(_ dataProvider: CreateCourseDataSource) {
        let (duration, isInfinite) = dataProvider.getDurationModel()
        createCourseModel.addDuration(duration, isInfinite) { [weak self] in
            self?.delegate?.showTimePicker(pickerType: .course)
        }
        
    }
    
    private func addChat(_ dataProvider: CreateCourseDataSource) {
        let chatModel = dataProvider.getChatModel()
        createCourseModel.addChat(model: chatModel)
    }
    
    private func addRemoveHandler() {
        createCourseModel.addRemove { [weak self] in
            self?.delegate?.removeCourse()
        }
    }
    
}
