import UIKit


class UITableViewIflater: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView: UITableView
    private var sections: [TableViewSection] = []
    private var holders: [TableTypesHolder] = []
    
    
    init(_ tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    var rowDidSelect: ((_ model: AnyObject, _ indexPath: IndexPath) -> Void)?
    
    func addRowHandler<Model: AnyObject>(for model: Model.Type, handler: @escaping (Model, IndexPath) -> Void) {
        guard let holder = holders.first(where: { $0.modelType == model }) else {
            return
        }
        
        holder.selectHandler = { [weak self] selectedModel, indexPath in
            guard let selectedModel = selectedModel as? Model else {
                return
            }
            handler(selectedModel, indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = sections[indexPath.section].models[indexPath.row]
        guard let holder = holders.first(where: { $0.isModelEquals(model: model) }) else {
            return
        }
        
        holder.selectHandler?(model, indexPath)
    }
    
    func registerRow<Cell: UITableViewCell>(model: AnyObject.Type, cell: Cell.Type) where Cell: InflatableView {
        let holder = TableTypesHolder(inflatableType: cell, modelType: model)
        holders.append(holder)
        tableView.register(cell.self, forCellReuseIdentifier: cell.reuseIdentifier)
    }
    
    func registerHeaderFooter<HeaderFooter: UITableViewHeaderFooterView>(model: AnyObject.Type,
                                                                         headerFooter: HeaderFooter.Type) where HeaderFooter: InflatableView {
        
        let holder = TableTypesHolder(inflatableType: headerFooter, modelType: model)
        holders.append(holder)
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
        let model = sections[indexPath.section].models[indexPath.row]
        
        guard
            let holder = holders.first(where: { $0.isModelEquals(model: model) }),
            let cellType = holder.inflatableType as? UITableViewCell.Type
        else {
            fatalError("Cant find cell for model: \(model)")
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath)
        
        guard let inflatableCell = cell as? InflatableView else {
            fatalError("cell in not inflatable: \(cell)")
        }
        inflatableCell.inflate(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let headerModel = sections[section].header,
            let holder = holders.first(where: { $0.isModelEquals(model: headerModel) }),
            let headerType = holder.inflatableType as? UITableViewHeaderFooterView.Type
        else {
            return nil
        }
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerType.reuseIdentifier)
        
        guard let inflatableHeader = header as? InflatableView else {
            fatalError("header in not inflatable: \(header)")
        }
        inflatableHeader.inflate(model: headerModel)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = sections[indexPath.section].models[indexPath.row]
        
        guard let height = getHeight(for: model) else {
            return UITableView.automaticDimension
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let height = getHeight(for: sections[section].header) else {
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
    
    private func getHeight(for model: AnyObject?) -> CGFloat? {
        guard
            let model = model,
            let holder = holders.first(where: { $0.isModelEquals(model: model) })
        else {
            return nil
        }
        return holder.inflatableType.staticHeight
    }
    
}
