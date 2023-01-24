//
//  ATYWalletHistoryViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 04.08.2021.
//  Copyright © 2021 .... All rights reserved.
//

import UIKit

enum CurrencyMoney {
    case coin
    case diamond
}

struct CoursePayHistory {
    let date : String
    let achievement : String
    let howMuchCost : Int
    let currencyMoney : CurrencyMoney
}

class ATYWalletHistoryViewController : UIViewController {
    let tableView = UITableView()

    let coursesArray = [CoursePayHistory(date: "Сегодня", achievement: "Оплата штрафа", howMuchCost: -85, currencyMoney: .coin),
                        CoursePayHistory(date: "Вчера", achievement: "Оплата курса «Спортивное тело навсегда»", howMuchCost: -85, currencyMoney: .coin),
                        CoursePayHistory(date: "21 мая 21", achievement: "Достижение «Боец»", howMuchCost: 155, currencyMoney: .diamond),
                        CoursePayHistory(date: "Вчера", achievement: "Оплата штрафа", howMuchCost: 133, currencyMoney: .coin),
                        CoursePayHistory(date: "23 июня 20", achievement: "Достижение «Маньяк»", howMuchCost: 121, currencyMoney: .diamond),
                        CoursePayHistory(date: "Вчера", achievement: "Оплата штрафа", howMuchCost: -1001, currencyMoney: .diamond),
                        CoursePayHistory(date: "Сегодня", achievement: "Достижение «Мастер»", howMuchCost: 98, currencyMoney: .coin),
                        CoursePayHistory(date: "2 июня 20", achievement: "Достижение «Красава»", howMuchCost: -500, currencyMoney: .coin),
                        CoursePayHistory(date: "Сегодня", achievement: "Достижение «Начальник»", howMuchCost: -200, currencyMoney: .diamond),
                        CoursePayHistory(date: "23 июня 20", achievement: "Достижение «Красава»", howMuchCost: -3620, currencyMoney: .coin),
                        CoursePayHistory(date: "Вчера", achievement: "Достижение «Начальник»", howMuchCost: -4512, currencyMoney: .diamond),
                        CoursePayHistory(date: "Вчера", achievement: "Достижение «Красава»", howMuchCost: -20, currencyMoney: .diamond),
                        CoursePayHistory(date: "Сегодня", achievement: "Достижение «Начальник»", howMuchCost: 98, currencyMoney: .diamond),
                        CoursePayHistory(date: "Сегодня", achievement: "Достижение «Красава», Оплата курса «Спортивное тело навсегда», «Спортивное тело навсегда»", howMuchCost: 151, currencyMoney: .coin),
                        CoursePayHistory(date: "13 июня 20", achievement: "Достижение «Красава»", howMuchCost: 223, currencyMoney: .coin),
                        CoursePayHistory(date: "Сегодня", achievement: "Достижение «Мастер»", howMuchCost: 672, currencyMoney: .diamond),
                        CoursePayHistory(date: "18 июня 20", achievement: "Достижение «Красава»", howMuchCost: 731, currencyMoney: .coin),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    convenience init(name: String) {
        self.init(title: name)
    }

    convenience init(title: String) {
        self.init(titles: title)
    }

    init(titles: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = titles
        view.backgroundColor = R.color.backgroundAppColor()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        view.addSubview(tableView)
        tableView.backgroundColor = R.color.backgroundAppColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ATYHistoryPayTableViewCell", bundle: nil), forCellReuseIdentifier: ATYHistoryPayTableViewCell.reuseIdentifier)
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}

extension ATYWalletHistoryViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coursesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ATYHistoryPayTableViewCell.reuseIdentifier, for: indexPath) as! ATYHistoryPayTableViewCell
        let item = coursesArray[indexPath.row]
        cell.setUp(dateName: item.date, achievementName: item.achievement, cost: item.howMuchCost, coinOrDiamond: item.currencyMoney)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
