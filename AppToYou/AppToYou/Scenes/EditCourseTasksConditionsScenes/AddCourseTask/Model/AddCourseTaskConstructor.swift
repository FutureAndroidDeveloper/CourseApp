import Foundation


protocol AddCourseTaskDataSource: AnyObject {
    func getTitleModel() -> AddTaskTitleModel
    func getDescription() -> String?
    func getAttributeTitle() -> String
    func getField() -> AnyObject?
    func getSanctionModel() -> (model: NaturalNumberFieldModel, min: Int, isEnabled: Bool)
}


class AddCourseTaskConstructor {
    let model: AddCourseTaskModel
    
    weak var delegate: CreatorDelegate?
    private weak var dataSource: AddCourseTaskDataSource?
    
    
    init(model: AddCourseTaskModel) {
        self.model = model
    }
    
    func setDataSource(dataSource: AddCourseTaskDataSource?) {
        self.dataSource = dataSource
    }
    
    func setDelegate(delegate: CreatorDelegate?) {
        self.delegate = delegate
    }
    
    func construct() {
        guard let dataSource = dataSource else {
            return
        }
        
        addTitle(dataSource)
        addDiscription(dataSource)
        addAttribute(dataSource)
        addField(dataSource)
        addSanction(dataSource)
    }
    
    func getModels() -> [AnyObject] {
        return model.prepare()
    }
    
    private func addTitle(_ dataProvider: AddCourseTaskDataSource) {
        let titleModel = dataProvider.getTitleModel()
        model.addTitle(model: titleModel)
    }
    
    private func addDiscription(_ dataProvider: AddCourseTaskDataSource) {
        guard let description = dataProvider.getDescription() else {
            return
        }
        model.addDescription(description)
    }
    
    private func addAttribute(_ dataProvider: AddCourseTaskDataSource) {
        let attribute = dataProvider.getAttributeTitle()
        model.addAttribute(title: attribute)
    }
    
    private func addField(_ dataProvider: AddCourseTaskDataSource) {
        guard let model = dataProvider.getField() else {
            return
        }
        self.model.addField(model: model)
    }
        
    private func addSanction(_ dataProvider: AddCourseTaskDataSource) {
        let (sanctionModel, min, isEnabled) = dataProvider.getSanctionModel()
        model.addSanction(
            model: sanctionModel, isEnabled: isEnabled, minValue: min,
            switchChanged: { [weak self] isOn in
                print(isOn)
            }, questionCallback: { [weak self] in
                print("Question")
            })
        
        if min > .zero {
            model.sanctionModel?.showMinLabel()
        }
        model.sanctionModel?.updateStyle(StyleManager.reversedcolorsTextField)
    }
    
}
