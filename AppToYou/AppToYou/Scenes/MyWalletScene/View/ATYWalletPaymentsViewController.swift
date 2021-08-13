//
//  ATYWalletPaymentsViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 04.08.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYWalletPaymentsViewController : UIViewController {

    let tableView = UITableView()

    let coursesArray = [1,2,3,4,5,6,7,8]

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
        tableView.register(UINib(nibName: "ATYPayWalletTableViewCell", bundle: nil), forCellReuseIdentifier: ATYPayWalletTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: "ATYStatisticPayOnCourseCell", bundle: nil), forCellReuseIdentifier: ATYStatisticPayOnCourseCell.reuseIdentifier)
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

extension ATYWalletPaymentsViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.coursesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYPayWalletTableViewCell.reuseIdentifier, for: indexPath) as! ATYPayWalletTableViewCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: ATYStatisticPayOnCourseCell.reuseIdentifier, for: indexPath) as! ATYStatisticPayOnCourseCell
        print("Download Started")
        if let url = URL(string: "https://klike.net/uploads/posts/2020-04/1587719823_10.jpg") {
            self.getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print("Download Finished")
                DispatchQueue.main.async() {
                    cell.imageViewCourse.image = UIImage(data: data)
                }
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = R.color.backgroundAppColor()
        label.text = "Статистика заработка на курсах"
        label.textColor = R.color.titleTextColor()
        label.font = UIFont.systemFont(ofSize: 15)

        let view = UIView()
        view.frame = CGRect(origin: .zero, size: .zero)
        return section == 1 ? label : view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 40 : 0
    }
}
