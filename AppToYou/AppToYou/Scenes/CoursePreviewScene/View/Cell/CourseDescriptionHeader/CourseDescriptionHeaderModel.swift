import Foundation


class CourseDescriptionHeaderModel {
    let name: String
    let price: Price?
    let members: Int
    let likes: Int
    let courseDescription: String?
    
    init(name: String, price: Price?, members: Int, likes: Int, courseDescription: String?) {
        self.name = name
        self.price = price
        self.members = members
        self.likes = likes
        self.courseDescription = courseDescription
    }
}
