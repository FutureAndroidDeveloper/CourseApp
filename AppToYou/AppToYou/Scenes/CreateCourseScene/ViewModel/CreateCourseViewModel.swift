import UIKit
import XCoordinator


protocol CreateCourseViewModelInput {
    func photoPicked(_ image: UIImage)
    func durationTimePicked(_ time: DurationTime)
    func saveDidTapped()
}

protocol CreateCourseViewModelOutput {
    var data: Observable<[AnyObject]> { get }
    var updatedState: Observable<Void> { get }
}

protocol CreateCourseViewModel {
    var input: CreateCourseViewModelInput { get }
    var output: CreateCourseViewModelOutput { get }
}

extension CreateCourseViewModel where Self: CreateCourseViewModelInput & CreateCourseViewModelOutput {
    var input: CreateCourseViewModelInput { return self }
    var output: CreateCourseViewModelOutput { return self }
}


class CreateCourseViewModelImpl: CreateCourseViewModel, CreateCourseViewModelInput, CreateCourseViewModelOutput {

    var data: Observable<[AnyObject]> = Observable([])
    var updatedState: Observable<Void> = Observable(())
    

    private let coursesRouter: UnownedRouter<CoursesRoute>
    
    private var createCourseModel: CreateCourseModel!

    init(coursesRouter: UnownedRouter<CoursesRoute>) {
        self.coursesRouter = coursesRouter
        
        configure()
        update()
    }
    
    private func configure() {
        createCourseModel = CreateCourseModel()
        
        let name = TextFieldModel()
        createCourseModel.addName(model: name)
        
        let description = PlaceholderTextViewModel(value: nil, placeholder: "Опишите цели или преимущества вашего курса")
        createCourseModel.addDescriptionHandler(model: description)
        
        createCourseModel.addPhotoHandler()
        
        createCourseModel.addCategoryHandler()
        
        createCourseModel.addTypeHandler()
        
        createCourseModel.addPayHandler()
        
        createCourseModel.addDuration()
        
        createCourseModel.addChatModel()
        
        createCourseModel.addRemoveHandler()
    }
    
    /**
     Обновление структуры таблицы.
     
     Приводит к вызову tableView.reload()
     */
    func update() {
        data.value = createCourseModel.prepare()
    }
    
    /**
     Обновление внутри ячеек.
     
     Приводит к вызову tableView.beginUpdates()
     */
    func updateState() {
        updatedState.value = ()
    }
    
    func photoPicked(_ image: UIImage) {
        
    }
    
    func durationTimePicked(_ time: DurationTime) {
        
    }
    
    func saveDidTapped() {
        
    }
    
}
