import UIKit

/**
 Реализация TextView с placeholder.
 */
class PlaceholderTextView: UITextView, UITextViewDelegate {
    
    private struct Constants {
        static let cornerRaduis: CGFloat = 20
        static let textInsets = UIEdgeInsets(top: 11, left: 16, bottom: 13, right: 16)
        static let scrollInsets = UIEdgeInsets(top: 11, left: 0, bottom: 13, right: 8)
        
        struct Text {
            static let textColor = R.color.titleTextColor()
            static let placeholderColor = R.color.textSecondaryColor()
        }
    }
        
    private var model: PlaceholderTextViewModel?

    init() {
        super.init(frame: .zero, textContainer: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = Constants.cornerRaduis
    }
    
    private func setup() {
        delegate = self
        font = UIFont.systemFont(ofSize: 15)
        textContainerInset = Constants.textInsets
        scrollIndicatorInsets = Constants.scrollInsets
    }
    
    func configure(with model: PlaceholderTextViewModel) {
        self.model = model
        text = model.text
        let range = NSRange(location: .zero, length: text.count)
        _ = delegate?.textView?(self, shouldChangeTextIn: range, replacementText: text)
    }
    
    func getModel() -> PlaceholderTextViewModel? {
        guard let model = model else {
            return nil
        }
        if model.placeholder != text {
            model.update(text: text)
        }
        return model
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText: String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // Для пустого текста установить placeholder
        if updatedText.isEmpty {
            textView.text = model?.placeholder
            textView.textColor = Constants.Text.placeholderColor
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
        // обновление текста, если сейчас установлен placeholder
        else if textView.textColor == Constants.Text.placeholderColor && !text.isEmpty {
            textView.textColor = Constants.Text.textColor
            textView.text = text
        } else {
            return true
        }
        
        return false
    }
    
    /**
     Запретить пользователю изменять положение курсора, когда отображается placeholder.
     */
    func textViewDidChangeSelection(_ textView: UITextView) {
        if textView.text == model?.placeholder {
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
    }
    
}
