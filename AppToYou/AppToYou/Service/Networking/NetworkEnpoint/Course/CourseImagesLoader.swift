import UIKit


/**
 Класс загрузки изображений курса (обложка и фото администратора).
 
 Позволяет выполнять загрузку параллельно с возможностью отмены выполения запросов.
 */

class CourseImagesLoader {
    private let loadQueue: OperationQueue
    private var courseImageOperations: [String : AsyncOperation]
    private var ownerImageOperations: [String : AsyncOperation]
    
    init() {
        loadQueue = OperationQueue()
        courseImageOperations = [:]
        ownerImageOperations = [:]
    }
    
    deinit {
        loadQueue.cancelAllOperations()
        courseImageOperations.removeAll()
        ownerImageOperations.removeAll()
    }
    
    func load(with model: CourseCellModel) {
        if let courseImagePath = model.course.picPath, courseImageOperations[courseImagePath] == nil {
            download(with: courseImagePath, in: &courseImageOperations) { [weak model] image in
                model?.updateCourseImage(image)
            }
        }
        
        if let ownerImagePath = model.course.admin.avatarPath, courseImageOperations[ownerImagePath] == nil {
            download(with: ownerImagePath, in: &ownerImageOperations) { [weak model] image in
                model?.updateOwnerImage(image)
            }
        }
    }
    
    func cancel(for model: CourseCellModel) {
        if let courseImagePath = model.course.picPath {
            cancel(with: courseImagePath, in: &courseImageOperations)
        }
        
        if let ownerImagePath = model.course.admin.avatarPath {
            cancel(with: ownerImagePath, in: &ownerImageOperations)
        }
    }
    
    private func download(with path: String, in operations: inout [String : AsyncOperation], _ completion: @escaping (UIImage?) -> Void) {
        let operation = DownloadImageOperation(path: path)
        operation.onResult = { result in
            switch result {
            case .success(let imageData):
                let image = UIImage(data: imageData)
                completion(image)
            case .failure(let error):
                print(error)
            }
        }
        
        operations[path] = operation
        loadQueue.addOperation(operation)
    }
    
    private func cancel(with path: String, in operations: inout [String : AsyncOperation]) {
        if let operation = operations.first(where: { $0.key == path })?.value, operation.isExecuting {
            operation.cancel()
            operations.removeValue(forKey: path)
        }
    }
    
}

