import Foundation


class CourseConstructor {
    
    private let model: CourseConstructorModel
    private let isEditable: Bool
    
    private weak var delegate: CourseConstructorDelegate?
    private weak var dataSourse: CourseConstructorDataSourse?
    
    
    init(isEditable: Bool, delegate: CourseConstructorDelegate, dataSourse: CourseConstructorDataSourse) {
        self.isEditable = isEditable
        self.delegate = delegate
        self.dataSourse = dataSourse
        model = CourseConstructorModel()
    }
    
    func getModels() -> [AnyObject] {
        guard let dataSourse = dataSourse else {
            return []
        }
        
        if isEditable {
            addRequests(dataSourse)
            addCreateTask()
        } else {
            addReport(dataSourse)
        }
        // общие поля
        addCourseHeader(dataSourse)
        addDescription(dataSourse)
        addChat()
        addTasksHeader(dataSourse)
        addTasks(dataSourse)
        addMembers(dataSourse)
        addShare()
        
        // вставка моделей задач.
        let mirror = Mirror(reflecting: model)
        var models = mirror.children
            .compactMap { $0.value }
            .compactMap { $0 as? AnyObject }
        
        guard
            let index = models.firstIndex(where: { $0 is [AnyObject] }),
            let tasks = models.remove(at: index) as? [AnyObject]
        else {
            return []
        }
        
        models.insert(contentsOf: tasks, at: index)
        return model.getConfiguredModels()
    }
    
    private func addCourseHeader(_ dataSource: CourseConstructorDataSourse) {
        model.headerModel = CourseHeaderModel(
            membersCount: dataSource.getUsersAmount(), duration: dataSource.getDuration(), isEditable: isEditable,
            price: dataSource.getPrice(), adminPhoto: dataSource.getAdminPhoto(),
            editTapped: { [weak self] in
                self?.delegate?.edit()
            }, backTapped: { [weak self] in
                self?.delegate?.back()
            })
    }
    
    private func addDescription(_ dataSource: CourseConstructorDataSourse) {
        model.descriptionModel = CourseDescriptionModel(
            courseType: dataSource.getType(), name: dataSource.getName(), description: dataSource.getDescription(),
            likes: dataSource.getLikes(), isFavorite: true, isMine: isEditable,
            likeTapped: { [weak self] isFavorite in
                self?.delegate?.like(isFavorite)
            })
    }
    
    private func addRequests(_ dataSource: CourseConstructorDataSourse) {
        model.requestsModel = CourseAdminMembersModel(newNotifications: dataSource.getRequests(), membersTapped: { [weak self] in
            self?.delegate?.openRequests()
        })
    }
    
    private func addChat() {
        model.chatModel = JoinCourseChatModel(joinTapped: { [weak self] in
            self?.delegate?.openChat()
        })
    }
    
    private func addTasksHeader(_ dataSource: CourseConstructorDataSourse) {
        let tasksInfo = dataSource.getPickedTasks()
        model.tasksHeaderModel = CourseTasksModel(addedCount: tasksInfo.picked, amont: tasksInfo.amount, addAllTapped: { [weak self] in
            self?.delegate?.addTasks()
        })
    }
    
    private func addTasks(_ dataSource: CourseConstructorDataSourse) {
        model.tasksModel = dataSource.getTasks()
            .map { TaskCellModel(model: $0, task: .course) }
    }
    
    private func addCreateTask() {
        model.createTaskModel = CreateCourseTaskCellModel(createTapped: { [weak self] in
            self?.delegate?.createTask()
        })
    }
    
    private func addMembers(_ dataSource: CourseConstructorDataSourse) {
        model.membersModel = CourseMembersModel(model: dataSource.getMembers(), membersTapped: { [weak self] in
            self?.delegate?.openMemebrs()
        })
    }
    
    private func addShare() {
        model.shareModel = ShareCourseModel(shareTapped: { [weak self] in
            self?.delegate?.share()
        })
    }
    
    private func addReport(_ dataSource: CourseConstructorDataSourse) {
        model.reportModel = ReportCourseModel(reportTapped: { [weak self] in
            self?.delegate?.report()
        })
    }
    
}
