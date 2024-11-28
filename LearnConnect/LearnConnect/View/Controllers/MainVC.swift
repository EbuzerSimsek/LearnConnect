//
//  MainVC.swift
//  LearnConnect
//
//  Created by Ebuzer Şimşek on 22.11.2024.
//

import UIKit
import SwiftUI
import FirebaseFirestore

class MainViewController: UIViewController {
    
    private let viewModel = MainViewModel()
    
    private lazy var courseCategoryView: CourseCategoryView = {
        let view = CourseCategoryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.categoryChanged = { [weak self] selectedCategory in
            self?.viewModel.filterCourses(by: selectedCategory)
        }
        return view
    }()
    
    private let courseTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CourseTableViewCell.self, forCellReuseIdentifier: "CourseCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Courses"
        navigationItem.hidesBackButton = true
        courseTableView.backgroundColor = .systemBackground
        view.backgroundColor = .black
        
        setupViews()
        setupTableView()
        bindViewModel()
        applyTheme()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applyTheme()
    }
    
    private func applyTheme() {
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        overrideUserInterfaceStyle = isDarkMode ? .dark : .light
    }
    
    private func setupViews() {
        view.addSubview(courseCategoryView)
        NSLayoutConstraint.activate([
            courseCategoryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            courseCategoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            courseCategoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            courseCategoryView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupTableView() {
        view.addSubview(courseTableView)
        courseTableView.delegate = self
        courseTableView.dataSource = self
        NSLayoutConstraint.activate([
            courseTableView.topAnchor.constraint(equalTo: courseCategoryView.bottomAnchor, constant: 16),
            courseTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            courseTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            courseTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onCoursesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.courseTableView.reloadData()
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCourses
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as? CourseTableViewCell else {
            fatalError("Unable to dequeue CourseTableViewCell")
        }
        
        let course = viewModel.course(at: indexPath.row)
        cell.configure(with: course)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hostingController = UIHostingController(
            rootView: CourseView(selectedCourse: viewModel.course(at: indexPath.row)))
        hostingController.modalPresentationStyle = .fullScreen
        hostingController.navigationItem.hidesBackButton = true
        self.present(hostingController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 
    }
}
