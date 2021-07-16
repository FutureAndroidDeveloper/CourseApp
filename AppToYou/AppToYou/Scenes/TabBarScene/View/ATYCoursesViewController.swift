//
//  ATYCoursesViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 25.05.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYCoursesViewController : UIViewController {

    enum CreateCellCourses: Int, CaseIterable {
        case courseBar
        case courseTasks
    }

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundAppColor()
        configureNavBar()
        configureTableView()
        self.tableView.contentInsetAdjustmentBehavior = .never
    }

    private func configureNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        view.backgroundColor = R.color.backgroundAppColor()
        tableView.backgroundColor = R.color.backgroundAppColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ATYCreateCourseCell.self, forCellReuseIdentifier: ATYCreateCourseCell.reuseIdentifier)
        tableView.register(ATYSearchBarCell.self, forCellReuseIdentifier: ATYSearchBarCell.reuseIdentifier)
        tableView.register(ATYCollectionViewTypeCourseTableCell.self, forCellReuseIdentifier: ATYCollectionViewTypeCourseTableCell.reuseIdentifier)
        tableView.register(ATYCourseTableViewCell.self, forCellReuseIdentifier: ATYCourseTableViewCell.reuseIdentifier)
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

extension ATYCoursesViewController : UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 && indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateCourseCell.reuseIdentifier, for: indexPath) as! ATYCreateCourseCell
            cell.createCourseCallback = { [weak self] in
                let vc = ATYCreateCourseViewController(interactionMode: .create)
                vc.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: ATYCourseTableViewCell.reuseIdentifier, for: indexPath) as! ATYCourseTableViewCell

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

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return section == 1 ? ATYSearchBarCollectionView() : nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 350
        }
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ATYAboutCourseViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}



