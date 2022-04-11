import UIKit


class CategoryFilterView: UIView {
    private struct Constants {
        static let maxSelectedCategories = 3
        static let collectionInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    private(set) var filters: [CourseFilter]
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = Constants.collectionInsets
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()


    init(filters: [CourseFilter] = []) {
        self.filters = filters
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setup() {
        collectionView.backgroundColor = R.color.backgroundAppColor()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CourseFilterCell.self, forCellWithReuseIdentifier: CourseFilterCell.reuseIdentifier)
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func confugire(with filters: [CourseFilter]) {
        self.filters = filters
        collectionView.reloadData()
    }
    
    func shouldFilterSelect(_ filter: CourseFilter) -> Bool {
        var result: Bool
        
        if !filter.isSelected, filters.filter({ $0.isSelected }).count < Constants.maxSelectedCategories {
            result = true
        } else {
            result = false
        }
        filter.isSelected = result
        return result
    }
}

extension CategoryFilterView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseFilterCell.reuseIdentifier,
                                                          for: indexPath) as? CourseFilterCell
        else {
            return UICollectionViewCell()
        }

        let filter = filters[indexPath.row]
        cell.configure(with: filter) { [weak self] changeFilter in
            guard let shouldSelect = self?.shouldFilterSelect(changeFilter) else {
                return
            }
            if shouldSelect {
                cell.select()
            } else {
                cell.deselect()
            }
        }
        return cell
    }
}
