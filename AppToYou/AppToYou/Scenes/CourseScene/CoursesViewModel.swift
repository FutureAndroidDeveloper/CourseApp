import UIKit
import XCoordinator


protocol CoursesViewModelInput: AnyObject {
    func createDidTapped()
    func openCourse(_ course: CourseResponse)
    func refresh()
}

protocol CoursesViewModelOutput: AnyObject {
    var courses: Observable<[CourseResponse]> { get set }
}

protocol CoursesViewModel: AnyObject {
    var input: CoursesViewModelInput { get }
    var output: CoursesViewModelOutput { get }
}

extension CoursesViewModel where Self: CoursesViewModelInput & CoursesViewModelOutput {
    var input: CoursesViewModelInput { return self }
    var output: CoursesViewModelOutput { return self }
}


class CoursesViewModelImpl: CoursesViewModel, CoursesViewModelInput, CoursesViewModelOutput {
    
    var courses: Observable<[CourseResponse]> = Observable([])
    
    private let coursesRouter: UnownedRouter<CoursesRoute>
    private let coursesService = CourseManager(deviceIdentifierService: DeviceIdentifierService())
    

    init(coursesRouter: UnownedRouter<CoursesRoute>) {
        self.coursesRouter = coursesRouter
        loadCourses()
    }
    
    func createDidTapped() {
        coursesRouter.trigger(.createEdit(course: nil))
    }
    
    func openCourse(_ course: CourseResponse) {
        coursesRouter.trigger(.openCourse(course: course))
    }
    
    func refresh() {
        loadCourses()
    }
    
    private func loadCourses() {
        guard let adminId = UserSession.shared.getUser()?.id else {
            return
        }
        
        coursesService.adminList(id: adminId) { [weak self] result in
            switch result {
            case .success(let courses):
                self?.courses.value = courses
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

