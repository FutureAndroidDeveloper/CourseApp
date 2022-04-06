import Foundation


protocol TextAnswerViewModelInput: AnyObject {
    func saveDidTapped()
}

protocol TextAnswerViewModelOutput: AnyObject {
    var title: Observable<String?> { get set }
    var answerModel: Observable<TextAnswerModel?> { get set }
}

protocol TextAnswerViewModel: AnyObject {
    var input: TextAnswerViewModelInput { get }
    var output: TextAnswerViewModelOutput { get }
}

extension TextAnswerViewModel where Self: TextAnswerViewModelInput & TextAnswerViewModelOutput {
    var input: TextAnswerViewModelInput { return self }
    var output: TextAnswerViewModelOutput { return self }
}
