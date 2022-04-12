import UIKit


class CourseConstructor {
    private struct Constants {
        static let defaultCourseImage = R.image.exampleAboutCourse()
    }
    
    private let model: CourseConstructorModel
    private let isEditable: Bool
    
    private weak var delegate: CourseConstructorDelegate?
    private weak var dataSourse: CourseConstructorDataSourse?
    
    private var loadedOwnerImage: UIImage?
    private var loadedCourseImage: UIImage?
    private var loadedMembersInfo: [UserAvatarInfo] = []
    
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
        let courseImage = loadedCourseImage ?? Constants.defaultCourseImage
        let ownerImage = isEditable ? nil : loadedOwnerImage
        model.headerModel = CourseHeaderModel(
            membersCount: dataSource.getUsersAmount(),
            duration: dataSource.getDuration(),
            isEditable: isEditable,
            price: dataSource.getPrice(),
            coursePhoto: courseImage,
            adminPhoto: ownerImage,
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
        let amount = dataSource.getUsersAmount()
        let plusUsers = amount - loadedMembersInfo.count
        let membersModel = CourseMembersViewModel(members: loadedMembersInfo, amountMembers: plusUsers)
        
        model.membersModel = CourseMembersModel(model: membersModel, membersTapped: { [weak self] in
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
    
    func handleTasksResponse(_ tasks: [CourseTaskResponse]) {
        model.hintModel?.stopLoading?()
        
        if tasks.isEmpty {
            model.hintModel?.setHint?("На курсе пока нет задач")
        } else {
            let models = tasks.compactMap { task -> CourseTaskCellModel? in
                var model: CourseTaskCellModel?
                let isSelected = dataSourse?.isTaskAddedToUser(task) ?? false
                
                if task.taskType == .RITUAL {
                    model = CourseCounterTaskCellModel(courseTaskResponse: task, isSelected: isSelected)
                } else {
                    model = CourseTaskCellModel(courseTaskResponse: task, isSelected: isSelected)
                }
                model?.selectionDidChange = { [weak self] changedTask, isOn in
                    if isOn {
                        self?.delegate?.add(task: changedTask)
                    } else {
                        self?.delegate?.remove(task: changedTask)
                    }
                }
                return model
            }
            model.tasksModel = models
            model.hintModel = nil
        }
    }
    
    func tasksLoadingError() {
        model.hintModel?.stopLoading?()
        model.hintModel?.setHint?("Не удалось загузить задачи курса")
    }
    
    func setOwnerImage(_ image: UIImage?) {
        loadedOwnerImage = image
    }
    
    func setCourseImage(_ image: UIImage?) {
        loadedCourseImage = image
    }
    
    func setMembersInfo(_ info: [UserAvatarInfo]) {
        loadedMembersInfo = info
    }
}
