import UIKit


class CalendarViewController: UICollectionViewController {
    private struct Constants {
        static let calendarOffset = 1
    }
    
    var getProgress: ((_ date: Date) -> CalendarDayProgress)?
    var dateDidSelect: ((Date) -> Void)?
    
    private var models: [CalendarCellModel] = []
    private var currentDate: Date {
        return Date()
    }
    

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
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let index = findTodayModelIndex() else {
            return
        }
        let indexPath = IndexPath(item: index, section: 0)
        scroll(to: indexPath, selection: true)
    }
    
    func updateTodayProgress() {
        guard let index = findTodayModelIndex() else {
            return
        }
        let newProgress = getProgress?(currentDate) ?? .notStarted
        models[index].update(progress: newProgress)
        collectionView.reloadData()
    }
    
    func dateIsOver() {
        dateDidSelect?(currentDate)
        models.removeAll()
        updateDate()
        collectionView.reloadData()
        
        guard let index = findTodayModelIndex() else {
            return
        }
        let indexPath = IndexPath(item: index, section: 0)
        scroll(to: indexPath, selection: true)
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
            let dateProgress = getProgress?(date) ?? .future
            models.append(CalendarCellModel(date: date, progress: dateProgress))
            if let nexDate = calendar.date(byAdding: .day, value: Constants.calendarOffset, to: date) {
                date = nexDate
            }
        }
    }
    
    private func scroll(to indexPath: IndexPath, selection: Bool) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        models.first { $0.isSelected }?.setSelected(false)
        let model = models[indexPath.item]
        model.setSelected(selection)
        
        if selection {
            dateDidSelect?(model.date)
        }
    }
    
    private func findTodayModelIndex() -> Int? {
        guard
            let index = models.firstIndex(where: { Calendar.autoupdatingCurrent.compare($0.date, to: currentDate, toGranularity: .day) == .orderedSame })
        else {
            return nil
        }
        return index
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

