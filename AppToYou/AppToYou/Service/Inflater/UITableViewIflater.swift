import UIKit


class UITableViewIflater: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    typealias CellAssociatedType = (model: AnyObject.Type, cell: UITableViewCell.Type)
    typealias HeaderFooterAssociatedType = (model: AnyObject.Type, headerFooter: UITableViewHeaderFooterView.Type)
    
    private let tableView: UITableView
    private var sections: [TableViewSection] = []
    
    private var cellStore: [String: CellAssociatedType] = [:]
    private var headerFooterStore: [String: HeaderFooterAssociatedType] = [:]
    
    
    init(_ tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func registerRow(model: AnyObject.Type, cell: UITableViewCell.Type) {
        cellStore[cell.reuseIdentifier] = (model: model.self, cell: cell.self)
        tableView.register(cell.self, forCellReuseIdentifier: cell.reuseIdentifier)
    }
    
    func registerHeaderFooter(model: AnyObject.Type, headerFooter: UITableViewHeaderFooterView.Type) {
        headerFooterStore[headerFooter.reuseIdentifier] = (model: model.self, headerFooter: headerFooter.self)
        tableView.register(headerFooter.self, forHeaderFooterViewReuseIdentifier: headerFooter.reuseIdentifier)
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
        let model = getCellModel(for: indexPath)

        // поиск id и типов модели, ячейки по переданной моделе
        guard
            let helper = cellStore.first(where: { type(of: model) == $0.value.model } ),
            let cell = tableView.dequeueReusableCell(withIdentifier: helper.key, for: indexPath) as? InflatableView
        else {
            fatalError()
        }
        
        cell.inflate(model: model)
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // поиск id и типов модели, хедера по переданной моделе
        guard
            let model = sections[section].header,
            let helper = headerFooterStore.first(where: { type(of: model) == $0.value.model } ),
            let headerFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: helper.key) as? InflatableView
        else {
            return nil
        }
        
        headerFooter.inflate(model: model)
        return headerFooter as? UIView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let height = getCellHeight(for: getCellModel(for: indexPath)) else {
            return UITableView.automaticDimension
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let height = getHeaderFooterHeight(of: sections[section].header) else {
            return UITableView.automaticDimension
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if let _ = sections[section].header {
            return 44
        }
        return .zero
    }
    
    private func getCellHeight(for model: AnyObject) -> CGFloat? {
        guard
            let helper = cellStore.first(where: { type(of: model) == $0.value.model } ),
            let inflatable = helper.value.cell as? InflatableView.Type
        else {
            return nil
        }
        
        return inflatable.staticHeight
    }
    
    private func getHeaderFooterHeight(of model: AnyObject?) -> CGFloat? {
        guard
            let model = model,
            let helper = headerFooterStore.first(where: { type(of: model) == $0.value.model } ),
            let inflatable = helper.value.headerFooter as? InflatableView.Type
        else {
            return nil
        }
        
        return inflatable.staticHeight
    }
    
    private func getCellModel(for indexPath: IndexPath) -> AnyObject {
        let model = sections[indexPath.section].models[indexPath.row]
        return model
    }
    
}
