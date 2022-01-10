import Foundation
import XCoordinator


class ChooseTaskTypeViewModelImpl: ChooseTaskTypeViewModel, ChooseTaskTypeViewModelInput, ChooseTaskTypeViewModelOutput {
    
    var sections: Observable<[TableViewSection]> = Observable([])
    var updatedState: Observable<Void> = Observable(())
    
    weak var flowDelegate: FlowEndHandlerDelegate?

    private let router: UnownedRouter<TaskRoute>

    init(router: UnownedRouter<TaskRoute>) {
        self.router = router
        update()
    }
    
    func typePicked(_ taskType: ATYTaskType) {
        flowDelegate?.flowDidEnd()
        router.trigger(.create(taskType))
    }
    
    func update() {
        let models = ATYTaskType.allCases.map(getTaskTypeModel(_:))
        let section = TableViewSection(models: models)
        sections.value = [section]
    }
    
    func updateState() {
        updatedState.value = ()
    }
    
    private func getTaskTypeModel(_ taskType: ATYTaskType) -> ChooseTaskTypeModel {
        var icon: UIImage?
        var title: String?
        var description: String?
        
        switch taskType {
        case .CHECKBOX:
            icon = R.image.checkBox()
            title = R.string.localizable.oneTimeTaskExecution()
            description = R.string.localizable.useTheCheckbox()
        case .TEXT:
            icon = R.image.textTask()
            title = R.string.localizable.text()
            description = R.string.localizable.toCompleteTask()
        case .TIMER:
            icon = R.image.timerTask()
            title = R.string.localizable.timer()
            description = R.string.localizable.specifyTheTime()
        case .RITUAL:
            icon = R.image.countTask()
            title = R.string.localizable.countingReps()
            description = R.string.localizable.specifyTheNumber()
        }
        return ChooseTaskTypeModel(icon: icon, title: title, description: description, taskType: taskType)
    }
    
}
