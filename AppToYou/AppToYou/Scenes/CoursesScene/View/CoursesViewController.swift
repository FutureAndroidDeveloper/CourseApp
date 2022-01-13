import UIKit


class CoursesViewController: UIViewController, BindableType {
    
    private struct Constants {
        static let bottomLoadingSpinnerHeight: CGFloat = 44
    }
    
    enum CreateCellCourses: Int, CaseIterable {
        case courseBar
        case courseTasks
    }
    
    var viewModel: CoursesViewModel!

    private var courses = [CourseResponse]()
    private var imageModels = [CourseCellModel]()
    private var loadingNewPage = false
    // TODO: - что за флаг
    var flag = true

    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private lazy var endLoadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.frame = CGRect(x: .zero, y: .zero, width: tableView.bounds.width, height: Constants.bottomLoadingSpinnerHeight)
        spinner.startAnimating()
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundAppColor()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.contentInsetAdjustmentBehavior = .never
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        view.backgroundColor = R.color.backgroundAppColor()
        tableView.backgroundColor = R.color.backgroundAppColor()
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.register(ATYCreateCourseCell.self, forCellReuseIdentifier: ATYCreateCourseCell.reuseIdentifier)
        tableView.register(ATYCollectionViewTypeCourseTableCell.self, forCellReuseIdentifier: ATYCollectionViewTypeCourseTableCell.reuseIdentifier)
        tableView.register(CourseCell.self, forCellReuseIdentifier: CourseCell.reuseIdentifier)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func bindViewModel() {
        viewModel.input.refresh()
        viewModel.output.coursesBatch.bind { [weak self] batch in
            guard let self = self else {
                return
            }
            
            if batch.count == .zero {
                self.tableView.tableFooterView = nil
            }
            
            self.refreshControl.endRefreshing()
            self.tableView.tableFooterView = nil
            self.loadingNewPage = false
            
            let start = self.courses.count
            let end = self.courses.count + batch.count
            
            
            self.tableView.performBatchUpdates {
                let newImageModels = batch.map { CourseCellModel(course: $0) }
                self.imageModels.append(contentsOf: newImageModels)
                self.courses.append(contentsOf: batch)
                
                let indexPaths = (start..<end).map { IndexPath(row: $0, section: 1) }
                self.tableView.insertRows(at: indexPaths, with: .automatic)
            }
        }
    }
    
    @objc
    private func refresh(_ sender: AnyObject) {
        courses.removeAll()
        imageModels.removeAll()
        tableView.reloadData()
        viewModel.input.refresh()
    }
    
    private func downloadCourseImage(_ indexPath: IndexPath) {
        let imageModel = imageModels[indexPath.row]
        viewModel.input.downloadCourseImages(for: imageModel)
    }
    
    private func cancelCourseImageLoading(_ indexPath: IndexPath) {
        let imageModel = imageModels[indexPath.row]
        viewModel.input.closeCourseImagesDowloading(for: imageModel)
    }
    
}

extension CoursesViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach(downloadCourseImage(_:))
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach(cancelCourseImageLoading(_:))
    }
    
}


extension CoursesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height, !loadingNewPage {
            print("THE you reached end of the table")
            loadingNewPage = true
            tableView.tableFooterView = endLoadingSpinner
            viewModel.input.loadMore()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : courses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 && indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ATYCreateCourseCell.reuseIdentifier, for: indexPath) as! ATYCreateCourseCell
            cell.createCourseCallback = { [weak self] in
                self?.viewModel.input.createDidTapped()
            }
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: CourseCell.reuseIdentifier, for: indexPath) as! CourseCell
        let imageModel = imageModels[indexPath.row]
        cell.configure(with: imageModel)
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ATYSearchBarCollectionView(flag: self.flag, frame: .zero)
        header.callbackErrorThree = { [weak self] in
            self?.showAlertCountSelectedCourseCategory(text: "Для выбора доступно максимум 3 категории!")
        }
        header.firstCallback = { [weak self] in
            self?.flag = true
            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            self?.tableView.reloadData()
        }

        header.secondCallback = { [weak self] in
            self?.flag = false
            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            self?.tableView.reloadData()
        }

        header.searchTextCallback = { [weak self] text in
            print(text)
        }
        return section == 1 ? header : nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = tableView.cellForRow(at: indexPath) as? CourseCell else {
            return
        }
        
        let model = courses[indexPath.row]
        switch model.courseType {
        case .PUBLIC:
            break
        case .PRIVATE:
            break
        case .PAID:
            break
        }
    }
    
}



