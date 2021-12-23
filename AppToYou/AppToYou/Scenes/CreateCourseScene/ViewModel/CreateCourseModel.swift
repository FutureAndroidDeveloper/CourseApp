import Foundation


class CreateCourseModel {
    var nameModel: TaskNameModel!
    var descriptionModel: DescriptionModel!
    var photoModel: SelectPhotoModel!
    var categoryModel: CourseCategoryModel!
    var typeModel: CourseTypeModel!
    var payModel: PayForCourseModel?
    var durationModel: CourseDurationCellModel!
    var chatModel: CourseChatModel!
    var removeModel: DeleteCourseModel?
    
    // Name
    func addName(model: TextFieldModel) {
        nameModel = TaskNameModel(fieldModel: model)
    }
    
    func addDescriptionHandler(model: PlaceholderTextViewModel) {
        descriptionModel = DescriptionModel(fieldModel: model)
    }
    
    func addPhotoHandler() {
        photoModel = SelectPhotoModel(photoImage: nil)
    }
    
    func addCategoryHandler() {
        let categories = ATYCourseCategory.allCases
        categoryModel = CourseCategoryModel(categories: categories)
    }
    
    func addTypeHandler() {
        typeModel = CourseTypeModel(value: .PUBLIC, courseTypePicked: { type in
            print(type)
        })
    }
    
    func addPayHandler() {
        let payFieldModel = NaturalNumberFieldModel()
        payModel = PayForCourseModel(model: payFieldModel)
    }
    
    func addDuration() {
        let infin = TitledCheckBoxModel(title: "Бесконечная длительность курса", isSelected: false)
        let duration = TaskDurationModel(hourModel: TimeBlockModelFactory.getHourModel(),
                                         minModel: TimeBlockModelFactory.getMinModel(),
                                         secModel: TimeBlockModelFactory.getSecModel())
        
        let timer: () -> Void = {
            print("TIMER")
        }
        
        durationModel = CourseDurationCellModel(isInfiniteModel: infin,
                                                durationModel: duration,
                                                timerCallback: timer)
    }
    
    func addChatModel() {
        let model = TextFieldModel(value: String(), placeholder: "вставьте ссылку")
        chatModel = CourseChatModel(fieldModel: model)
    }
    
    func addRemoveHandler() {
        removeModel = DeleteCourseModel(deleteHandler: {
            print("REMOVE")
        })
    }
    
    func prepare() -> [AnyObject] {
        let fields: [AnyObject?] = [nameModel , descriptionModel, photoModel, categoryModel,
                                    typeModel, payModel, durationModel, chatModel, removeModel]
        
        return fields.compactMap { $0 }
    }
    
}
