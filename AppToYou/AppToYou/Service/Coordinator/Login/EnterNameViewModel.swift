import Foundation
import XCoordinator

protocol EnterNameViewModelInput {
    func nameEntered(name: String)
}

protocol EnterNameViewModelOutput {
    
}



protocol EnterNameViewModel {
    var input: EnterNameViewModelInput { get }
    var output: EnterNameViewModelOutput { get }
}

extension EnterNameViewModel where Self: EnterNameViewModelInput & EnterNameViewModelOutput {
    var input: EnterNameViewModelInput { return self }
    var output: EnterNameViewModelOutput { return self }
}


class EnterNameViewModelImpl: EnterNameViewModel, EnterNameViewModelInput, EnterNameViewModelOutput {

    private let router: UnownedRouter<RegistrationRoute>

    init(router: UnownedRouter<RegistrationRoute>) {
        self.router = router
    }
    
    func nameEntered(name: String) {
        // validation?
        
        router.trigger(.name(name))
    }
    
}
