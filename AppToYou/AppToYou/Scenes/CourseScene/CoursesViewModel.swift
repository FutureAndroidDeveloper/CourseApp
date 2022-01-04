import UIKit
import XCoordinator


protocol CoursesViewModelInput: AnyObject {
    func createDidTapped()
    func openCourse(_ course: CourseResponse)
    func refresh()
    
    func loadMore()
}

protocol CoursesViewModelOutput: AnyObject {
    var isLoading: Bool { get }
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
    
    private struct Constants {
        static let startPage = 1
        static let pageSize = 5
    }
    
    var courses: Observable<[CourseResponse]> = Observable([])
    var isLoading: Bool = false
    
    private let coursesRouter: UnownedRouter<CoursesRoute>
    private let searchModel: SearchCourseModel
    private let coursesService = CourseManager(deviceIdentifierService: DeviceIdentifierService())
    
    private var coursesSlice: [CourseResponse] = []
    

    init(coursesRouter: UnownedRouter<CoursesRoute>) {
        self.coursesRouter = coursesRouter
        self.searchModel = SearchCourseModel(page: Constants.startPage, pageSize: Constants.pageSize)
    }
    
    func createDidTapped() {
        coursesRouter.trigger(.createEdit(course: nil))
    }
    
    func openCourse(_ course: CourseResponse) {
        coursesRouter.trigger(.openCourse(course: course))
    }
    
    func refresh() {
//        searchModel.reset(page: Constants.startPage, pageSize: Constants.pageSize)
//        courses.value = []
        search()
    }
    
    func loadMore() {
        guard !isLoading, !coursesSlice.isEmpty else {
            return
        }
        searchModel.nextPage()
        search()
    }
    
    private func prepareCourses() {
        courses.value.append(contentsOf: coursesSlice)
        isLoading = false
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
    
    private func search() {
        isLoading = true
        coursesService.search(model: searchModel) { [weak self] result in
            switch result {
            case .success(let courses):
                self?.coursesSlice = courses
                self?.prepareCourses()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

