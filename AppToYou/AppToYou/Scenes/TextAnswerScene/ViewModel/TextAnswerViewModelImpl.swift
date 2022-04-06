import Foundation
import XCoordinator


class TextAnswerViewModelImlp: TextAnswerViewModel, TextAnswerViewModelInput, TextAnswerViewModelOutput {
    
    var title: Observable<String?> = Observable(nil)
    var answerModel: Observable<TextAnswerModel?> = Observable(nil)
    
    private let router: UnownedRouter<TextAnswerRoute>
    private let task: Task
    private let result: RealmTaskResult
    private let database: Database = RealmDatabase()
    
    init(task: Task, result: RealmTaskResult, router: UnownedRouter<TextAnswerRoute>) {
        self.task = task
        self.result = result
        self.router = router
        configureAnswerModel()
    }
    
    private func configureAnswerModel() {
        guard let length = Int(task.taskAttribute ?? String()) else {
            return
        }
        let answerModel = TextAnswerModel(
            length: length, name: task.taskName,
            description: task.taskDescription, answer: result.result
        )
        self.answerModel.value = answerModel
        self.title.value = task.taskName
    }
    
    func saveDidTapped() {
        guard let model = answerModel.value else {
            print("cant get answer from model")
            return
        }
        let userAnswer = model.userAnswer
        var isCompleted: Bool
        var progress: TaskProgress
        
        if let answer = userAnswer, answer.count >= model.length {
            isCompleted = true
            progress = .done
        } else if let answer = userAnswer, answer.count < model.length {
            isCompleted = false
            progress = .inProgress
        } else {
            isCompleted = false
            progress = .notStarted
        }
        
        database.update(result: result, value: userAnswer, isCompleted: isCompleted)
        database.update(result: result, progress: progress)
        router.trigger(.done)
    }
}
