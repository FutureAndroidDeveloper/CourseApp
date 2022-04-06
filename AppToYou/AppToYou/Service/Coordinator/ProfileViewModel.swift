import Foundation
import XCoordinator

protocol ProfileViewModelInput {
    func logout()
}

protocol ProfileViewModelOutput {
    
}



protocol ProfileViewModel {
    var input: ProfileViewModelInput { get }
    var output: ProfileViewModelOutput { get }
}

extension ProfileViewModel where Self: ProfileViewModelInput & ProfileViewModelOutput {
    var input: ProfileViewModelInput { return self }
    var output: ProfileViewModelOutput { return self }
}


class ProfileViewModelImpl: ProfileViewModel, ProfileViewModelInput, ProfileViewModelOutput {

    private let router: UnownedRouter<ProfileRoute>

    init(router: UnownedRouter<ProfileRoute>) {
        self.router = router
    }
    
    func logout() {
        UserSession.shared.logout()
        router.trigger(.logout)
    }
}
