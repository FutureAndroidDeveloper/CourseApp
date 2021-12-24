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
    
    private var courseImage: UIImage?
    
    private lazy var courseConstructor: CreateCourseConstructor = {
        let constructor = CreateCourseConstructor(mode: self.mode, delegate: self)
        return constructor
    }()

    
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
        print(image)
        print(path)
        courseImage = image
        courseConstructor.createCourseModel.photoModel.update(image: image)
        updateStructure()
    }

    func durationPicked(_ duration: DurationTime) {
        courseConstructor.createCourseModel.durationModel.durationModel.update(durationTime: duration)
        updateStructure()
    }

    func doneDidTapped() {
        print("Done")
        // validate + после валидации при необходимости обновить модель ячеек с указанием ошибок
        // при успешной валидации отправить запрос на сервер
        // при успешном выполнении запроса, сохранить в бд
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
        coursesRouter.trigger(.photo(image: courseImage))
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
        return (courseImage, R.image.coursePhotoExample())
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
