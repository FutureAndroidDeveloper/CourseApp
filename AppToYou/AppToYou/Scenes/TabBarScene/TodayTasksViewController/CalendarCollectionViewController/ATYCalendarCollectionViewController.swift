//
//  ATYCalendarCollectionView.swift
//  AppToYou
//
//  Created by Philip Bratov on 25.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYCalendarCollectionViewController: UICollectionViewController {

    var selectedDateForView = Date()

    var dateCallback : ((String) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ATYCalendarCollectionViewCell.self, forCellWithReuseIdentifier: ATYCalendarCollectionViewCell.reuseIdentifier)
//        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        view.backgroundColor = R.color.backgroundAppColor()
        collectionView.backgroundColor = R.color.backgroundAppColor()
        print("viewDidLoad")

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        print("viewDidAppear")

    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        print("viewWillAppear")

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollToDate(date: Date())
    }

    func updateData() {
        scrollToDate(date: Date())
    }

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func selectCell(cell: ATYCalendarCollectionViewCell) {
        if let selectedCellDate = cell.date {
//            displayDate(date: selectedCellDate)
        }
    }

//    func displayDate(date: Date) {
//        UsedDates.shared.displayedDate = date
//        UsedDates.shared.selectdDayOfWeek = Calendar.current.component(.weekday, from: date) //so that if the selected date is Wednesday, it keeps selecting Wednesday next week
//        print(UsedDates.shared.displayedDateString)
//    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9999
    }

    func scrollToDate(date: Date)
    {
//        print("will scroll to today")
//        let startDate = Date()
//        let cal = Calendar.current
//        if let numberOfDays = cal.dateComponents([.day], from: startDate, to: date).day {
//            let extraDays: Int = numberOfDays % 7 // will = 0 for Mondays, 1 for Tuesday, etc ..
//            let scrolledNumberOfDays = numberOfDays - extraDays
//            let firstMondayIndexPath = IndexPath(row: scrolledNumberOfDays, section: 0)
//            collectionView.scrollToItem(at: firstMondayIndexPath, at: .left , animated: false)
//        }
//        displayDate(date: date)
    }

    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        displayWeek()
    }

    func displayWeek() {
        var visibleCells = collectionView.visibleCells
        visibleCells.sort { (cell1: UICollectionViewCell, cell2: UICollectionViewCell) -> Bool in
            guard let cell1 = cell1 as? ATYCalendarCollectionViewCell else {
                return false
            }
            guard let cell2 = cell2 as? ATYCalendarCollectionViewCell else {
                return false
            }
            let result = cell1.date!.compare(cell2.date!)
            return result == ComparisonResult.orderedAscending

        }
        let middleIndex = visibleCells.count / 2
        let middleCell = visibleCells[middleIndex] as! ATYCalendarCollectionViewCell

//        let displayedDate = UsedDates.shared.getDateOfAnotherDayOfTheSameWeek(selectedDate: middleCell.date!, requiredDayOfWeek: UsedDates.shared.selectdDayOfWeek)
//        displayDate(date: displayedDate)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let addedDays = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ATYCalendarCollectionViewCell.reuseIdentifier, for: indexPath) as! ATYCalendarCollectionViewCell

        var addedDaysDateComp = DateComponents()
        addedDaysDateComp.day = addedDays//calculating the date of the given cell
        let currentCellDate = Calendar.current.date(byAdding: addedDaysDateComp , to: Date())

        if let cellDate = currentCellDate {
            cell.date = cellDate

            let dayOfMonth = Calendar.current.component(.day, from: cellDate)
            cell.dayOfMonthLabel.text = String(describing: dayOfMonth)

            let dayOfWeek = Calendar.current.component(.weekday, from: cellDate)
            cell.dayOfWeekLabel.text = ""

        }

        cell.setUpAnother(indexPath: indexPath)

        if Calendar.current.compare(cell.date!, to: Date(), toGranularity: .day) == .orderedSame {
            cell.circleView.backgroundColor = R.color.textColorSecondary()
        }

        if Calendar.current.compare(cell.date!, to: selectedDateForView, toGranularity: .day) == .orderedSame {
            cell.setUp()
            print(cell.date!)
            print(selectedDateForView)
        }

        if cell.date ?? Date() > Date() {
            cell.circleView.isHidden = true
        } else {
            cell.circleView.isHidden = false
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ATYCalendarCollectionViewCell {
            if cell.date ?? Date() > Date() {
                return
            }
//            UsedDates.shared.displayedDate = cell.date!
//            selectedDateForView = cell.date!
//            UsedDates.shared.selectdDayOfWeek = Calendar.current.component(.weekday, from: cell.date!)
//            print("Selected Date: \(UsedDates.shared.displayedDateString)")
//            dateCallback?(UsedDates.shared.displayedDateString)
//            collectionView.reloadData()
        }
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

