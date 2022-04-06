import Foundation
import RealmSwift


class RemovedTask: Object {
    @Persisted(primaryKey: true) var id: Int
}
