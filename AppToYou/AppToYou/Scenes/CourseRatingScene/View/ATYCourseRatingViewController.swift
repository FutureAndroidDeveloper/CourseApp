//
//  ATYCourseRatingViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 05.08.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit
import SHSearchBar

struct ATYCourseRatingParticipant {
    var image: UIImage?
    var name: String
    var countDays: Int
    var percentage: Int
    var isAdmin: Bool = false
    var position : Int = 0
}

class ATYCourseRatingViewController : UIViewController {

    var searchBar : SHSearchBar!

    var courseParticipantArray : [ATYCourseRatingParticipant] = [
        ATYCourseRatingParticipant(image: R.image.courseParticipantImage(), name: "Ксюша Борзова", countDays: 14, percentage: 82),
        ATYCourseRatingParticipant(image: R.image.human1(), name: "Наташа Сафонова", countDays: 23, percentage: 100),
        ATYCourseRatingParticipant(image: nil, name: "Саша Козлов", countDays: 27, percentage: 99),
        ATYCourseRatingParticipant(image: R.image.human2(), name: "Паша Великий", countDays: 9, percentage: 23),
        ATYCourseRatingParticipant(image: R.image.human3(), name: "Егор Драгель", countDays: 18, percentage: 45),
        ATYCourseRatingParticipant(image: R.image.courseParticipantImage(), name: "Антон Великоборец", countDays: 21, percentage: 52),
        ATYCourseRatingParticipant(image: R.image.human4(), name: "Кирилл Петров", countDays: 13, percentage: 21, isAdmin: true),
        ATYCourseRatingParticipant(image: nil, name: "Андрей Титов", countDays: 18, percentage: 78),
        ATYCourseRatingParticipant(image: R.image.human5(), name: "Валя Кремль", countDays: 19, percentage: 54),
        ATYCourseRatingParticipant(image: nil, name: "Андрей Горохов", countDays: 28, percentage: 99),
        ATYCourseRatingParticipant(image: R.image.human1(), name: "Паша Соколов", countDays: 27, percentage: 95),
        ATYCourseRatingParticipant(image: R.image.human2(), name: "Наташа Крифывфывфывцова", countDays: 11, percentage: 25)]

    var filteredArray = [ATYCourseRatingParticipant]()

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        courseParticipantArray.sort(by: { $0.percentage > $1.percentage })
        for position in 0..<courseParticipantArray.count {
            courseParticipantArray[position].position = position + 1
        }
        filteredArray = courseParticipantArray
        configure()
        configureNavBar()
    }

    //MARK:- Configure UI

    private func configureNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = R.color.lineViewBackgroundColor()
        view.backgroundColor = R.color.backgroundAppColor()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.setBackgroundImage(nil, for:.default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = false
        self.navigationController?.navigationBar.setValue(false, forKey: "hidesShadow")
        navigationController?.navigationBar.barTintColor = R.color.backgroundTextFieldsColor()
        self.navigationItem.title = "Рейтинг курса"
    }

    private func configure() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = R.color.backgroundAppColor()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ATYRatingCourseParticipantCell", bundle: nil), forCellReuseIdentifier: ATYRatingCourseParticipantCell.reuseIdentifier)
        tableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            make.bottom.equalToSuperview()
        }
    }
}

extension ATYCourseRatingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredArray.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let rasterSize: CGFloat = 10.0
        let leftView1 = imageViewWithIcon(R.image.searchImage()!, raster: rasterSize)

        let searchBar = defaultSearchBar(withRasterSize: rasterSize,
                                      leftView: leftView1,
                                      rightView: nil,
                                      delegate: self, placeholder: "Поиск среди участников курса")
        view.backgroundColor = R.color.backgroundAppColor()
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(47)
        }
        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ATYRatingCourseParticipantCell.reuseIdentifier, for: indexPath) as! ATYRatingCourseParticipantCell
        let item = filteredArray[indexPath.row]
        cell.setUp(image: item.image, position: item.position, percentage: item.percentage, days: item.countDays, name: item.name, isAdmin: item.isAdmin)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ATYProgressParticipantViewController()
        let item = courseParticipantArray[indexPath.row]
        vc.name = item.name
        vc.image = item.image
        vc.daysCount = item.countDays

        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ATYCourseRatingViewController: SHSearchBarDelegate {
    func searchBar(_ searchBar: SHSearchBar, textDidChange text: String) {
        self.filteredArray = self.courseParticipantArray.filter { $0.name.range(of: text , options: .caseInsensitive) != nil }
        if text == "" {
            self.filteredArray = self.courseParticipantArray
        }

        if self.filteredArray.isEmpty {
            self.tableView.setNoDataPlaceholder("Пользователи не найдены")
        }
        else {
            self.tableView.removeNoDataPlaceholder()
        }
        self.tableView.reloadData()
    }
}
