import Foundation
import UIKit

class CourseHeaderModel {
    let membersCount: Int
    let duration: Duration?
    let isEditable: Bool
    let price: Price?
    let adminPhoto: UIImage?
    let coursePhoto: UIImage?
    private(set) var backTapped: () -> Void
    private(set) var editTapped: () -> Void
    
    init(membersCount: Int, duration: Duration?, isEditable: Bool, price: Price?, coursePhoto: UIImage?,
         adminPhoto: UIImage?, editTapped: @escaping () -> Void, backTapped: @escaping () -> Void) {
        
        self.membersCount = membersCount
        self.duration = duration
        self.price = price
        self.adminPhoto = adminPhoto
        self.coursePhoto = coursePhoto
        self.isEditable = isEditable
        self.backTapped = backTapped
        self.editTapped = editTapped
    }
}


struct Price {
    let coin: Int
    let diamond: Int
}
