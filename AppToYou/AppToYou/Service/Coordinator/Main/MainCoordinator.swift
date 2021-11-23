import UIKit
import XCoordinator

enum MainRoute: Route {
    case tasks
    case courses
    case profile
}


class MainCoordinator: TabBarCoordinator<MainRoute> {
    
    private let tasksRouter: StrongRouter<TasksRoute>
    private let coursesRouter: StrongRouter<CoursesRoute>
    private let profileRouter: StrongRouter<ProfileRoute>
//    private let appCoordinator: UnownedRouter<AppRoute>
    
    convenience init(appRouter: UnownedRouter<AppRoute>) {
        let taskCoordinator = TasksCoordinator()
        let coursesCoordinator = CoursesCoordinator()
        let profileCoordinator = ProfileCoordinator(appRouter: appRouter)

        self.init(tasksRouter: taskCoordinator.strongRouter,
                  coursesRouter: coursesCoordinator.strongRouter,
                  profileRouter: profileCoordinator.strongRouter)
    }

    init(tasksRouter: StrongRouter<TasksRoute>,
         coursesRouter: StrongRouter<CoursesRoute>,
         profileRouter: StrongRouter<ProfileRoute>) {
        
        self.tasksRouter = tasksRouter
        self.coursesRouter = coursesRouter
        self.profileRouter = profileRouter
        super.init(tabs: [tasksRouter, coursesRouter, profileRouter], select: tasksRouter)
        configureContainer()
    }
    
    override func prepareTransition(for route: MainRoute) -> TabBarTransition {
        switch route {
        case .tasks:
            return .select(tasksRouter)
            
        case .courses:
            return .select(coursesRouter)
            
        case .profile:
            return .select(profileRouter)
        }
    }
    
    private func configureContainer() {
        rootViewController.view.backgroundColor = R.color.backgroundAppColor()
        rootViewController.tabBar.barTintColor = R.color.backgroundTextFieldsColor()
        rootViewController.tabBar.isTranslucent = false
        rootViewController.tabBar.tintColor = R.color.textColorSecondary()
    }
    
}
