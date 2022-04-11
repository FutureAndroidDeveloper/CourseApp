import UIKit


class CoursesViewController: UIViewController, BindableType, CourseSearchDelegate {
    private struct Constants {
        static let bottomLoadingSpinnerHeight: CGFloat = 44
    }
    
    var viewModel: CoursesViewModel!
    
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    
    private lazy var searchView: UIView = {
        let coursesSearchView = CourseSearchView(filterModel: viewModel.output.filterModel)
        coursesSearchView.delegate = self
        return coursesSearchView
    }()
    
    private lazy var endLoadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.frame = CGRect(x: .zero, y: .zero, width: tableView.bounds.width, height: Constants.bottomLoadingSpinnerHeight)
        spinner.startAnimating()
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureContainer()
    }
    
    private func setup() {
        searchView.backgroundColor = R.color.backgroundAppColor()
        view.backgroundColor = R.color.backgroundAppColor()
        tableView.backgroundColor = R.color.backgroundAppColor()
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }
    
    private func configureContainer() {
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func configure() {
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.prefetchDataSource = self
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ATYCreateCourseCell.self, forCellReuseIdentifier: ATYCreateCourseCell.reuseIdentifier)
        tableView.register(CourseCell.self, forCellReuseIdentifier: CourseCell.reuseIdentifier)
    }
    
    func bindViewModel() {
        viewModel.output.isLoading.bind { [weak self] isLoading in
            self?.tableView.tableFooterView = isLoading ? self?.endLoadingSpinner : nil
        }
        
        viewModel.output.clearCourses.bind { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.output.coursesBatch.bind { [weak self] batch in
            guard let self = self else {
                return
            }
            let start = self.viewModel.output.models.count - batch.count
            let end = self.viewModel.output.models.count
            self.refreshControl.endRefreshing()
            
            self.tableView.performBatchUpdates {
                let indexPaths = (start..<end).map { IndexPath(row: $0, section: 1) }
                self.tableView.insertRows(at: indexPaths, with: .automatic)
            }
        }
    }
    
    func searchText(_ text: String) {
        viewModel.input.searchTextDidChange(text)
    }
    
    @objc
    private func refresh(_ sender: AnyObject) {
        viewModel.input.refresh()
    }
    
    private func downloadCourseImage(_ indexPath: IndexPath) {
        guard !viewModel.output.models.isEmpty else {
            return
        }
        let model = viewModel.output.models[indexPath.row]
        viewModel.input.downloadCourseImages(for: model)
    }
    
    private func cancelCourseImageLoading(_ indexPath: IndexPath) {
        guard !viewModel.output.models.isEmpty else {
            return
        }
        let model = viewModel.output.models[indexPath.row]
        viewModel.input.closeCourseImagesDowloading(for: model)
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
        
        if distanceFromBottom < height, !viewModel.output.isLoading.value {
            viewModel.input.loadMore()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : viewModel.output.models.count
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
        let model = viewModel.output.models[indexPath.row]
        cell.configure(with: model)
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let container = UIView()
        container.backgroundColor = .clear
        container.addSubview(searchView)
        searchView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0))
        }
        return section == 1 ? container : nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = tableView.cellForRow(at: indexPath) as? CourseCell else {
            return
        }
        
        let model = viewModel.output.models[indexPath.row]
        viewModel.input.previewCourse(model.course)
//        switch model.course.courseType {
//        case .PUBLIC:
//            break
//        case .PRIVATE:
//            break
//        case .PAID:
//            break
//        }
    }
    
}
