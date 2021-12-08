import UIKit


class TaskPeriodCell: UITableViewCell, UITextFieldDelegate, InflatableView {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 15, right: 23)
        static let space: CGFloat = 16
        
        static let startTitle = R.string.localizable.taskStartTitle()
        static let endTitle = R.string.localizable.taskEndTitle()
    }
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        return picker
    }()
    
    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(datePickerDone))
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()
        
        return toolBar
    }()

    private let startTextField = SelectDateTextField(style: .standart)
    private let endTextField = SelectDateTextField(style: .standart)

    private var startCallback: ((String?) -> Void)?
    private var endCallback: ((String?) -> Void)?

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let startBlock = buildDateBlock(title: Constants.startTitle, pickerView: startTextField)
        let endBlock = buildDateBlock(title: Constants.endTitle, pickerView: endTextField)
        
        contentView.addSubview(startBlock)
        startBlock.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(Constants.edgeInsets)
        }
        
        contentView.addSubview(endBlock)
        endBlock.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview().inset(Constants.edgeInsets)
            $0.leading.greaterThanOrEqualTo(startBlock.snp.trailing).offset(Constants.space)
        }
        
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .valueChanged)
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? TaskPeriodModel else {
            return
        }
        
        startCallback = model.startPicked
        endCallback = model.endPicked
    }
    
    private func buildDateBlock(title: String?, pickerView: UITextField) -> UIView {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = R.color.titleTextColor()
        
        pickerView.inputAccessoryView = toolBar
        pickerView.inputView = datePicker
        pickerView.delegate = self
        
        let block = UIStackView(arrangedSubviews: [label, pickerView])
        block.axis = .vertical
        block.spacing = 10
        return block
    }

    @objc
    private func dateChanged() {
        let text = datePicker.date.toString(dateFormat: .simpleDateFormatFullYear)
        if startTextField.isFirstResponder {
            startTextField.text = text
            startCallback?(text)
        } else {
            endTextField.text = text
            endCallback?(text)
        }
    }

    @objc
    private func datePickerDone() {
        startTextField.resignFirstResponder()
        endTextField.resignFirstResponder()
    }
}
