import Foundation
import XCoordinator

protocol AddPhotoViewModelInput {
    func avatarPath(_ path: String?)
}

protocol AddPhotoViewModelOutput {
    
}



protocol AddPhotoViewModel {
    var input: AddPhotoViewModelInput { get }
    var output: AddPhotoViewModelOutput { get }
}

extension AddPhotoViewModel where Self: AddPhotoViewModelInput & AddPhotoViewModelOutput {
    var input: AddPhotoViewModelInput { return self }
    var output: AddPhotoViewModelOutput { return self }
}


class AddPhotoViewModelImpl: AddPhotoViewModel, AddPhotoViewModelInput, AddPhotoViewModelOutput {

    private let router: UnownedRouter<RegistrationRoute>

    init(router: UnownedRouter<RegistrationRoute>) {
        self.router = router
    }

    
    func avatarPath(_ path: String?) {
        //validation
        
        router.trigger(.avatar(path: path))
    }
    
}
