import Foundation


class AdminEditCourseTaskModel: EditCourseTaskModel {
    
    override func prepare() -> [AnyObject] {
        var result: [AnyObject?] = [lockHeaderModel, courseNameModel, nameModel]
        
        let tail: [AnyObject?] = [
            frequencyModel, weekdayModel, courseTaskDurationModel,
            sanctionModel, minSanctionModel,
        ]
        
        result.append(contentsOf: getAdditionalModels())
        result.append(contentsOf: tail.compactMap({ $0 }))
        return result.compactMap { $0 }
    }
    
}
