import Foundation


/**
 Класс, отвечающий за формирование модели данных для отображения в ячейке задачи.
 */
class TaskInfoProvider {
    weak var modelDelegate: TaskCellModelDelegate?
    weak var actionDelegate: TaskActionDelegate?
    weak var progressActionDelegate: ProgressActionDelegate?
    
    private let progressProvider = TaskProgressProvider()
    private let descriptionProvider = TaskDescriptionProvider()
    private let actionProvider = TaskActionProvider()
    private let hintProvider = TaskHintProvider()
    
    
    /**
     Получить модель ячейки задачи для задачи на определнную дату.
     */
    func convert(task: Task, for date: Date) -> TaskCellModel {
        let descriptionModel = descriptionProvider.convert(task: task)
        let hintModel = hintProvider.convert(task: task)
        
        let progressModel = progressProvider.convert(task: task, for: date)
        progressModel.delegate = progressActionDelegate
        
        let actionModel = actionProvider.convert(task: task, date: date)
        actionModel?.delegate = actionDelegate
        
        
        let model = TaskCellModel(
            task: task, date: date, progressModel: progressModel,
            descriptionModel: descriptionModel, hintModel: hintModel,
            actionModel: actionModel
        )
        
        model.delegate = modelDelegate
        return model
    }
    
}
