//
//  CourseVC.swift
//  LearnConnect
//
//  Created by Ebuzer Şimşek on 22.11.2024.
//

import UIKit
import AVKit
import SwiftUI

class CourseViewController: UIViewController {
    
    var selectedCourse: Course?
    
    private let videoTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "VideoCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = selectedCourse?.title
        
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(videoTableView)
        
        videoTableView.delegate = self
        videoTableView.dataSource = self
        
        NSLayoutConstraint.activate([
            videoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            videoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCourse?.videos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath)
        
        let video = selectedCourse?.videos[indexPath.row]
        cell.textLabel?.text = video?.title
        cell.detailTextLabel?.text = video?.description
        
        return cell
    }
}
