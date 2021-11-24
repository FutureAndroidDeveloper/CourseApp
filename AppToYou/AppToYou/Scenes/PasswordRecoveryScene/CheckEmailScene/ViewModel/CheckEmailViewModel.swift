import Foundation
import XCoordinator

protocol CheckEmailViewModelInput {
    func checkMailTapped()
}

protocol CheckEmailViewModelOutput {
    
}



protocol CheckEmailViewModel {
    var input: CheckEmailViewModelInput { get }
    var output: CheckEmailViewModelOutput { get }
}

extension CheckEmailViewModel where Self: CheckEmailViewModelInput & CheckEmailViewModelOutput {
    var input: CheckEmailViewModelInput { return self }
    var output: CheckEmailViewModelOutput { return self }
}


class CheckEmailViewModelImpl: CheckEmailViewModel, CheckEmailViewModelInput, CheckEmailViewModelOutput {

    private let router: UnownedRouter<ResetPasswordRoute>

    init(router: UnownedRouter<ResetPasswordRoute>) {
        self.router = router
    }
    
    func checkMailTapped() {
        // validation
        
        router.trigger(.openMailClient)
    }
    
}
