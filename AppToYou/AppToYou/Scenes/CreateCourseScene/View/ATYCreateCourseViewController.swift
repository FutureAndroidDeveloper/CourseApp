//
//  ATYCreateCourseViewController.swift
//  AppToYou
//
//  Created by Philip Bratov on 07.06.2021.
//  Copyright © 2021 QITTIQ. All rights reserved.
//

import UIKit

class ATYCreateCourseViewController: UIViewController {

    var viewModel : ATYUpCreateCourseViewModel
    private var imagePicker: ATYImagePicker?

    var typeCellSelect: TypeCell?
    var image : UIImage?

    var createCourseTableView = UITableView()
    var arr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.imagePicker = ATYImagePicker(presentationController: self, delegate: self)
    }

    init(interactionMode : ATYUpCreateCourseViewModel.InteractionMode) {
        self.viewModel = ATYUpCreateCourseViewModel(interactionMode: interactionMode)
        super.init(nibName: nil, bundle: nil)
        switch self.viewModel.interactionMode {
        case .create:
            self.title = "Создание нового курса"
        case .update:
            self.title = "Редактирование"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }

    private func configureTableView() {
        view.addSubview(createCourseTableView)
        createCourseTableView.separatorStyle = .none
        createCourseTableView.backgroundColor = R.color.backgroundAppColor()
        createCourseTableView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
        createCourseTableView.delegate = self
        createCourseTableView.dataSource = self
        createCourseTableView.register(ATYCreateTaskNameCell.self, forCellReuseIdentifier: ATYCreateTaskNameCell.reuseIdentifier)
        createCourseTableView.register(ATYCreateDescriptionTaskCell.self, forCellReuseIdentifier: ATYCreateDescriptionTaskCell.reuseIdentifier)
        createCourseTableView.register(ATYSelectPhotoCourse.self, forCellReuseIdentifier: ATYSelectPhotoCourse.reuseIdentifier)
        createCourseTableView.register(ATYRadioButtonCreateCourse.self, forCellReuseIdentifier: ATYRadioButtonCreateCourse.reuseIdentifier)
        createCourseTableView.register(ATYDurationCreateCourse.self, forCellReuseIdentifier: ATYDurationCreateCourse.reuseIdentifier)
        createCourseTableView.register(ATYCreateCourseChatCell.self, forCellReuseIdentifier: ATYCreateCourseChatCell.reuseIdentifier)
        createCourseTableView.register(ATYSaveTaskCell.self, forCellReuseIdentifier: ATYSaveTaskCell.reuseIdentifier)
        createCourseTableView.register(ATYDeleteCourseCell.self, forCellReuseIdentifier: ATYDeleteCourseCell.reuseIdentifier)
        createCourseTableView.register(ATYCategoryCourseCell.self, forCellReuseIdentifier: ATYCategoryCourseCell.reuseIdentifier)
    }

    private func configureNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = R.color.lineViewBackgroundColor()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        view.backgroundColor = R.color.backgroundAppColor()
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = false
    }
}

extension ATYCreateCourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return EnumCreateCourseCell.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch EnumCreateCourseCell.init(rawValue: indexPath.row) {
        case .nameCourse:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateTaskNameCell.reuseIdentifier, for: indexPath) as! ATYCreateTaskNameCell
            cell.nameLabel.text = "Название курса"
            cell.nameTextField.placeholder = "Например, ментальное здоровье"
            return cell
        case .descriptionCourse:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateDescriptionTaskCell.reuseIdentifier, for: indexPath) as! ATYCreateDescriptionTaskCell
            cell.nameLabel.text = "Описание курса"
            cell.placeholderLabel.text = "Опишите цели или преимущества вашего курса"
            return cell
        case .photoCourse:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYSelectPhotoCourse.reuseIdentifier, for: indexPath) as! ATYSelectPhotoCourse
            cell.nameLabel.text = "Обложка курса"
            cell.photoImageView.image = self.image ?? R.image.coursePhotoExample()
            cell.typeImageView.isHidden = cell.photoImageView.image == R.image.coursePhotoExample()
            return cell
        case .courseCategory:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYCategoryCourseCell.reuseIdentifier, for: indexPath) as! ATYCategoryCourseCell
            cell.massive = self.arr
            cell.collectionView.reloadData()
            cell.callBack = { [weak self] in
                let vc = ATYChooseCourseCategoryViewController(categories: self?.arr)
                vc.callBack = { [weak self] resultCategories in
                    self?.arr = resultCategories
                    self?.createCourseTableView.reloadData()
                }
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case .radioOpen, .radioClose, .radioNeedPay:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYRadioButtonCreateCourse.reuseIdentifier, for: indexPath) as! ATYRadioButtonCreateCourse
            switch EnumCreateCourseCell.init(rawValue: indexPath.row) {
            case .radioOpen:
                cell.labelHeader.isHidden = false
                cell.labelTypeCourse.text = "Открытый"
                cell.descriptionLabel.text = "Любой пользователь приложения может стать участником курса, выполнять его задачи и писать в общем чате"
                cell.typeCell = .open
            case .radioClose:
                cell.labelTypeCourse.text = "Закрытый"
                cell.descriptionLabel.text = "Лишь после одобрения заявки администратором курса, пользователь может стать его участником"
                cell.typeCell = .close
            case .radioNeedPay:
                cell.labelTypeCourse.text = "Платный"
                cell.descriptionLabel.text = "Лишь после оплаты курса, пользователь может стать его участником"
                cell.typeCell = .payment
            default: break
            }
            cell.radioButtonImageView.image = cell.typeCell == typeCellSelect ? R.image.selectedRadioButton() : R.image.unselectedRadioButton()
            cell.payForCourse.isHidden = !(cell.typeCell == typeCellSelect && typeCellSelect == .payment)
            cell.layoutSubviews()
            return cell
        case .durationCourse:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYDurationCreateCourse.reuseIdentifier, for: indexPath) as! ATYDurationCreateCourse
            return cell
        case .chatCourse:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateCourseChatCell.reuseIdentifier, for: indexPath) as! ATYCreateCourseChatCell
            return cell
        case  .deleteCourse:
            if self.viewModel.interactionMode == .update {
                let cell = tableView.dequeueReusableCell(withIdentifier: ATYDeleteCourseCell.reuseIdentifier, for: indexPath) as! ATYDeleteCourseCell
                return cell
            }
        case .saveCourse:
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYSaveTaskCell.reuseIdentifier, for: indexPath) as! ATYSaveTaskCell
            cell.saveButton.setTitle("Создать курс", for: .normal)
            return cell
        default: break
        }
        let cell = UITableViewCell()
        cell.backgroundColor = R.color.backgroundAppColor()
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let _ = createCourseTableView.cellForRow(at: indexPath) as? ATYSelectPhotoCourse {
            self.imagePicker?.present()
        }

        if let cell = createCourseTableView.cellForRow(at: indexPath) as? ATYRadioButtonCreateCourse {
            typeCellSelect = cell.typeCell
            createCourseTableView.reloadData()
        }
    }

}

extension ATYCreateCourseViewController: ATYImagePickerDelegate {
    func deleteCurrentImage() {
        self.image = nil
        createCourseTableView.reloadData()
    }

    func showCurrentImage() {
        if let image = self.image {
            let presentingViewController = ATYDetailImageViewController(image: image)
            present(presentingViewController, animated: true)
        }
    }

    func didSelect(image: UIImage?, withPath path: String?) {
        if let newImage = image {
            self.image = newImage
            createCourseTableView.reloadData()
        }
    }
}
