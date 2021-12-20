import Foundation


protocol TextTaskCreationDelegate: DefaultTaskCreationDelegate {
    func getDescriptionModel() -> PlaceholderTextViewModel
    func getMinSymbolsModel() -> NaturalNumberFieldModel
}


class TextTaskModel<DataProvider>: DefaultTaskModel<TextCreateTaskModel, DataProvider> where DataProvider: TextTaskCreationDelegate {

    override func construct() {
        super.construct()

        guard let dataProvider = delegate else {
            return
        }
        addDescription(dataProvider)
        addLimit(dataProvider)
    }
    
    private func addDescription(_ dataProvider: TextTaskCreationDelegate) {
        let descriptionModel = dataProvider.getDescriptionModel()
        model.addDescriptionHandler(model: descriptionModel)
    }
    
    private func addLimit(_ dataProvider: TextTaskCreationDelegate) {
        let limitModel = dataProvider.getMinSymbolsModel()
        model.addLimitHandler(model: limitModel)
    }
    
}
