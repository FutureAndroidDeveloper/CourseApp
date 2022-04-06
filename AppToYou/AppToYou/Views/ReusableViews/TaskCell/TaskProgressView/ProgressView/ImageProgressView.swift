import UIKit


/**
 Представление прогресса задачи через отображение иконки.
 */
class ImageProgressView: UIView, ProgressView {
    private struct Constants {
        static let iconSize = CGSize(width: 30, height: 30)
    }
    
    private let progressIcon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(progressIcon)
        progressIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Constants.iconSize)
        }
        progressIcon.contentMode = .scaleAspectFit
    }
    
    func configure(with model: TaskProgressModel) {
        guard let icon = model.getProgressValue() as? UIImage else {
            print("cant get icon value for image progress view")
            return
        }
        progressIcon.image = icon
    }
    
}
