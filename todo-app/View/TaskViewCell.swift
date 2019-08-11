//
//  TaskViewCell.swift
//  todo-app
//
//  Created by Panupong Kukutapan on 1/8/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import UIKit

class TaskViewCell: UITableViewCell {

    var viewModel: TaskListViewModelType! {
        didSet {
            setHeaderText(with: viewModel.output.titleText, completed: viewModel.output.completed)
            setTimeAgoText(with: viewModel.output.amountOfTimeText)
        }
    }
    
    let headerText: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        return lb
    }()
    
    let timeAgoText: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textColor = UIColor.lightGray
        lb.numberOfLines = 2
        lb.textAlignment = NSTextAlignment.center
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        
        setHeaderText(with: "This is header", completed: false)
        setTimeAgoText(with: "2 Weeks ")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set up
    
    private func setupView() {
        backgroundColor = .clear
        
        //MARK: Enable Auto Layout
        headerText.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerText)
        
        timeAgoText.translatesAutoresizingMaskIntoConstraints = false
        addSubview(timeAgoText)
        
        let constraints = [
            //MARK: TimeAgoText
            timeAgoText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            timeAgoText.centerYAnchor.constraint(equalTo: centerYAnchor),
            timeAgoText.widthAnchor.constraint(equalToConstant: 64),
            
            //MARK: HeaderText
            headerText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerText.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerText.trailingAnchor.constraint(equalTo: timeAgoText.leadingAnchor, constant: 16)
        
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    //MARK: - Helper
    
    private func setHeaderText(with text: String, completed hasStrikethrough: Bool) {
        let attribute = NSAttributedString(string: text, attributes: [NSAttributedString.Key.strikethroughStyle: hasStrikethrough])
        headerText.attributedText = attribute
    }
    
    private func setTimeAgoText(with dateString: String) {
        timeAgoText.text = "\(dateString)\nago"
    }
    
    // MARK: - ViewModel
    
}
