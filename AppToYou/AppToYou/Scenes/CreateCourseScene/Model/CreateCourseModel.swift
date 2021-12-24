import UIKit


/**
 Моделей полей создания/редактирования курса.
 */
class CreateCourseModel {
    var nameModel: TaskNameModel!
    var descriptionModel: DescriptionModel!
    var photoModel: SelectPhotoModel!
    var categoryModel: CourseCategoryModel!
    var typeModel: CourseTypeModel!
    
    private var prevPayModel: PayForCourseModel?
    var payModel: PayForCourseModel?
    
    var durationModel: CourseDurationCellModel!
    var chatModel: CourseChatModel!
    var removeModel: DeleteCourseModel?
    
    
    func addName(model: TextFieldModel) {
        nameModel = TaskNameModel(fieldModel: model)
    }
    
    func addDescription(model: PlaceholderTextViewModel) {
        descriptionModel = DescriptionModel(fieldModel: model)
    }
    
    func addPhoto(_ photo: UIImage?, _ placeholder: UIImage?, _ photoHandler: @escaping () -> Void) {
        photoModel = SelectPhotoModel(photoImage: photo, defaultImage: placeholder, pickImage: photoHandler)
    }
    
    func addCategories(model: CourseCategoryModel) {
        categoryModel = model
    }
    
    func addTypeModel(_ value: ATYCourseType, _ handler: @escaping (ATYCourseType) -> Void) {
        typeModel = CourseTypeModel(value: value, courseTypePicked: handler)
    }
    
    func addPay(model: NaturalNumberFieldModel) {
        payModel = prevPayModel ?? PayForCourseModel(model: model)
    }
    
    func removePayModel() {
        guard let model = payModel else {
            return
        }
        prevPayModel = model.copy() as? PayForCourseModel
        payModel = nil
    }
    
    func addDuration(_ duration: TaskDurationModel, _ infinite: TitledCheckBoxModel, _ timerHandler: @escaping () -> Void) {
        durationModel = CourseDurationCellModel(isInfiniteModel: infinite,
                                                durationModel: duration,
                                                timerCallback: timerHandler)
    }
    
    func addChat(model: TextFieldModel) {
        chatModel = CourseChatModel(fieldModel: model)
    }
    
    func addRemove(handler: @escaping () -> Void) {
        removeModel = DeleteCourseModel(deleteHandler: handler)
    }
    
    func prepare() -> [AnyObject] {
        let fields: [AnyObject?] = [
            nameModel , descriptionModel, photoModel,
            categoryModel, typeModel, payModel,
            durationModel, chatModel, removeModel,
        ]
        
        return fields.compactMap { $0 }
    }
    
}
