import UIKit


class SelectedCategoriesView: UIView {

    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 11, left: 16, bottom: 13, right: 0)
        static let collectionEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }

    private var selectedCategories: [ATYCourseCategory]
    private var didRemove: ((ATYCourseCategory) -> Void)?

    private let placeHolderLabel = UILabel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()


    init() {
        selectedCategories = []
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let cornerRadius = bounds.height / 2
        layer.cornerRadius = cornerRadius
        placeHolderLabel.layer.cornerRadius = cornerRadius
        collectionView.layer.cornerRadius = cornerRadius
    }


    private func setup() {
        placeHolderLabel.text = "Выберите из списка"
        addSubview(placeHolderLabel)
        placeHolderLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.edgeInsets)
        }

        collectionView.backgroundColor = R.color.backgroundTextFieldsColor()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionCategoryCourseCell.self,
                                forCellWithReuseIdentifier: CollectionCategoryCourseCell.reuseIdentifier)
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.collectionEdgeInsets)
        }
    }

    func confugire(with selectedCategories: [ATYCourseCategory], _ didRemove: @escaping (ATYCourseCategory) -> Void) {
        self.selectedCategories = selectedCategories
        self.didRemove = didRemove

        collectionView.isHidden = selectedCategories.isEmpty
        collectionView.reloadData()
    }

}

extension SelectedCategoriesView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedCategories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCategoryCourseCell.reuseIdentifier,
                                                          for: indexPath) as? CollectionCategoryCourseCell
        else {
            return UICollectionViewCell()
        }

        let category = selectedCategories[indexPath.row]
        cell.configure(with: category) { [weak self] removedCategory in
            guard let self = self else {
                return
            }
            self.didRemove?(removedCategory)
        }

        return cell
    }
}
