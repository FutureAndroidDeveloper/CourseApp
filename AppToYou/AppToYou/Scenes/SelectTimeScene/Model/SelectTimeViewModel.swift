import Foundation
import XCoordinator

protocol SelectTimeViewModelInput {
    func timePicked(hour: String, min: String)
}

protocol SelectTimeViewModelOutput {
    
}



protocol SelectTimeViewModel {
    var input: SelectTimeViewModelInput { get }
    var output: SelectTimeViewModelOutput { get }
}

extension SelectTimeViewModel where Self: SelectTimeViewModelInput & SelectTimeViewModelOutput {
    var input: SelectTimeViewModelInput { return self }
    var output: SelectTimeViewModelOutput { return self }
}


class SelectTimeViewModelImpl: SelectTimeViewModel, SelectTimeViewModelInput, SelectTimeViewModelOutput {

    private let router: UnownedRouter<TasksRoute>

    init(router: UnownedRouter<TasksRoute>) {
        self.router = router
    }
    
    func timePicked(hour: String, min: String) {
        let notificationTime = NotificationTime(hour: hour, min: min)
        router.trigger(.timePicked(notificationTime))
    }
    
}
