import Foundation


class TextAnswerModel {
    let length: Int
    let name: String
    let description: String?
    let answer: String?
    
    // Ответ введенный пользователем
    var userAnswer: String? {
        return answerModel?.value
    }
    
    private(set) var answerModel: PlaceholderTextViewModel?
    
    init(length: Int, name: String, description: String?, answer: String?) {
        self.length = length
        self.description = description
        self.name = name
        self.answer = answer
    }
    
    func setAnswerModel(_ answerModel: PlaceholderTextViewModel) {
        self.answerModel = answerModel
    }
}
