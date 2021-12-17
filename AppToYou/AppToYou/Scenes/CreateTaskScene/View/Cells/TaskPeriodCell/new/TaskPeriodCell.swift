import UIKit


class TaskPeriodCell: UITableViewCell, UITextFieldDelegate, InflatableView {
    
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 23)
        static let space: CGFloat = 16
        
        struct Field {
            static let size = CGSize(width: 158, height: 45)
            static let textInsets = UIEdgeInsets(top: 11, left: 8, bottom: 13, right: 20)
            static let iconInsets = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 0)
                        
            struct Title {
                static let start = R.string.localizable.taskStartTitle()
                static let end = R.string.localizable.taskEndTitle()
            }
        }
    }
    
    private let startTextField = DateTextField(style: StyleManager.standartTextField)
    private let endTextField = DateTextField(style: StyleManager.standartTextField)
    
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
        let startBlock = buildDateBlock(title: Constants.Field.Title.start, pickerView: startTextField)
        contentView.addSubview(startBlock)
        startBlock.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(Constants.edgeInsets)
        }
        
        let endBlock = buildDateBlock(title: Constants.Field.Title.end, pickerView: endTextField)
        contentView.addSubview(endBlock)
        endBlock.snp.makeConstraints {
            $0.leading.equalTo(startBlock.snp.trailing).offset(Constants.space)
            $0.top.bottom.equalToSuperview().inset(Constants.edgeInsets)
        }
        
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .valueChanged)
    }
    
    private func buildDateBlock(title: String?, pickerView: UITextField) -> UIView {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = R.color.titleTextColor()
        
        pickerView.inputAccessoryView = toolBar
        pickerView.inputView = datePicker
        pickerView.delegate = self
        pickerView.snp.makeConstraints {
            $0.size.equalTo(Constants.Field.size)
        }
        
        let block = UIStackView(arrangedSubviews: [label, pickerView])
        block.axis = .vertical
        block.spacing = Constants.edgeInsets.bottom
        return block
    }
    
    private func configureField(_ field: DateTextField, dateModel: DateFieldModel) {
        let calendarIcon = UIImageView()
        calendarIcon.image = R.image.calendarImage()?.withRenderingMode(.alwaysTemplate)
        calendarIcon.tintColor = R.color.textSecondaryColor()
        
        let calendarModel = FieldAdditionalContentModel(contentView: calendarIcon, insets: Constants.Field.iconInsets)
        let contentModel = FieldContentModel(fieldModel: dateModel, insets: Constants.Field.textInsets)
        let fieldModel = FieldModel(content: contentModel, leftContent: calendarModel)
        
        field.configure(with: fieldModel)
    }
    
    func inflate(model: AnyObject) {
        guard let model = model as? TaskPeriodModel else {
            return
        }
        
        configureField(startTextField, dateModel: model.start)
        configureField(endTextField, dateModel: model.end)
    }

    @objc
    private func dateChanged() {
        let dateModel = DateFieldModel(value: datePicker.date)
        let field = startTextField.isFirstResponder ? startTextField : endTextField
        
        configureField(field, dateModel: dateModel)
    }

    @objc
    private func datePickerDone() {
        startTextField.resignFirstResponder()
        endTextField.resignFirstResponder()
    }
    
}
