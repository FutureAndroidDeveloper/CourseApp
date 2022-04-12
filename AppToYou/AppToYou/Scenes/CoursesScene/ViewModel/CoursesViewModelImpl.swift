import Foundation
import XCoordinator


class CoursesViewModelImpl: CoursesViewModel, CoursesViewModelInput, CoursesViewModelOutput {
    private struct Constants {
        static let startPage = 1
        static let pageSize = 5
    }
    
    var models: [CourseCellModel] = []
    var filterModel = CoursesFilterModel()
    
    var isLoading: Observable<Bool> = Observable(false)
    var coursesBatch: Observable<[CourseResponse]> = Observable([])
    var clearCourses: Observable<Void> = Observable(())
    
    private let coursesRouter: UnownedRouter<CoursesRoute>
    private let coursesService = CourseManager(deviceIdentifierService: DeviceIdentifierService())
    private let searchModel = SearchCourseModel(page: Constants.startPage, pageSize: Constants.pageSize)
    private var activeFitlerTab: CourseSearchSelection
    
    private var loadedCoursesSlice: [CourseResponse] = []
    private var filteredModels: [CourseCellModel] = []
    private var courseImagesLoader: CourseImagesLoader?
    

    init(coursesRouter: UnownedRouter<CoursesRoute>) {
        self.coursesRouter = coursesRouter
        activeFitlerTab = .all
        filterModel.delegate = self
    }
    
    func searchTextDidChange(_ text: String) {
        searchModel.changeSearch(name: text)
        refresh()
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
    
    func previewCourse(_ course: CourseResponse) {
        coursesRouter.trigger(.preview(course: course))
    }
    
    func refresh() {
        clear()
        switch activeFitlerTab {
        case .all:
            search()
        case .my:
            membershipFilterDidActive()
        }
    }
    
    func loadMore() {
        guard !isLoading.value, !loadedCoursesSlice.isEmpty else {
            return
        }
        switch activeFitlerTab {
        case .all:
            searchModel.nextPage()
            search()
        case .my:
            break
        }
    }
    
    private func search() {
        isLoading.value = true
        coursesService.search(model: searchModel, completion: handleLoadedCourses(_:))
    }
    
    private func handleLoadedCourses(_ result: Result<[CourseResponse], NetworkResponseError>) {
        switch result {
        case .success(let coursesBatch):
            switch activeFitlerTab {
            case .all:
                loadedCoursesSlice = coursesBatch
            case .my:
                if searchModel.name.isEmpty {
                    loadedCoursesSlice = coursesBatch
                } else {
                    loadedCoursesSlice = coursesBatch.filter { $0.name.contains(searchModel.name) }
                }
            }
        case .failure:
            loadedCoursesSlice = []
        }
        isLoading.value = false
        prepareCourses()
    }
    
    private func prepareCourses() {
        models += loadedCoursesSlice.map { CourseCellModel(course: $0) }
        coursesBatch.value = loadedCoursesSlice
    }
    
    private func clear() {
        courseImagesLoader = CourseImagesLoader()
        searchModel.reset(page: Constants.startPage, pageSize: Constants.pageSize)
        
        models.removeAll()
        loadedCoursesSlice.removeAll()
        clearCourses.value = Void()
    }
}


extension CoursesViewModelImpl: CourseFilterDelegate {
    func categorySelected(_ category: ATYCourseCategory) {
        searchModel.add(category: category)
        refresh()
    }
    
    func categoryDeselected(_ category: ATYCourseCategory) {
        if searchModel.remove(category: category) {
            refresh()
        }
    }
    
    func allUserCoursesSelected() {
        clear()
        coursesService.allUserCourses(completion: handleLoadedCourses(_:))
    }
    
    func adminCoursesSelected() {
        guard let adminId = UserSession.shared.getUser()?.id else {
            clear()
            return
        }
        clear()
        coursesService.adminList(id: adminId, completion: handleLoadedCourses(_:))
    }
    
    func membershipCoursesSelected() {
        clear()
        coursesService.listWithStatus(.MEMBER, completion: handleLoadedCourses(_:))
    }
    
    func requestCoursesSelected() {
        clear()
        coursesService.listWithStatus(.REQUEST, completion: handleLoadedCourses(_:))
    }
    
    func coursesFilterDidActive() {
        activeFitlerTab = .all
        refresh()
    }
    
    func membershipFilterDidActive() {
        guard let selectedFilter = filterModel.activeFilters.first(where: { $0.isSelected }) else {
            return
        }
        activeFitlerTab = .my
        selectedFilter.isSelected = true
    }
}
