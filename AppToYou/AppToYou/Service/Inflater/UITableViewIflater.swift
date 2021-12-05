import UIKit


protocol InflatableView {
    
    func inflate(model: AnyObject)
}


class TableHeader {
    
}


class TableViewSection {
    
    let models: [AnyObject]
    let header: TableHeader?
    
    init(models: [AnyObject], header: TableHeader? = nil) {
        self.models = models
        self.header = header
    }
    
}


class UITableViewIflater: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    typealias AssociatedTypes = (model: AnyObject.Type, cell: UITableViewCell.Type)
    
    private let tableView: UITableView
    private var sections: [TableViewSection] = []
    private var typeStore: [String: AssociatedTypes] = [:]
    
    init(_ tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func registerRow(model: AnyObject.Type, cell: UITableViewCell.Type) {
        typeStore[cell.reuseIdentifier] = (model: model.self, cell: cell.self)
        tableView.register(cell.self, forCellReuseIdentifier: cell.reuseIdentifier)
    }
    
    func inflate(sections: [TableViewSection]) {
        self.sections = sections
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = getModel(for: indexPath)

        // поиск id и типов модели, ячейки по переданной моделе
        guard
            let helper = typeStore.first(where: { type(of: model) == $0.value.model } ),
            let cell = tableView.dequeueReusableCell(withIdentifier: helper.key, for: indexPath) as? InflatableView
        else {
            fatalError()
        }
        
        cell.inflate(model: model)
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    private func getModel(for indexPath: IndexPath) -> AnyObject {
        let model = sections[indexPath.section].models[indexPath.row]
        return model
    }
    
}
