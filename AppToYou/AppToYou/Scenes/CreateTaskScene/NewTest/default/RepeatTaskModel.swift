import Foundation


protocol CounterTaskCreationDelegate: DefaultTaskCreationDelegate {
    func getCounterModel() -> NaturalNumberFieldModel
}


class RepeatTaskModel<DataProvider>: DefaultTaskModel<RepeatCreateTaskModel, DataProvider> where DataProvider: CounterTaskCreationDelegate {

    override func construct() {
        super.construct()

        guard let dataProvider = delegate else {
            return
        }
        addCounter(dataProvider)
    }
    
    private func addCounter(_ dataProvider: CounterTaskCreationDelegate) {
        let counterModel = dataProvider.getCounterModel()
        model.addCounter(model: counterModel)
    }
}

