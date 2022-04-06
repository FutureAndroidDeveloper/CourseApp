import UIKit


class TextAnswerViewController: UIViewController, BindableType {
    private struct Constants {
        static let saveInsets = UIEdgeInsets(top: 0, left: 20, bottom: 13, right: 20)
        static let saveButtonHeight: CGFloat = 45
        static let saveCornerRaius: CGFloat = 22.5
    }
    
    var viewModel: TextAnswerViewModel!
    
    private let answerView = TextAnswerView()
    private let contentContainer = TopBottomBlocksContainerView()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(R.color.backgroundTextFieldsColor(), for: .normal)
        button.setTitle(R.string.localizable.save(), for: .normal)
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        button.layer.cornerRadius = Constants.saveCornerRaius
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundAppColor()
        configure()
    }
    
    private func configure() {
        contentContainer.scrollView.alwaysBounceVertical = false
        contentContainer.scrollView.contentInsetAdjustmentBehavior = .never
        contentContainer.addTop(content: answerView)
        contentContainer.addBottom(content: saveButton, insets: Constants.saveInsets)
        
        view.addSubview(contentContainer)
        contentContainer.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        saveButton.snp.makeConstraints {
            $0.height.equalTo(Constants.saveButtonHeight)
        }
    }
    
    func bindViewModel() {
        viewModel.output.answerModel.bind { [weak self] model in
            guard let model = model else {
                return
            }
            self?.answerView.configure(with: model)
        }
        
        viewModel.output.title.bind { [weak self] title in
            self?.title = title
        }
    }
    
    @objc
    private func saveTapped() {
        viewModel.input.saveDidTapped()
    }
}
