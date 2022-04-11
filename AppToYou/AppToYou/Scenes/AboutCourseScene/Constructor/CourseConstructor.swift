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
        model.hintModel = CourseLoadingTasksModel()
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
        addMembers(dataSourse)
        addShare()
        
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
    
    func handleTasksResponse(_ tasks: [Task]) {
        model.hintModel?.stopLoading?()
        let descriptionProvider = TaskDescriptionProvider()
        
        if tasks.isEmpty {
            model.hintModel?.setHint?("На курсе пока нет задач")
        } else {
            let models = tasks.map { task -> CourseTaskCellModel in
                var progressModel: TaskProgressModel
                var taskModel: CourseTaskCellModel
                
                let descriptionModel = descriptionProvider.convert(task: task)
                let isSelected = dataSourse?.isTaskAddedToUser(task) ?? false
                let icon = task.taskSanction == 0 ? nil : R.image.coinImage()
                
                if task.taskType == .RITUAL {
                    progressModel = CountProgressModel(task: task, date: .distantFuture)
                    taskModel = CourseCounterTaskCellModel(
                        progressModel: progressModel,
                        descriptionModel: descriptionModel,
                        isSelected: isSelected,
                        currencyIcon: icon
                    )
                } else {
                    progressModel = IconProgressModel(task: task, date: .distantFuture)
                    taskModel = CourseTaskCellModel(
                        progressModel: progressModel,
                        descriptionModel: descriptionModel,
                        isSelected: isSelected,
                        currencyIcon: icon
                    )
                }
                taskModel.selectionDidChange = { [weak self] changedTask, isOn in
                    guard
                        let taskResponse = TaskAdapter().convert(task: changedTask, to: CourseTaskResponse.self)
                    else {
                        return
                    }
                    if isOn {
                        self?.delegate?.add(task: taskResponse)
                    } else {
                        self?.delegate?.remove(task: taskResponse)
                    }
                    
                }
                return taskModel
            }
            model.tasksModel = models
            model.hintModel = nil
        }
    }
    
    func tasksLoadingError() {
        model.hintModel?.stopLoading?()
        model.hintModel?.setHint?("Не удалось загузить задачи курса")
    }
    
}
