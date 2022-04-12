import Foundation
import XCoordinator
import UIKit


class CourseViewModelImpl: CourseViewModel, CourseViewModelInput, CourseViewModelOutput {
    var sections: Observable<[TableViewSection]> = Observable([])
    var updatedState: Observable<Void> = Observable(())
    
    private let courseRouter: UnownedRouter<CourseRoute>
    private var course: CourseResponse
    private var infoModel: CourseInfoModel?
    
    private let courseService = CourseManager(deviceIdentifierService: DeviceIdentifierService())
    private let attachmentService = AttachmentManager(deviceIdentifierService: DeviceIdentifierService())
    private let database: Database = RealmDatabase()
    private let adapter = TaskAdapter()
    private let synchronizationService: SynchronizationService
    private var taskToDelete: CourseTaskResponse?
    
    private lazy var constructor: CourseConstructor = {
        let isEditable = course.admin.id == UserSession.shared.getUser()?.id
        return CourseConstructor(isEditable: isEditable, delegate: self, dataSourse: self)
    }()
    
    
    init(course: CourseResponse, synchronizationService: SynchronizationService, coursesRouter: UnownedRouter<CourseRoute>) {
        self.course = course
        self.synchronizationService = synchronizationService
        self.courseRouter = coursesRouter
        
        updateStructure()
        loadMembers()
        refresh()
    }
    
    func refresh() {
        loadCourseInfo()
        loadCourseImage()
        loadOwnerImage()
    }
    
    func resetContainerAppearance() {
        courseRouter.trigger(.configureContainer)
    }
    
    func deleteTask() {
        guard
            let taskId = taskToDelete?.identifier.id,
            let task = database.getTasks().first(where: { $0.courseTaskId == taskId })
        else {
            return
        }
        synchronizationService.remove(task: task)
        refresh()
    }
    
    func addAllTasks() {
        courseService.addAllTasks(courseId: course.id) { [weak self] result in
            switch result {
            case .success(let tasks):
                self?.addTasks(tasks)
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func editCourseTask(_ task: CourseTaskResponse) {
        courseRouter.trigger(.editTask(task: task))
    }
    
    private func addTasks(_ responses: [UserTaskResponse]) {
        responses
            .compactMap { adapter.convert(userTaskResponse: $0) }
            .forEach { database.save(task: $0) }
        refresh()
    }
    
    private func loadCourseInfo() {
        courseService.getFullCourseInfo(id: course.id) { [weak self] result in
            switch result {
            case .success(let model):
                self?.course = model.course
                self?.infoModel = model
                self?.constructor.handleTasksResponse(model.tasks)
                
            case .failure(let error):
                print(error)
                self?.constructor.tasksLoadingError()
            }
            
            self?.updateStructure()
            self?.updateState()
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
            self?.updateStructure()
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
            self?.updateStructure()
            self?.updateState()
        }
    }
    
    private func loadMembers() {
        let page = MembersPageModel(courseId: course.id, page: 1, pageSize: 5)
        courseService.members(page: page) { [weak self] result in
            switch result {
            case .success(let members):
                let users = members.compactMap { $0.user }
                self?.loadMemberAvatars(users)
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    private func loadMemberAvatars(_ members: [UserPublicResponse]) {
        attachmentService.loadAvatars(members) { [weak self] result in
            switch result {
            case .success(let avatarInfo):
                self?.constructor.setMembersInfo(avatarInfo)
            case .failure:
                break
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
    func isTaskAddedToUser(_ task: CourseTaskResponse) -> Bool {
        database.isCourseTaskExist(task)
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
        return infoModel?.requests.count ?? .zero
    }
    
    func getPickedTasks() -> (amount: Int, picked: Int) {
        guard let tasks = infoModel?.tasks else {
            return (.zero, .zero)
        }
        let amoun = tasks.count
        let picked = tasks.filter { database.isCourseTaskExist($0) }.count
        return (amoun, picked)
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
        taskToDelete = task
        courseRouter.trigger(.confirmDeletion)
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
