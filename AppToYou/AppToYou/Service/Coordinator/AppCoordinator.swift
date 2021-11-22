import Foundation
import XCoordinator

enum AppRoute: Route {
    case authorization
//    case registration
//    case forgotPassword
//    case enterName
//    case addPhoto
    case main
}


enum MainRoute: Route {
    case tasks
    case courses
    case profile
}

enum TasksRoute: Route {
    
}

enum CoursesRoute: Route {
    
}

enum ProfileRoute: Route {
    case profile
    case logout
}

class TasksCoordinator: NavigationCoordinator<TasksRoute> {
    
}

class CoursesCoordinator: NavigationCoordinator<CoursesRoute> {
    
}

class ProfileCoordinator: NavigationCoordinator<ProfileRoute> {
    
    private let appCoordinator: UnownedRouter<AppRoute>
    
    init(appCoordinator: UnownedRouter<AppRoute>) {
        self.appCoordinator = appCoordinator
        super.init(initialRoute: .profile)
    }
    
    override func prepareTransition(for route: ProfileRoute) -> NavigationTransition {
        let adress = Unmanaged.passUnretained(self).toOpaque()
        print("Profile = \(adress)")
        
        switch route {
        case .profile:
            let viewController = ATYProfileSignInViewController()
            let viewModel = ProfileViewModelImpl(router: unownedRouter)
            viewController.bind(to: viewModel)
            return .push(viewController)
            
        case .logout:
            print("logout")
            if let window = self.rootViewController.view.window {
                self.appCoordinator.setRoot(for: window)
            }
            return .multiple([
                .dismissToRoot(),
                .popToRoot()
            ])
//            return .trigger(.authorization, on: appCoordinator)
//            return .none()
        }
    }
    
}

class MainCoordinator: TabBarCoordinator<MainRoute> {
    
    private let tasksRouter: StrongRouter<TasksRoute>
    private let coursesRouter: StrongRouter<CoursesRoute>
    private let profileRouter: StrongRouter<ProfileRoute>
//    private let appCoordinator: UnownedRouter<AppRoute>
    
    convenience init(appCoordinator: UnownedRouter<AppRoute>) {
        let taskCoordinator = TasksCoordinator()
        taskCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 0)

        let coursesCoordinator = CoursesCoordinator()
        coursesCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        let profileCoordinator = ProfileCoordinator(appCoordinator: appCoordinator)
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
        
        let adress = Unmanaged.passUnretained(self).toOpaque()
        print("Main = \(adress)")
        
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

class AppCoordinator: NavigationCoordinator<AppRoute> {
    
    private var mainRouter: StrongRouter<MainRoute>?
    
    init() {
        super.init(initialRoute: .authorization)
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        let adress = Unmanaged.passUnretained(self).toOpaque()
        print("App = \(adress)")
        
        switch route {
        case .authorization:
            let viewController = ATYAuthorizationViewController()
            let viewModel = LoginViewModelImpl(router: unownedRouter)
            viewController.bind(to: viewModel)
            
            return .set([viewController])
//            return .push(viewController, animation: .default)
//        case .registration:
//            <#code#>
//        case .forgotPassword:
//            <#code#>
//        case .enterName:
//            <#code#>
//        case .addPhoto:
//            <#code#>
        case .main:
            mainRouter = MainCoordinator(appCoordinator: unownedRouter).strongRouter
            if let window = self.rootViewController.view.window {
                mainRouter?.setRoot(for: window)
            }
            
//            return .multiple([
//                .dismissToRoot(),
//                .popToRoot()
//            ])
            
            return .none()
//            return .present(mainCoordinator)
        }
    }
    
}
