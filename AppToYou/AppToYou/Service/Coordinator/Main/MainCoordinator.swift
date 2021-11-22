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
        taskCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 0)

        let coursesCoordinator = CoursesCoordinator()
        coursesCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        let profileCoordinator = ProfileCoordinator(appRouter: appRouter)
        profileCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 2)

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
        super.init(tabs: [tasksRouter, coursesRouter, profileRouter], select: profileRouter)
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
    
}
