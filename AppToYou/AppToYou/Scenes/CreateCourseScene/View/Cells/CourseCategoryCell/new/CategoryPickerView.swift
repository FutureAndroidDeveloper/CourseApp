import UIKit
import DropDown


class CategoryPickerView: UIView, ValidationErrorDisplayable {
    
    private struct Constants {
        
    }
    
    private var model: CourseCategoryModel?

    private let dropDown = DropDown()
    private let selectedCategoriesView = SelectedCategoriesView()
    private let tapGesture = UITapGestureRecognizer()
    
    private let arrowImageView = UIImageView()

    
    init() {
        super.init(frame: .zero)
        backgroundColor = R.color.backgroundTextFieldsColor()
        
        setup()
        configureDropDown()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
        
        let spaceing: CGFloat = 6
        let fieldHeight = dropDown.anchorView?.plainView.bounds.height ?? 0
        dropDown.bottomOffset = CGPoint(x: 0, y: spaceing + fieldHeight)
        
        let topValue = convert(bounds, to: window).minY
        let topDropValue = dropDown.bottomOffset.y + topValue + 13 + 11
        let dropHeight: CGFloat = 50
        
        let dropBottom = topDropValue + dropHeight
        
        let windowHeight = window?.bounds.height ?? 0
        
        print(windowHeight - dropBottom)
        
//        dropDown.offsetFromWindowBottom = windowHeight - dropBottom
        
        dropDown.width = bounds.width
    }

    private func setup() {
        
        arrowImageView.image = R.image.downArrowTf()
        arrowImageView.contentMode = .center
        addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        addSubview(selectedCategoriesView)
        selectedCategoriesView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.trailing.equalTo(arrowImageView.snp.leading)
        }
        
        tapGesture.addTarget(self, action: #selector(showDropDown))
        self.addGestureRecognizer(tapGesture)
        
    }
    
    private func configureDropDown() {
        dropDown.anchorView = selectedCategoriesView
        dropDown.direction = .bottom
    
        dropDown.multiSelectionAction = { [weak self] (indexes: [Index], items: [String]) in
            guard
                let self = self,
                let model = self.model
            else {
                return
            }
            
            if indexes.count > 3 {
                self.selectRows()
                return
            }
            
            let updatedSelection = indexes
                .sorted()
                .map { model.categories[$0] }
            
            model.update(selected: updatedSelection)
            self.update()
        }

        dropDown.cancelAction = { [unowned self] in
            self.arrowImageView.transform = self.arrowImageView.transform.rotated(by: .pi)
        }

        dropDown.willShowAction = { [unowned self] in
            self.arrowImageView.transform = self.arrowImageView.transform.rotated(by: .pi)
        }
    }
    
    func configure(with model: CourseCategoryModel) {
        self.model = model
        
        dropDown.dataSource = model.categories.compactMap { $0.title }
        update()
        selectRows()
    }
    
    func bind(error: ValidationError?) {
        if let _ = error {
            layer.borderWidth = 1
            layer.borderColor = R.color.failureColor()?.cgColor
        } else {
            layer.borderWidth = 0
            layer.borderColor = nil
        }
    }
    
    private func update() {
        guard let model = model else {
            return
        }
        
        selectedCategoriesView.confugire(with: model.selectedCategories) { [weak self] removedCategory in
            guard
                let self = self,
                let removedIndex = model.selectedCategories.firstIndex(of: removedCategory)
            else {
                return
            }
            var updatedCategories = model.selectedCategories
            updatedCategories.remove(at: removedIndex)
            model.update(selected: updatedCategories)
            self.configure(with: model)
        }
    }
    
    private func selectRows() {
        guard let model = model else {
            return
        }
        
        let set = model.selectedCategories.compactMap { category in
            model.categories.firstIndex(of: category)
        }.reduce(into: Set<Index>()) { resultSet, index in
            resultSet.insert(index)
        }
        
        dropDown.deselectRows(at: Set<Index>(0..<dropDown.dataSource.count))
        dropDown.selectRows(at: set)
    }
    
    @objc
    private func showDropDown() {
        dropDown.show()
    }
    
}
