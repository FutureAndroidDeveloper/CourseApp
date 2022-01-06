import Foundation


class UserEditCourseTaskModel: EditCourseTaskModel {
    
    override func prepare() -> [AnyObject] {
        var result: [AnyObject?] = [courseNameModel, nameModel]
        
        let tail: [AnyObject?] = [
            frequencyModel, weekdayModel, periodModel,
            notificationModel, sanctionModel,
        ]
        
        result.append(contentsOf: getAdditionalModels())
        result.append(contentsOf: tail.compactMap({ $0 }))
        return result.compactMap { $0 }
    }
    
}
