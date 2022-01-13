import Foundation


class DownloadImageOperation: AsyncResultOperation<Data, NetworkResponseError> {
    
    private let path: String
    private let attachmentService = AttachmentManager(deviceIdentifierService: DeviceIdentifierService())

    init(path: String) {
        self.path = path
    }

    override func main() {
        attachmentService.download(path: path) { [weak self] result in
            guard self?.isCancelled == false else {
                return
            }
            switch result {
            case .success(let imageData):
                self?.finish(with: .success(imageData))
            case .failure(let error):
                self?.finish(with: .failure(error))
            }
        }
    }

    override func cancel() {
        attachmentService.cancelTask()
        cancel(with: .canceled)
    }
    
}
