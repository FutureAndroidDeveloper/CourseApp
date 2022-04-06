import Foundation
import XCoordinator
import UIKit


protocol AddPhotoViewModelInput: PhotoDelegate {
    func photoAction(with photo: UIImage?)
    func savePhoto(_ image: UIImage?)
    func pickPhotoLater()
}

protocol AddPhotoViewModelOutput {
    var photo: Observable<UIImage?> { get set }
    var pickPhotoButtonTitle: Observable<String?> { get set }
    var saveIsActive: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get }
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
    
    private struct Constants {
        static let loadPhotoTitle = R.string.localizable.yourDownloadPhoto()
        static let loadAnotherTitle = R.string.localizable.uploadAnotherPhoto()
        static let defaultPhoto = R.image.photoSmile()
    }

    var photo: Observable<UIImage?> = Observable(nil)
    var pickPhotoButtonTitle: Observable<String?> = Observable(nil)
    var saveIsActive: Observable<Bool> = Observable(false)
    var isLoading: Observable<Bool> = Observable(false)
    
    private let router: UnownedRouter<RegistrationRoute>
    private let userService = UserManager(deviceIdentifierService: DeviceIdentifierService())
    
    private var userUpdateRequest: UserUpdateRequest

    init(router: UnownedRouter<RegistrationRoute>) {
        self.router = router
        
        let name = UserSession.shared.getUser()?.name ?? String()
        userUpdateRequest = UserUpdateRequest(name: name, avatarPath: nil)
        photoPicked(nil, with: nil)
    }
    
    func photoPicked(_ image: UIImage?, with path: String?) {
        let pickPhotoTitle = image == nil ? Constants.loadPhotoTitle : Constants.loadAnotherTitle
        pickPhotoButtonTitle.value = pickPhotoTitle
        saveIsActive.value = image != nil
        photo.value = image ?? Constants.defaultPhoto
        
        userUpdateRequest.avatarPath = path
    }
    
    func photoAction(with photo: UIImage?) {
        let photoToEdit = photo == Constants.defaultPhoto ? nil : photo
        router.trigger(.photo(photoToEdit))
    }
    
    func savePhoto(_ image: UIImage?) {
        guard let data = image?.jpegData(compressionQuality: 1), let path = userUpdateRequest.avatarPath else {
            return
        }

        isLoading.value = true
        let photo = MediaPhoto(data: data, fileName: path)
        userService.updateUser(userUpdateRequest, photo: photo) { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success:
                UserSession.shared.logout()
                self?.router.trigger(.didRegister)
            case .failure(let error):
                self?.displayError(message: error.localizedDescription)
            }
        }
    }
    
    private func displayError(message: String) {
        router.trigger(.error(message: message))
    }
    
    func pickPhotoLater() {
        router.trigger(.didRegister)
    }
    
}
