import UIKit


class ChangeCounterViewController: UIViewController, BindableType, UIPickerViewDelegate, UIPickerViewDataSource {
    private struct Constants {
        static let pickerInsets = UIEdgeInsets(top: 45, left: 20, bottom: 0, right: 20)
        static let buttonInsets = UIEdgeInsets(top: 17, left: 20, bottom: 47, right: 20)
        static let buttonHeight: CGFloat = 45
    }
    
    var viewModel: ChangeCounterViewModel!
    
    private let pickerContainer = UIView()
    private let pickerView = UIPickerView()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.backgroundColor = R.color.buttonColor()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(R.color.backgroundTextFieldsColor(), for: .normal)
        return button
    }()
    
    private let pickerDataSize = Int(INT16_MAX)
    private let actualLength = 999
    private var selectedCount = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.reloadAllComponents()
        
        let row = (pickerDataSize / (2 * actualLength)) * actualLength
        pickerView.selectRow(row, inComponent: 0, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        saveButton.layer.cornerRadius = saveButton.bounds.height / 2
    }

    private func configure() {
        view.backgroundColor = R.color.backgroundTextFieldsColor()
        
        view.addSubview(pickerContainer)
        pickerContainer.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Constants.pickerInsets)
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints {
            $0.top.equalTo(pickerContainer.snp.bottom).offset(Constants.buttonInsets.top)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.buttonInsets)
            $0.height.equalTo(Constants.buttonHeight)
        }
        
        pickerContainer.addSubview(pickerView)
        pickerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        saveButton.addTarget(self, action: #selector(saveDidTap), for: .touchUpInside)
    }
    
    func bindViewModel() {
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSize
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let value = (row % actualLength) + 1
        return "\(value)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCount = (row % actualLength) + 1
    }
    
    @objc
    private func saveDidTap() {
        viewModel.input.countPicked(selectedCount)
    }
    
}
