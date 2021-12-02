//
//  UITableViewIflater.swift
//  AppToYou
//
//  Created by mac on 25.11.21.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit


protocol InflatableView {
    
    func inflate(model: AnyObject)
}

public protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UITableViewCell: ReusableView {

}

public extension UITableView {

    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    /// Get cell with the default reuse cell identifier
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell: \(T.self) with identifier: \(T.defaultReuseIdentifier)")
        }

        return cell
    }
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
    
    private func getModel(for indexPath: IndexPath) -> AnyObject {
        let model = sections[indexPath.section].models[indexPath.row]
        return model
    }
    
}
