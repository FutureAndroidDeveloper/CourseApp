import Foundation


class TaskInfoProvider {
    private let progressProvider = TaskProgressProvider()
    private let descriptionProvider = TaskDescriptionProvider()
    private let actionProvider = TaskActionProvider()
    private let hintProvider = TaskHintProvider()
    
    func convert(task: UserTaskResponse, for date: Date) -> NewTaskCellModel {
        let progressModel = progressProvider.convert(task: task, for: date)
        let descriptionModel = descriptionProvider.convert(task: task)
        let actionModel = actionProvider.convert(task: task)
        let hintModel = hintProvider.convert(task: task)
        return NewTaskCellModel(
            progressModel: progressModel, descriptionModel: descriptionModel,
            hintModel: hintModel, taskActionModel: actionModel
        )
    }
}
