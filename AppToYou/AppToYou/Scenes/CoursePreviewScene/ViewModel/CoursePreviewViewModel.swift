import Foundation
import XCoordinator
import UIKit


protocol CoursePreviewViewModelInput: AnyObject {
    func buttonDidTap()
}

protocol CoursePreviewViewModelOutput: AnyObject {
    var title: Observable<String?> { get }
    var sections: Observable<[TableViewSection]> { get }
    var updatedState: Observable<Void> { get }
}

protocol CoursePreviewViewModel: AnyObject {
    var input: CoursePreviewViewModelInput { get }
    var output: CoursePreviewViewModelOutput { get }
}

extension CoursePreviewViewModel where Self: CoursePreviewViewModelInput & CoursePreviewViewModelOutput {
    var input: CoursePreviewViewModelInput { return self }
    var output: CoursePreviewViewModelOutput { return self }
}


class CoursePreviewViewModellImpl: CoursePreviewViewModel, CoursePreviewViewModelInput, CoursePreviewViewModelOutput {
    var title: Observable<String?> = Observable(nil)
    var sections: Observable<[TableViewSection]> = Observable([])
    var updatedState: Observable<Void> = Observable(Void())
    
    private let router: UnownedRouter<PreviewCourseTaskRoute>
    private let coursesService = CourseManager(deviceIdentifierService: DeviceIdentifierService())
    private let attachmentService = AttachmentManager(deviceIdentifierService: DeviceIdentifierService())
    private let course: CourseResponse
    
    private lazy var constructor = CoursePreviewConstructor(courseType: course.courseType)
    
    
    init(course: CourseResponse, router: UnownedRouter<PreviewCourseTaskRoute>) {
        self.course = course
        self.router = router
        constructor.dataSourse = self
        setButtonTitle()
        update()
        loadCourseData()
    }
    
    func buttonDidTap() {
        switch course.courseType {
        case .PUBLIC: addCourse()
        case .PRIVATE: joinCourse()
        case .PAID: buyCourse()
        }
    }
    
    func update() {
        let models = constructor.getModels()
        let section = TableViewSection(models: models)
        sections.value = [section]
    }
    
    func updateState() {
        updatedState.value = ()
    }
    
    private func setButtonTitle() {
        var title: String?
        switch course.courseType {
        case .PUBLIC: title = "Добавить курс в Мои курсы"
        case .PRIVATE: title = "Подать заявку"
        case .PAID: title = "Купить курс"
        }
        self.title.value = title
    }
    
    private func loadCourseData() {
        getTasks()
        loadCourseImage()
        loadOwnerImage()
    }
    
    private func getTasks() {
        guard course.courseType != .PRIVATE else {
            return
        }
        coursesService.getTasks(for: course.id) { [weak self] result in
            switch result {
            case .success(let courseTasks):
                self?.constructor.handleTasksResponse(courseTasks)
            case .failure:
                self?.constructor.tasksLoadingError()
            }
            self?.update()
        }
    }
    
    private func loadCourseImage() {
        guard let path = course.picPath else {
            return
        }
        attachmentService.download(path: path) { [weak self] result in
            switch result {
            case .success(let data):
                self?.constructor.setCourseImage(UIImage(data: data))
            case .failure:
                break
            }
            self?.update()
            self?.updateState()
        }
    }
    
    private func loadOwnerImage() {
        guard let path = course.admin.avatarPath else {
            return
        }
        attachmentService.download(path: path) { [weak self] result in
            switch result {
            case .success(let data):
                self?.constructor.setOwnerImage(UIImage(data: data))
            case .failure:
                break
            }
            self?.update()
            self?.updateState()
        }
    }
    
    private func addCourse() {
        // TODO: - Добавление курса
        // сейчас происходит откртые курса по нажатию
        router.trigger(.open(course: course))
    }
    
    private func joinCourse() {
        // TODO: - Запрос на вступление в курс
    }
    
    private func buyCourse() {
        // TODO: - Покупка курса
        router.trigger(.showBuy(course: course))
    }
}


extension CoursePreviewViewModellImpl: CoursePreviewConstructorDatasource {
    func getCourseName() -> String {
        return course.name
    }
    
    func getCoursePrice() -> Price? {
        if course.coinPrice == 0 && course.diamondPrice == 0 {
            return nil
        } else {
            return Price(coin: course.coinPrice, diamond: course.diamondPrice)
        }
    }
    
    func getMembersCount() -> Int {
        return course.usersAmount
    }
    
    func getLikeCount() -> Int {
        return course.likes
    }
    
    func getDescription() -> String? {
        return course.description
    }
}
