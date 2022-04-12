import Foundation


class MembersPageModel {
    private(set) var courseId: Int
    private(set) var page: Int
    private(set) var pageSize: Int
    
    init(courseId: Int, page: Int, pageSize: Int) {
        self.courseId = courseId
        self.page = page
        self.pageSize = pageSize
    }
    
    func reset(page: Int, pageSize: Int) {
        self.page = page
        self.pageSize = pageSize
    }
    
    func nextPage() {
        page += 1
    }
}

