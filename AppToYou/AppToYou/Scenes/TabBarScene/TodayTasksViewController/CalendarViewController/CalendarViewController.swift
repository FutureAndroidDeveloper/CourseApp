import UIKit


class CalendarViewController: UICollectionViewController {
    private struct Constants {
        static let calendarOffset = 1
    }
    
    private let currentDate = Date()
    private var models: [CalendarCellModel] = []

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDate()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let index = models.firstIndex(where: { $0.date == currentDate }) else {
            return
        }
        
        let indexPath = IndexPath(item: index, section: 0)
        scroll(to: indexPath, selection: true)
    }
    
    func getSelectedDate() -> Date {
        guard let model = models.first(where: { $0.isSelected }) else {
            return currentDate
        }
        return model.date
    }
    
    
    private func setup() {
        collectionView.register(ATYCalendarCollectionViewCell.self, forCellWithReuseIdentifier: ATYCalendarCollectionViewCell.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = R.color.backgroundAppColor()
        view.backgroundColor = R.color.backgroundAppColor()
    }

    private func updateDate() {
        let calendar = Calendar.current
        guard
            let minDate = calendar.date(byAdding: .month, value: -Constants.calendarOffset, to: currentDate),
            let maxDate = calendar.date(byAdding: .month, value: Constants.calendarOffset, to: currentDate)
        else {
            return
        }
        
        var date = minDate
        while date <= maxDate {
            models.append(CalendarCellModel(date: date, progress: .complete))
            if let nexDate = calendar.date(byAdding: .day, value: Constants.calendarOffset, to: date) {
                date = nexDate
            }
        }
    }
    
    private func scroll(to indexPath: IndexPath, selection: Bool) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        models.first { $0.isSelected }?.setSelected(false)
        models[indexPath.item].setSelected(selection)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ATYCalendarCollectionViewCell.reuseIdentifier, for: indexPath) as? ATYCalendarCollectionViewCell else {
                return UICollectionViewCell()
            }

        let model = models[indexPath.item]
        cell.configure(with: model)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scroll(to: indexPath, selection: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        scroll(to: indexPath, selection: false)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.bounds.width/7, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
}

