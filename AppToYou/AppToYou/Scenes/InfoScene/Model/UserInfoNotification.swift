import UIKit


/**
 Набор уведомлений пользователя, во время работы в приложении.
 */
enum UserInfoNotification {
    case courseTaskAdded
    case allCourseTasksAdded
    case failureSanction
    case paySanction(task: UserTaskResponse)
    
    var title: String? {
        switch self {
        case .courseTaskAdded:
            return "Задача добавлена!"
        case .allCourseTasksAdded:
            return "Все задачи добавлены"
        case .failureSanction:
            return "Штрафы за невыполнение"
        case .paySanction(let task):
            return "Оплатите штраф задачи «\(task.taskName)»"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .courseTaskAdded, .failureSanction, .paySanction:
            return nil
        case .allCourseTasksAdded:
            return R.image.warningImage()
        }
    }
    
    var descriptionText: String? {
        switch self {
        case .courseTaskAdded:
            return "Мы учли ваши корректировки и продублировали задачу в ваших личных задачах с пометкой «курс».\n\nВаш прогресс по задачам курса доступен участникам курса."
        case .allCourseTasksAdded:
            return "Все задачи будут добавлены с исходными параметрами.\n\nВы сможете отредактировать задачи после добавления, если редактирование этой задачи предусмотрено автором курса."
        case .failureSanction:
            return "В случае невыполнения задачи, вы должны будете оплатить штраф. Иначе ваш аккаунт будет заблокирован."
        case .paySanction:
            return "При неоплатите штрафа в течение двух суток, нам придется заблокировать ваш аккаунт."
        }
    }
    
    var doneTitle: String? {
        switch self {
        case .courseTaskAdded:
            return "Хорошо!"
        case .allCourseTasksAdded:
            return "Понятно!"
        case .failureSanction:
            return "Понятно"
        case .paySanction:
            return "Оплатить"
        }
    }
    
}
