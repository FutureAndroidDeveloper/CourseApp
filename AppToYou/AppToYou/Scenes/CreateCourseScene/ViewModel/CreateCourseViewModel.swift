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
    
    private lazy var courseConstructor: CreateCourseConstructor = {
        let constructor = CreateCourseConstructor(mode: self.courseMode, delegate: self)
        return constructor
    }()
    
    private let coursesRouter: UnownedRouter<CoursesRoute>
    private let courseService = CourseManager(deviceIdentifierService: DeviceIdentifierService())
    private let validator = CourseValidator()
    
    private var courseMode: CreateCourseMode
    private var course: CourseResponse?
    private var courseRequest: CourseCreateRequest?
    
    
    init(course: CourseResponse?, coursesRouter: UnownedRouter<CoursesRoute>) {
        self.coursesRouter = coursesRouter
        self.course = course
        self.courseMode = course == nil ? .creation: .editing
        
        title = courseMode.title
        doneButtonTitle = courseMode.doneTitle
        
        updateStructure()
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
        
        courseService.create(course: course) { [weak self] result in
            switch result {
            case .success(let newCourse):
                self?.coursesRouter.trigger(.courseCreated(course: newCourse))

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
        let name = course?.name ?? String()
        
        // TODO: - модель может принимать nil, как PlaceholderTextViewModel
        return TextFieldModel(value: name, placeholder: "Например, ментальное здоровье")
    }
    
    func getDescriptionModel() -> PlaceholderTextViewModel {
        return PlaceholderTextViewModel(value: course?.description, placeholder: "Опишите цели или преимущества вашего курса")
    }
    
    func getPhoto() -> (photo: UIImage?, placeholder: UIImage?) {
        let defaultImage = R.image.coursePhotoExample()
        // TODO - загрузка картинок
        let image = course?.picPath
        
        return (nil, defaultImage)
    }
    
    func getCategoriesModel() -> CourseCategoryModel {
        let categories = ATYCourseCategory.allCases.filter { $0 != .EMPTY }
        let selected = [course?.courseCategory1, course?.courseCategory2, course?.courseCategory3]
            .compactMap { $0 }
            .filter { $0 != .EMPTY }
        
        return CourseCategoryModel(categories: categories, selectedCategories: selected)
    }
    
    func getCourseType() -> ATYCourseType {
        return course?.courseType ?? .PRIVATE
    }
    
    func getPaymentModel() -> NaturalNumberFieldModel {
        let cost = course?.coinPrice ?? .zero
        return NaturalNumberFieldModel(value: cost)
    }
    
    func getDurationModel() -> (TaskDurationModel, TitledCheckBoxModel) {
        let year = course?.duration?.year ?? 0
        let month = course?.duration?.month ?? 0
        let day = course?.duration?.day ?? 0
        let duration = TaskDurationModel(
            hourModel: .init(value: "\(year)", unit: "год"),
            minModel: .init(value: "\(month)", unit: "мес"),
            secModel: .init(value: "\(day)", unit: "дн")
        )
        
        let durationType = course?.durationType ?? .unlimited
                
        let infinite = TitledCheckBoxModel(
            title: "Бесконечная длительность курса",
            isSelected: durationType == .unlimited
        )
        return (duration, infinite)
    }
    
    func getChatModel() -> TextFieldModel {
        let link = course?.chatPath ?? String()
        return TextFieldModel(value: link, placeholder: "Вставьте ссылку")
    }
    
    
}
