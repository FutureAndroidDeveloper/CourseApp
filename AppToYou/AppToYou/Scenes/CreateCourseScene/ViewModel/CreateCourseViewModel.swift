import UIKit
import XCoordinator


protocol CreateCourseViewModelInput: PhotoDelegate, TimePickerDelegate {
    func doneDidTapped()
}

protocol CreateCourseViewModelOutput: AnyObject {
    var data: Observable<[AnyObject]> { get }
    var updatedState: Observable<Void> { get }
    
    var title: String? { get }
    var doneButtonTitle: String? { get }
}

protocol CreateCourseViewModel: AnyObject {
    var input: CreateCourseViewModelInput { get }
    var output: CreateCourseViewModelOutput { get }
}

extension CreateCourseViewModel where Self: CreateCourseViewModelInput & CreateCourseViewModelOutput {
    var input: CreateCourseViewModelInput { return self }
    var output: CreateCourseViewModelOutput { return self }
}


class CreateCourseViewModelImpl: CreateCourseViewModel, CreateCourseViewModelInput, CreateCourseViewModelOutput {
    var title: String?
    var doneButtonTitle: String?
    
    var data: Observable<[AnyObject]> = Observable([])
    var updatedState: Observable<Void> = Observable(())
    
    private let coursesRouter: UnownedRouter<CoursesRoute>
    private var mode: CreateCourseMode
    
    private var courseModel: ATYCourse?
    
//    private var courseImage: UIImage?
    
    private lazy var courseConstructor: CreateCourseConstructor = {
        let constructor = CreateCourseConstructor(mode: self.mode, delegate: self)
        return constructor
    }()

    private let courseService = CourseManager(deviceIdentifierService: DeviceIdentifierService())
    private let validator = CourseValidator()
    
    private var courseRequest: CourseCreateRequest?
    
    init(mode: CreateCourseMode, coursesRouter: UnownedRouter<CoursesRoute>) {
        self.mode = mode
        self.coursesRouter = coursesRouter
        
        self.mode = .editing
        
        configure()
        updateStructure()
    }
    
    private func configure() {
        title = mode.title
        doneButtonTitle = mode.doneTitle
        
        switch mode {
        case .creation:
            courseModel = nil
        case .editing:
            courseModel = ATYCourse()
        }
    }
    
    func photoPicked(_ image: UIImage?, with path: String?) {
        courseConstructor.createCourseModel.photoModel.update(image: image, path: path)
        updateStructure()
    }

    func durationPicked(_ duration: DurationTime) {
        courseConstructor.createCourseModel.durationModel.durationModel.update(durationTime: duration)
        updateStructure()
    }

    func doneDidTapped() {
        let model = courseConstructor.createCourseModel
        validator.validate(model: model)
        
        if !validator.hasError {
            prepare(model: model)
            save()
        }
    }
    
    func prepare(model: CreateCourseModel) {
        let name = model.nameModel.fieldModel.value
        let description = model.descriptionModel.fieldModel.value ?? String()
        let categories = model.categoryModel.selectedCategories
        let courseType = model.typeModel.value
        let privacy = false
        
        courseRequest = CourseCreateRequest(name: name, description: description, categories: categories,
                                            courseType: courseType, duration: model.durationModel, privacyEnabled: privacy)
        
        let chatLink = model.chatModel.fieldModel.value
        courseRequest?.chatPath = chatLink.isEmpty ? nil : chatLink
        courseRequest?.picPath = model.photoModel.path
        courseRequest?.price = model.payModel?.model.value
    }
    
    func save() {
        guard let course = courseRequest else {
            return
        }
        
        courseService.create(course: course) { result in
            switch result {
            case .success(let newCourse):
                print(newCourse)

            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension CreateCourseViewModelImpl: CreateCourseDelegate {
    /**
     Обновление структуры таблицы.
     Приводит к вызову tableView.reload()
     */
    func updateStructure() {
        data.value = courseConstructor.getModels()
    }
    
    /**
     Обновление внутри ячеек.
     Приводит к вызову tableView.beginUpdates()
     */
    func updateValue() {
        updatedState.value = ()
    }
    
    func showTimePicker(pickerType: TimePickerType) {
        coursesRouter.trigger(.durationPicker)
    }
    
    func showPhotoPicker() {
        let image = courseConstructor.createCourseModel.photoModel.photoImage
        coursesRouter.trigger(.photo(image: image))
    }
    
    func removeCourse() {
        print("remove")
        //
    }
    
    func getNameModel() -> TextFieldModel {
        let name = courseModel?.courseName ?? String()
        
        // TODO: - модель может принимать nil, как PlaceholderTextViewModel
        return TextFieldModel(value: name, placeholder: "Например, ментальное здоровье")
    }
    
    func getDescriptionModel() -> PlaceholderTextViewModel {
        let desccription = courseModel?.courseDescription
        return PlaceholderTextViewModel(value: desccription, placeholder: "Опишите цели или преимущества вашего курса")
    }
    
    func getPhoto() -> (photo: UIImage?, placeholder: UIImage?) {
        // TODO: - в модели нет свойства картинки,  но есть Path
        let defaultImage = R.image.coursePhotoExample()
//        guard let courseImage = courseConstructor.createCourseModel.photoModel.photoImage else {
//            return (nil, defaultImage)
//        }
        
        return (nil, defaultImage)
    }
    
    func getCategoriesModel() -> CourseCategoryModel {
        let selected = courseModel?.courseCategory ?? []
        let categories = ATYCourseCategory.allCases
        return CourseCategoryModel(categories: categories, selectedCategories: selected)
    }
    
    func getCourseType() -> ATYCourseType {
        return courseModel?.courseType ?? .PRIVATE
    }
    
    func getPaymentModel() -> NaturalNumberFieldModel {
        // TODO: - нет поля в модели
        return NaturalNumberFieldModel()
    }
    
    func getDurationModel() -> (TaskDurationModel, TitledCheckBoxModel) {
        // TODO: - в моделе другой тип
        let duration = TaskDurationModel(
            hourModel: .init(unit: "год"),
            minModel: .init(unit: "мес"),
            secModel: .init(unit: "дн")
        )
        
        let isInfinite = courseModel?.limited == .LIMITED ? false : true
                
        let infinite = TitledCheckBoxModel(
            title: "Бесконечная длительность курса",
            isSelected: isInfinite
        )
        return (duration, infinite)
    }
    
    func getChatModel() -> TextFieldModel {
        let link = courseModel?.chatPath ?? String()
        
        return TextFieldModel(value: link, placeholder: "Вставьте ссылку")
    }
    
    
}
