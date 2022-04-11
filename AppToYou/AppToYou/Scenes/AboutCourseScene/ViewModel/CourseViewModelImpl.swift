import Foundation
import XCoordinator
import UIKit


class CourseViewModelImpl: CourseViewModel, CourseViewModelInput, CourseViewModelOutput {
    
    var sections: Observable<[TableViewSection]> = Observable([])
    var updatedState: Observable<Void> = Observable(())
    
    private let courseRouter: UnownedRouter<CourseRoute>
    private let adapter = TaskAdapter()
    private var course: CourseResponse
    
    private var courseTasks: [CourseTaskResponse] = []
    
    private let courseService = CourseManager(deviceIdentifierService: DeviceIdentifierService())
    
    private lazy var constructor: CourseConstructor = {
        let isEditable = course.admin.id == UserSession.shared.getUser()?.id
        return CourseConstructor(isEditable: isEditable, delegate: self, dataSourse: self)
    }()
    
    
    init(course: CourseResponse, coursesRouter: UnownedRouter<CourseRoute>) {
        self.course = course
        self.courseRouter = coursesRouter
        updateStructure()
        loadCourseInfo()
    }
    
    func refresh() {
        loadCourseInfo()
    }
    
    func editCourseTask(index: Int) {
        guard let firstTaskIndex = constructor.getModels().firstIndex(where: { $0 is TaskCellModel }) else {
            return
        }
        
        let taskIndex = index - firstTaskIndex
        let task = courseTasks[taskIndex]
        courseRouter.trigger(.editTask(task: task))
    }
    
    private func loadCourseInfo() {
        courseService.getFullCourseInfo(id: course.id) { [weak self] result in
            switch result {
            case .success(let model):
                self?.course = model.course
                self?.courseTasks = model.tasks
                let tasks = model.tasks.compactMap { self?.adapter.convert(courseTaskResponse: $0) }
                self?.constructor.handleTasksResponse(tasks)
                
            case .failure(let error):
                print(error)
                self?.constructor.tasksLoadingError()
            }
            
            self?.updateStructure()
            self?.updateState()
        }
    }
    
    func updateState() {
        updatedState.value = ()
    }
    
    func updateStructure() {
        let models = constructor.getModels()
        let section = TableViewSection(models: models)
        sections.value = [section]
    }
}


extension CourseViewModelImpl: CourseConstructorDataSourse, CourseConstructorDelegate {
    
    func isTaskAddedToUser(_ task: Task) -> Bool {
        return false
    }
    
    
    func getUsersAmount() -> Int {
        return course.usersAmount
    }
    
    func getDuration() -> Duration? {
        return course.duration
    }
    
    func getPrice() -> Price {
        return Price(coin: course.coinPrice, diamond: course.diamondPrice)
    }
    
    func getAdminPhoto() -> UIImage? {
        let path = course.admin.avatarPath
        return nil
    }
    
    func getName() -> String {
        return course.name
    }
    
    func getDescription() -> String {
        return course.description
    }
    
    func getType() -> ATYCourseType {
        return course.courseType
    }
    
    func getLikes() -> Int {
        return course.likes
    }
    
    func getRequests() -> Int {
        // TODO: - получение запросов
        return 1337
    }
    
    func getPickedTasks() -> (amount: Int, picked: Int) {
        // TODO: - получение выбранных задач курса и задач курса
        return (17, 9)
    }
    
    func getMembers() -> CourseMembersViewModel {
        // TODO: - получение участников
        let members = Array<UIImage?>(repeating: R.image.exampleCourse(), count: 5)
            .map { CourseMember(avatar: $0) }
        
        return CourseMembersViewModel(members: members, amountMembers: course.usersAmount)
    }
    
    func back() {
        courseRouter.trigger(.back)
    }
    
    func edit() {
        courseRouter.trigger(.edit)
    }
    
    func like(_ isFavorite: Bool) {
        print(isFavorite)
    }
    
    func openRequests() {
        courseRouter.trigger(.requests)
    }
    
    func createTask() {
        courseRouter.trigger(.createTask)
    }
    
    func openChat() {
        courseRouter.trigger(.chat)
    }
    
    func addTasks() {
        courseRouter.trigger(.addAll)
    }
    
    func add(task: CourseTaskResponse) {
        courseRouter.trigger(.add(task: task))
    }
    
    func remove(task: CourseTaskResponse) {
        // TODO: -
    }
    
    func openMemebrs() {
        courseRouter.trigger(.members)
    }
    
    func share() {
        courseRouter.trigger(.share)
    }
    
    func report() {
        courseRouter.trigger(.report)
    }
    
    
}
