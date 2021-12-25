import UIKit


class SelectDateCell: UITableViewCell, InflatableView, ValidationErrorDisplayable {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 32, right: 0)
                
        struct Field {
            static let width: CGFloat = 150
            static let textInsets = UIEdgeInsets(top: 8, left: 7, bottom: 10, right: 10)
            static let iconInsets = UIEdgeInsets(top: 7, left: 10, bottom: 7, right: 0)
        }
    }

    private let startTextField = DateTextField(style: StyleManager.highlightedTextField)
    
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
            $0.width.equalTo(Constants.Field.width)
        }
        
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .valueChanged)
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? SelectDateModel else {
            return
        }
        
        let calendarIconView = UIImageView()
        calendarIconView.image = R.image.calendarImage()?.withRenderingMode(.alwaysTemplate)
        calendarIconView.tintColor = R.color.backgroundTextFieldsColor()
        
        let calendarModel = FieldAdditionalContentModel(contentView: calendarIconView, insets: Constants.Field.iconInsets)
        let contentModel = FieldContentModel(fieldModel: model.date, insets: Constants.Field.textInsets)
        let fieldModel = FieldModel(content: contentModel, leftContent: calendarModel)
        startTextField.configure(with: fieldModel)
        
        model.errorNotification = { [weak self] error in
            self?.startTextField.bind(error: error)
            self?.bind(error: error)
        }
    }

    @objc
    private func dateChanged() {
        guard let dateModel = startTextField.model?.content.fieldModel else {
            return
        }
        dateModel.update(value: datePicker.date)
        startTextField.setContentModel(dateModel)
    }

    @objc
    private func datePickerDone() {
        startTextField.resignFirstResponder()
    }
    
}
