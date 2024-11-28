//
//  CourseCategoryView.swift
//  LearnConnect
//
//  Created by Ebuzer Şimşek on 27.11.2024.
//

import UIKit

class CourseCategoryView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()
    
    private var categoryButtons: [UIButton] = []
    
    var selectedCategory: String = "All" {
        didSet {
            updateSelectedCategory()
        }
    }
    
    var categories: [String] = ["All", "Mat", "Fizik", "Kimya"] {
        didSet {
            setupCategoryButtons()
        }
    }
    
    var categoryChanged: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        setupCategoryButtons()
    }
    
    private func setupCategoryButtons() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        categoryButtons.removeAll()
        
        for category in categories {
            let button = UIButton(type: .system)
            button.setTitle(category, for: .normal)
            button.setTitleColor(category == selectedCategory ? .black : .white, for: .normal) // Text color
            button.titleLabel?.font = .systemFont(ofSize: 14, weight: category == selectedCategory ? .bold : .regular)
            button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
            button.layer.cornerRadius = 20
            button.layer.borderWidth = 1.0
            button.layer.borderColor = category == selectedCategory ? UIColor.black.cgColor : UIColor.white.cgColor // Border color
            button.backgroundColor = category == selectedCategory ? .white : .black // Background color
            button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
            categoryButtons.append(button)
        }
    }
    
    @objc private func categoryButtonTapped(_ sender: UIButton) {
        guard let index = categoryButtons.firstIndex(of: sender) else { return }
        selectedCategory = categories[index]
        categoryChanged?(selectedCategory)
    }
    
    private func updateSelectedCategory() {
        for (index, button) in categoryButtons.enumerated() {
            button.setTitleColor(categories[index] == selectedCategory ? .black : .white, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14, weight: categories[index] == selectedCategory ? .bold : .regular)
            button.backgroundColor = categories[index] == selectedCategory ? .white : .black
            button.layer.borderColor = categories[index] == selectedCategory ? UIColor.black.cgColor : UIColor.white.cgColor
        }
    }
}
