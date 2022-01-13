import UIKit


class ATYEnterNameViewController: UIViewController, BindableType {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: -80, right: 20)
        static let nameContainerInsets = UIEdgeInsets(top: 0, left: 20, bottom: 32, right: 20)
        static let doneInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        struct Name {
            static let textInsets = UIEdgeInsets(top: 11, left: 16, bottom: 13, right: 16)
        }
    }
    
    var viewModel: EnterNameViewModel!
    
    private let nameTextField = FieldFactory.shared.getTextField()
    private var nameContainer = ValidatableViewWrapper()

    private let titleLabel = LabelFactory.createHeaderLabel(title: R.string.localizable.letSGetAcquainted())
    private let doneButton = ButtonFactory.getStandartButton(title: R.string.localizable.completeRegistration())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundAppColor()
        configure()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        doneButton.layer.cornerRadius = doneButton.bounds.height / 2
    }

    private func configure() {
        let nameContainer = createContainer(for: nameTextField, insets: Constants.nameContainerInsets)
        self.nameContainer = ValidatableViewWrapper(content: nameContainer)
        view.addSubview(self.nameContainer)
        self.nameContainer.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.center.equalToSuperview()
        }
        
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.nameContainer.snp.top).offset(Constants.titleInsets.bottom)
            $0.leading.trailing.equalToSuperview().inset(Constants.titleInsets)
        }
        
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints {
            $0.top.equalTo(self.nameContainer.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(Constants.doneInsets)
        }
        
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
    }
    
    private func createContainer(for view: UIView, insets: UIEdgeInsets) -> UIView {
        let container = UIView()
        container.addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(insets)
        }
        return container
    }

    func bindViewModel() {
        let nameModel = viewModel.output.nameModel
        let contentModel = FieldContentModel(fieldModel: nameModel.fieldModel, insets: Constants.Name.textInsets)
        nameTextField.configure(with: FieldModel(content: contentModel))
        nameModel.errorNotification = { [weak self] error in
            self?.nameTextField.bind(error: error)
            self?.nameContainer.bind(error: error)
        }
    }
    
    @objc
    private func doneButtonAction() {
        viewModel.input.endRegistration()
    }
    
}
