import UIKit


/**
 Представление прогресса задачи через отображение текста.
 */
class LabelProgressView: UIView, ProgressView {
    private let progressLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(progressLabel)
        progressLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        progressLabel.textAlignment = .center
        progressLabel.textColor = .white
        progressLabel.font = UIFont.systemFont(ofSize: 25)
    }
    
    func configure(with model: TaskProgressModel) {
        guard let count = model.getProgressValue() as? String else {
            print("cant get count value for label progress view")
            return
        }
        progressLabel.text = count
    }
    
}
