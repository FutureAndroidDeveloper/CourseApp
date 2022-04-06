import Foundation


extension IndexPath {
    private struct Constants {
        static let unexistingRow = -1
        static let unexistingSection = -1
    }
    
    static let empty = IndexPath(row: Constants.unexistingRow, section: Constants.unexistingRow)
}
