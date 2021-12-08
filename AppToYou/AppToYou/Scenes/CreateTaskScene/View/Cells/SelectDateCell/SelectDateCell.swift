import UIKit


class SelectDateModel {
    
}


class SelectDateCell: UITableViewCell, InflatableView {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 0)
    }

    private let startTextField = SelectDateTextField(style: .highlighted)
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        return picker
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.backgroundAppColor()
        selectionStyle = .none
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func inflate(model: AnyObject) {
        guard let model = model as? SelectDateModel else {
            return
        }
    }

    private func configure() {
        let toolBar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(datePickerDone))
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()
        
        startTextField.inputAccessoryView = toolBar
        startTextField.inputView = datePicker
        
        contentView.addSubview(startTextField)
        startTextField.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(Constants.edgeInsets)
        }
        
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .valueChanged)
        dateChanged()
    }

    @objc
    private func dateChanged() {
        startTextField.text = datePicker.date.toString(dateFormat: .simpleDateFormatFullYear)
    }

    @objc
    private func datePickerDone() {
        startTextField.resignFirstResponder()
    }
    
}
