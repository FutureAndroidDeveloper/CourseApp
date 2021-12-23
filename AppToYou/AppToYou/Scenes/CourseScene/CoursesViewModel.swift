import UIKit
import XCoordinator


protocol CoursesViewModelInput {
    func createDidTapped()
}

protocol CoursesViewModelOutput {
}

protocol CoursesViewModel {
    var input: CoursesViewModelInput { get }
    var output: CoursesViewModelOutput { get }
}

extension CoursesViewModel where Self: CoursesViewModelInput & CoursesViewModelOutput {
    var input: CoursesViewModelInput { return self }
    var output: CoursesViewModelOutput { return self }
}


class CoursesViewModelImpl: CoursesViewModel, CoursesViewModelInput, CoursesViewModelOutput {

    private let coursesRouter: UnownedRouter<CoursesRoute>
    

    init(coursesRouter: UnownedRouter<CoursesRoute>) {
        self.coursesRouter = coursesRouter
    }
    
    func createDidTapped() {
        coursesRouter.trigger(.create)
    }
    
}

