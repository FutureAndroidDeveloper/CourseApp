import UIKit


class CheckEmailViewController: UIViewController, BindableType {
    
    var viewModel: CheckEmailViewModel!
    
    func bindViewModel() {
        //
    }
    
    private struct Constants {
        static let buttonSize = CGSize(width: 204, height: 44)
    }
    
    let mailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.suratNotif()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let checkEmailLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font =  UIFont.Regular(size: 28)
        label.text = R.string.localizable.checkYourEmail()
        label.textColor = R.color.titleTextColor()
        return label
    }()

    let descriptionEmailLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font =  UIFont.Regular(size: 15)
        label.text = R.string.localizable.emailInstructions()
        label.textColor = R.color.textSecondaryColor()
        return label
    }()

    let checkMailButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = R.color.buttonColor()
        button.addTarget(self, action: #selector(checkMailButtonAction), for: .touchUpInside)
        button.setTitle(R.string.localizable.checkEmail(), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundAppColor()
        configureViews()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        checkMailButton.layer.cornerRadius = checkMailButton.frame.height / 2
    }


    //MARK:- Configure views

    private func configureViews() {
        
        checkMailButton.snp.makeConstraints {
            $0.size.equalTo(Constants.buttonSize)
        }
        
        let containerView = UIStackView(arrangedSubviews: [mailImageView, checkEmailLabel,
                                                           descriptionEmailLabel, checkMailButton])
        containerView.axis = .vertical
        containerView.alignment = .center
        containerView.setCustomSpacing(33, after: mailImageView)
        containerView.setCustomSpacing(11, after: checkEmailLabel)
        containerView.setCustomSpacing(40, after: descriptionEmailLabel)
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }

    //MARK:- Handlers

    @objc func checkMailButtonAction() {
        viewModel.input.checkMailTapped()
    }
    
}
