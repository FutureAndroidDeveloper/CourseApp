import Foundation


class CourseDescriptionModel {
    let courseType: ATYCourseType
    let name: String
    let description: String
    let likes: Int
    let isMine: Bool
    let isFavorite: Bool
    private(set) var likeTapped: ((Bool) -> Void)?
    
    init(courseType: ATYCourseType, name: String, description: String, likes: Int,
         isFavorite: Bool, isMine: Bool, likeTapped: @escaping (Bool) -> Void) {
        
        self.courseType = courseType
        self.name = name
        self.description = description
        self.likes = likes
        self.isFavorite = isFavorite
        self.isMine = isMine
        self.likeTapped = likeTapped
    }
    
}
