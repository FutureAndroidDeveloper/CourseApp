import Foundation



class SearchCourseModel {
    private(set) var name: String
    private(set) var page: Int
    private(set) var pageSize: Int
    
    private(set) var category1: ATYCourseCategory?
    private(set) var category2: ATYCourseCategory?
    private(set) var category3: ATYCourseCategory?
    
    convenience init(page: Int, pageSize: Int) {
        self.init(name: String(), page: page, pageSize: pageSize)
    }
    
    init(name: String, page: Int, pageSize: Int) {
        self.name = name
        self.page = page
        self.pageSize = pageSize
    }
    
    func reset(page: Int, pageSize: Int) {
        self.page = page
        self.pageSize = pageSize
    }
    
    func changeSearch(name: String) {
        self.name = name
    }
    
    func nextPage() {
        page += 1
    }
    
    func add(category: ATYCourseCategory) {
        if category1 == nil {
            category1 = category
        } else if category2 == nil {
            category2 = category
        } else {
            category3 = category
        }
    }
    
    @discardableResult
    func remove(category: ATYCourseCategory) -> Bool {
        if category1 == category {
            category1 = nil
        } else if category2 == category {
            category2 = nil
        } else if category3 == category {
            category3 = nil
        } else {
            return false
        }
        return true
    }
    
    var parameters: [Parameter] {
        let mirror = Mirror(reflecting: self)
        let parameters = mirror.children
            .compactMap { (label, value) -> (String, Any)? in
                guard let label = label else {
                    return nil
                }
                return (label, unwrapUsingProtocol(value))
            }
            .filter {
                if case Optional<Any>.none = $0.1 {
                    return false
                } else {
                    return true
                }
            }
            .map {
                Parameter(name: $0.0, value: $0.1)
            }
        
        return parameters
    }
    
}

