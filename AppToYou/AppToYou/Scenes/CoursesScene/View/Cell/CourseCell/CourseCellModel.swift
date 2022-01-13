import UIKit


class CourseCellModel {
    let course: CourseResponse
    
    private(set) var courseImage: UIImage?
    private(set) var ownerImage: UIImage?
        
    init(course: CourseResponse) {
        self.course = course
    }
    
    func updateCourseImage(_ image: UIImage?) {
        courseImage = image
    }
    
    func updateOwnerImage(_ image: UIImage?) {
        ownerImage = image
    }
    
    func getTypeIcon() -> UIImage? {
        switch course.courseType {
        case .PUBLIC:
            return R.image.rightArrowImage()?.withRenderingMode(.alwaysTemplate)
        case .PRIVATE:
            return R.image.chain()?.withRenderingMode(.alwaysTemplate)
        case .PAID:
            return R.image.walletTwoImage()?.withRenderingMode(.alwaysTemplate)
        }
    }
    
}
