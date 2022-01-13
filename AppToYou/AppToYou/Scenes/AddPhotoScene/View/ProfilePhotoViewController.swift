import UIKit


class ProfilePhotoViewController: UIViewController, BindableType {
    
    private struct Constants {
        static let titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: -47, right: 20)
        static let addPhotoInsets = UIEdgeInsets(top: -12, left: 20, bottom: 0, right: 20)
        static let saveInsets = UIEdgeInsets(top: 24, left: 20, bottom: 0, right: 20)
        static let laterInsets = UIEdgeInsets(top: 16, left: 20, bottom: 0, right: 20)
        
        struct Photo {
            static let size = CGSize(width: 100, height: 100)
            static let borderWitdh: CGFloat = 2
            static let borderColor = R.color.backgroundTextFieldsColor()
        }
    }
    
    var viewModel: AddPhotoViewModel!
    
    private let titleLabel = LabelFactory.createHeaderLabel(title: R.string.localizable.downloadPhoto())
    private let addPhotoButton = ButtonFactory.getProfileImageButton(title: nil)
    private let saveButton = ButtonFactory.getStandartButton(title: R.string.localizable.save())
    private let laterButton = ButtonFactory.getTansparentButton(title: R.string.localizable.uploadPhotLater())

    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = R.image.photoSmile()
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundAppColor()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.bringSubviewToFront(photoImageView)
        photoImageView.layer.borderWidth = Constants.Photo.borderWitdh
        photoImageView.layer.borderColor = Constants.Photo.borderColor?.cgColor
        photoImageView.layer.cornerRadius = photoImageView.bounds.height / 2
        addPhotoButton.layer.cornerRadius = addPhotoButton.bounds.height / 2
        saveButton.layer.cornerRadius = saveButton.bounds.height / 2
        laterButton.layer.cornerRadius = photoImageView.bounds.height / 2
    }

    private func configure() {
        titleLabel.textAlignment = .center
        
        view.addSubview(photoImageView)
        photoImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Constants.Photo.size)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(photoImageView.snp.top).offset(Constants.titleInsets.bottom)
            $0.leading.trailing.equalToSuperview().inset(Constants.titleInsets)
        }
        
        view.addSubview(addPhotoButton)
        addPhotoButton.snp.makeConstraints {
            $0.top.equalTo(photoImageView.snp.bottom).offset(Constants.addPhotoInsets.top)
            $0.leading.trailing.equalToSuperview().inset(Constants.addPhotoInsets)
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints {
            $0.top.equalTo(addPhotoButton.snp.bottom).offset(Constants.saveInsets.top)
            $0.leading.trailing.equalToSuperview().inset(Constants.saveInsets)
        }
        
        view.addSubview(laterButton)
        laterButton.snp.makeConstraints {
            $0.top.equalTo(saveButton.snp.bottom).offset(Constants.laterInsets.top)
            $0.leading.trailing.equalToSuperview().inset(Constants.laterInsets)
        }
        
        addPhotoButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        laterButton.addTarget(self, action: #selector(laterButtonAction), for: .touchUpInside)
    }
    
    func bindViewModel() {
        viewModel.output.photo.bind { [weak self] photo in
            self?.photoImageView.image = photo
        }
        
        viewModel.output.pickPhotoButtonTitle.bind { [weak self] buttonTitle in
            self?.addPhotoButton.setTitle(buttonTitle, for: .normal)
        }
        
        viewModel.output.saveIsActive.bind { [weak self] isActive in
            if isActive {
                self?.saveButton.enable()
            } else {
                self?.saveButton.disable()
            }
        }
    }
    
    @objc
    private func addButtonAction() {
        viewModel.input.photoAction(with: photoImageView.image)
    }

    @objc
    private func saveButtonAction() {
        viewModel.input.savePhoto(photoImageView.image)
    }

    @objc
    private func laterButtonAction() {
        viewModel.input.pickPhotoLater()
    }
    
}
