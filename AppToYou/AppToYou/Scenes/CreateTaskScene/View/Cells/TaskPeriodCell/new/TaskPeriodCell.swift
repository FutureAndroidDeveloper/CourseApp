import UIKit


class TaskPeriodCell: UITableViewCell, UITextFieldDelegate, InflatableView, ValidationErrorDisplayable {
    
    private struct Constants {
        static let checkInsets = UIEdgeInsets(top: 16, left: 20, bottom: 32, right: 20)
        static let edgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 9, right: 20)
        
        
        static let space: CGFloat = 16
        static let verticalPadding: CGFloat = 12
        
        struct Field {
            static let width: CGFloat = 158
            static let textInsets = UIEdgeInsets(top: 11, left: 8, bottom: 13, right: 20)
            static let iconInsets = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 0)
                        
            struct Title {
                static let start = R.string.localizable.taskStartTitle()
                static let end = R.string.localizable.taskEndTitle()
            }
        }
    }
    
    
    private let startTextField = FieldFactory.shared.getDateField(style: .standart)
    private let endTextField = FieldFactory.shared.getDateField(style: .standart)
    private let infiniteView = TitledCheckBox()
    private var endBlock: UIView?
    
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
            $0.leading.top.equalToSuperview().inset(Constants.edgeInsets)
        }
        
        let endBlock = buildDateBlock(title: Constants.Field.Title.end, pickerView: endTextField)
        contentView.addSubview(endBlock)
        endBlock.snp.makeConstraints {
            $0.leading.equalTo(startBlock.snp.trailing).offset(Constants.space)
            $0.bottom.equalTo(startBlock.snp.bottom)
            $0.top.equalToSuperview().inset(Constants.edgeInsets)
        }
        self.endBlock = endBlock
        
        contentView.addSubview(infiniteView)
        infiniteView.snp.makeConstraints {
            $0.top.equalTo(startBlock.snp.bottom).offset(Constants.verticalPadding)
            $0.leading.bottom.trailing.equalToSuperview().inset(Constants.checkInsets)
        }
        
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .valueChanged)
    }
    
    private func buildDateBlock(title: String?, pickerView: UITextField) -> UIView {
        let label = LabelFactory.getTitleLabel(title: title)
        
        pickerView.inputAccessoryView = toolBar
        pickerView.inputView = datePicker
        pickerView.delegate = self
        pickerView.snp.makeConstraints {
            $0.width.equalTo(Constants.Field.width)
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
        infiniteView.configure(with: model.isInfiniteModel) { [weak self] isInfinite in
            self?.infiniteStateChanged(isInfinite)
        }
        
        model.errorNotification = { [weak self] error in
            switch error {
            case .startDate:
                self?.startTextField.bind(error: error)
                self?.endTextField.bind(error: nil)
            case .endDate, .emptyEndDate:
                self?.endTextField.bind(error: error)
                self?.startTextField.bind(error: nil)
            default:
                self?.endTextField.bind(error: error)
                self?.startTextField.bind(error: error)
            }
            self?.bind(error: error)
        }
        
        if model.isEditable {
            startTextField.enable()
        } else {
            startTextField.disable()
        }
    }
    
    private func infiniteStateChanged(_ isInfinite: Bool) {
        guard let dateModel = endTextField.model?.content.fieldModel else {
            return
        }
        endTextField.bind(error: nil)
        endBlock?.isHidden = isInfinite
    }

    @objc
    private func dateChanged() {
        let field = startTextField.isFirstResponder ? startTextField : endTextField
        
        guard let dateModel = field.model?.content.fieldModel else {
            return
        }
        dateModel.update(value: datePicker.date)
        field.setContentModel(dateModel)
    }

    @objc
    private func datePickerDone() {
        startTextField.resignFirstResponder()
        endTextField.resignFirstResponder()
    }
    
}
