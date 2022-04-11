import UIKit


class MembershipFilterView: CategoryFilterView {
    override func shouldFilterSelect(_ filter: CourseFilter) -> Bool {
        if !filter.isSelected {
            deselectAll()
            filter.isSelected = true
        }
        
        scroll(to: filter)
        return true
    }
    
    private func deselectAll() {
        (0...filters.count)
            .map { IndexPath(item: $0, section: 0) }
            .map { collectionView.cellForItem(at: $0) }
            .compactMap { $0 as? CourseFilterCell}
            .forEach { $0.deselect() }
        
        filters.forEach { $0.isSelected = false }
    }
    
    private func scroll(to filter: CourseFilter) {
        guard let index = filters.firstIndex(where: { $0.title == filter.title } ) else {
            return
        }
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    }
}
