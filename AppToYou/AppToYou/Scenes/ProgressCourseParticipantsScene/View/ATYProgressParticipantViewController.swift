//
//  ATYProgressParticipantViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 23.07.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

struct TemporaryCourseUserProgress {
    var nameTask = ""
    var period = ""
    var countDur: String? = ""
    var succesTasks = ""
    var failedTasks = ""
    var hasSanction = false
}

class ATYProgressParticipantViewController : UIViewController {

    let tableView = UITableView()

    //Temporary data
    var name = ""
    var image: UIImage?
    var daysCount = 0
    
    let array = [TemporaryCourseUserProgress(nameTask: "Зарядка",
                                             period: "каждый день",
                                             countDur: nil,
                                             succesTasks: "25",
                                             failedTasks: "5"),
                 TemporaryCourseUserProgress(nameTask: "Медитация",
                                             period: "каждый день",
                                             countDur: nil,
                                             succesTasks: "23",
                                             failedTasks: "7",
                                             hasSanction: true),
                 TemporaryCourseUserProgress(nameTask: "Выпить бутылочку рома",
                                             period: "каждый день",
                                             countDur: "5 раз",
                                             succesTasks: "20",
                                             failedTasks: "100"),
                 TemporaryCourseUserProgress(nameTask: "Прогулка",
                                             period: "по пятницам",
                                             countDur: nil,
                                             succesTasks: "2",
                                             failedTasks: "2"),
                 TemporaryCourseUserProgress(nameTask: "Хорошее за день",
                                             period: "каждый день",
                                             countDur: "700 симв.",
                                             succesTasks: "0",
                                             failedTasks: "0"),
                 TemporaryCourseUserProgress(nameTask: "Велотренировка",
                                             period: "пн, ср, пт",
                                             countDur: nil,
                                             succesTasks: "2",
                                             failedTasks: "11",
                                             hasSanction: true),
                 TemporaryCourseUserProgress(nameTask: "Гребля",
                                             period: "каждый день",
                                             countDur: "2 км",
                                             succesTasks: "23",
                                             failedTasks: "15"),
                 TemporaryCourseUserProgress(nameTask: "Чтение книги",
                                             period: "каждый день",
                                             countDur: "50 стр.",
                                             succesTasks: "33",
                                             failedTasks: "2"),
                 TemporaryCourseUserProgress(nameTask: "Прыжки на скакалке",
                                             period: "пн, пт",
                                             countDur: "100 раз",
                                             succesTasks: "0",
                                             failedTasks: "0",
                                             hasSanction: true)]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavBar()
    }

    private func configureTableView() {
        view.addSubview(tableView)
        view.backgroundColor = R.color.backgroundAppColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        tableView.backgroundColor = R.color.backgroundAppColor()
        tableView.separatorStyle = .none
        tableView.backgroundColor = R.color.backgroundAppColor()
        tableView.register(UINib(nibName: "ATYProgressInfoTableViewCell", bundle: nil), forCellReuseIdentifier: ATYProgressInfoTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: "ATYProgressTaskCourseUserCell", bundle: nil), forCellReuseIdentifier: ATYProgressTaskCourseUserCell.reuseIdentifier)
        tableView.register(UINib(nibName: "ATYAnotherCourseUserCell", bundle: nil), forCellReuseIdentifier: ATYAnotherCourseUserCell.reuseIdentifier)
        tableView.register(ATYRatingCourseCell.self, forCellReuseIdentifier: ATYRatingCourseCell.reuseIdentifier)
    }

    //MARK:- Configure UI

    private func configureNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = R.color.lineViewBackgroundColor()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.setBackgroundImage(nil, for:.default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = false
        self.navigationItem.title = name
    }
}

extension ATYProgressParticipantViewController : UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count + 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYProgressInfoTableViewCell.reuseIdentifier, for: indexPath) as! ATYProgressInfoTableViewCell
            cell.iconImageView.image = self.image ?? UIImage(withLettersFromName: self.name)
            cell.countDaysOnCourse.text = "На курсе \(self.daysCount) дней"
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYRatingCourseCell.reuseIdentifier, for: indexPath) as! ATYRatingCourseCell
            return cell
        }

        if indexPath.row == array.count + 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYAnotherCourseUserCell.reuseIdentifier, for: indexPath) as! ATYAnotherCourseUserCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: ATYProgressTaskCourseUserCell.reuseIdentifier, for: indexPath) as! ATYProgressTaskCourseUserCell
        let item = array[indexPath.row - 2]
        cell.setUp(nameTask: item.nameTask,
                   period: item.period,
                   countDuration: item.countDur,
                   numberOfTask: indexPath.row - 1,
                   succesTasks: item.succesTasks,
                   failedTasks: item.failedTasks,
                   hasSanction: item.hasSanction)
        cell.backgroundColor = indexPath.row % 2 == 0 ? R.color.backgroundTextFieldsColor() : R.color.backgroundAppColor()
        return cell
    }
}
