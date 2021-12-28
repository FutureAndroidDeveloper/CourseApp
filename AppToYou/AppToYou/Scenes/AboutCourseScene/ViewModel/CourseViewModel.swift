import Foundation
import XCoordinator
import UIKit

protocol CourseViewModelInput: AnyObject {
}

protocol CourseViewModelOutput: AnyObject {
    var data: Observable<[AnyObject]> { get }
    var updatedState: Observable<Void> { get }
}

protocol CourseViewModel: AnyObject {
    var input: CourseViewModelInput { get }
    var output: CourseViewModelOutput { get }
}

extension CourseViewModel where Self: CourseViewModelInput & CourseViewModelOutput {
    var input: CourseViewModelInput { return self }
    var output: CourseViewModelOutput { return self }
}



class CourseViewModelImpl: CourseViewModel, CourseViewModelInput, CourseViewModelOutput {
    var data: Observable<[AnyObject]> = Observable([])
    var updatedState: Observable<Void> = Observable(())
    
    private let courseRouter: UnownedRouter<CoursesRoute>
    
    private let course: CourseCreateRequest
    
    
    init(course: CourseCreateRequest, coursesRouter: UnownedRouter<CoursesRoute>) {
        self.course = course
        self.courseRouter = coursesRouter
        updateStructure()
    }
    
    
    func updateStructure() {
        let duration = Duration(day: 22, month: 5, year: 1)
        let price = Price(coin: 348, diamond: 0)
        let adminPhoto = R.image.courseParticipantImage()
        
        
        let headerModel = CourseHeaderModel(
            membersCount: 1555, duration: duration, isEditable: true,
            price: price, adminPhoto: adminPhoto,
            editTapped: {
                print("Edit")
            }, backTapped: {
                print("Back")
            })
        
        let desc = "Существует тесная взаимосвязь между психикой и физическим состоянием человека. Чувство тревоги, постоянные тревоги... "
        let descriptionModel = CourseDescriptionModel(courseType: .PUBLIC,
                                                      name: "Ментальное Здоровье Но очень большое название чтобы проверить 2 строки",
                                                      description: desc, likes: 123, isFavorite: true, isMine: true) { isFavorite in
            print(isFavorite)
        }
        
        let adminMembersModel = CourseAdminMembersModel(newNotifications: 74) {
            print("Admin open members")
        }
        
        let joinChat = JoinCourseChatModel {
            print("open chat")
        }
        
        let coursesHeader = CourseTasksModel(addedCount: 9, amont: 17) {
            print("Add all")
        }
        
        var models: [AnyObject] = [headerModel, descriptionModel, adminMembersModel, joinChat, coursesHeader]
        
        let taskModels = ATYTaskType.allCases.map(getstubTaskModel(_:))
        models.append(contentsOf: taskModels)
        
        let createTaskModel = CreateCourseTaskCellModel {
            print("Create task")
        }
        models.append(createTaskModel)
        
        let imageArray = [R.image.human1(), R.image.human2(), R.image.human3(), R.image.human4(), R.image.human5()]
        
        let members = Array<UIImage?>(repeating: R.image.exampleCourse(), count: 5).map { CourseMember(avatar: $0) }
        let membersViewModel = CourseMembersViewModel(members: members, amountMembers: 1337)
        let membersModel = CourseMembersModel(model: membersViewModel) {
            print("User Memebers Tapped")
        }
        models.append(membersModel)
        
        
        let shareModel = ShareCourseModel {
            print("Share tapped")
        }
        models.append(shareModel)
        
        let reportModel = ReportCourseModel {
            print("Report")
        }
        models.append(reportModel)
        
        data.value = models
    }

    
    private func getstubTaskModel(_ type: ATYTaskType) -> TaskCellModel {
        let sanction = Int.random(in: 0...100).isMultiple(of: 2) ? true : false
        
        let data = TemporaryData.init(
            typeTask: type, courseName: nil, hasSanction: sanction, titleLabel: "Название задачи",
            firstSubtitleLabel: "Каждый день", secondSubtitleLabel: "60 раз", state: .didNotStart, date: nil)
        
        return TaskCellModel(model: data, task: .course)
    }
}
