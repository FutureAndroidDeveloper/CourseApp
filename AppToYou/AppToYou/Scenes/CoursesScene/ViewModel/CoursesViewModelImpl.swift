import Foundation
import XCoordinator


class CoursesViewModelImpl: CoursesViewModel, CoursesViewModelInput, CoursesViewModelOutput {
    
    private struct Constants {
        static let startPage = 1
        static let pageSize = 5
    }
    
    var courses: Observable<[CourseResponse]> = Observable([])
    var coursesBatch: Observable<[CourseResponse]> = Observable([])
    var updatedState: Observable<Void> = Observable(())
    var isLoading: Bool = false
    
    private let coursesRouter: UnownedRouter<CoursesRoute>
    private let searchModel: SearchCourseModel
    private let coursesService = CourseManager(deviceIdentifierService: DeviceIdentifierService())
    
    private var coursesSlice: [CourseResponse] = []
    
    private var courseImagesLoader: CourseImagesLoader?
    

    init(coursesRouter: UnownedRouter<CoursesRoute>) {
        self.coursesRouter = coursesRouter
        self.searchModel = SearchCourseModel(page: Constants.startPage, pageSize: Constants.pageSize)
        courseImagesLoader = CourseImagesLoader()
    }
    
    func updateState() {
        updatedState.value = ()
    }
    
    func downloadCourseImages(for model: CourseCellModel) {
        courseImagesLoader?.load(with: model)
    }
    
    func closeCourseImagesDowloading(for model: CourseCellModel) {
        courseImagesLoader?.cancel(for: model)
    }
    
    func createDidTapped() {
        coursesRouter.trigger(.createEdit(course: nil))
    }
    
    func openCourse(_ course: CourseResponse) {
        coursesRouter.trigger(.openCourse(course: course))
    }
    
    func refresh() {
        courseImagesLoader = CourseImagesLoader()
        searchModel.reset(page: Constants.startPage, pageSize: Constants.pageSize)
//        courses.value = []
        search()
    }
    
    func loadMore() {
        print("THE new slice = \(coursesSlice.count)")
        guard !isLoading, !coursesSlice.isEmpty else {
            return
        }
        searchModel.nextPage()
        search()
    }
    
    private func prepareCourses() {
//        courses.value.append(contentsOf: coursesSlice)
        coursesBatch.value = coursesSlice
        isLoading = false
    }
    
    private func loadCourses() {
        guard let adminId = UserSession.shared.getUser()?.id else {
            return
        }
        
        coursesService.adminList(id: adminId) { [weak self] result in
            switch result {
            case .success(let courses):
                break
//                self?.courses.value = courses
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func search() {
        isLoading = true
        coursesService.search(model: searchModel) { [weak self] result in
            switch result {
            case .success(let coursesBach):
                self?.coursesSlice = coursesBach
                self?.prepareCourses()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

