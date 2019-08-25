//
//  TaskViewController.swift
//  todo-app
//
//  Created by Panupong Kukutapan on 3/8/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
    
    let timeCreatedLabel: UILabel = {
        let lb = UILabel()
        lb.text = "3/8/2019 4:56 PM"
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textColor = UIColor.lightGray
        return lb
    }()
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Title"
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        return lb
    }()
    
    let titleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Title"
        tf.text = ""
        tf.borderStyle = UITextField.BorderStyle.line
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1.5
        tf.layer.cornerRadius = 5
        tf.layer.masksToBounds = true
        tf.bounds.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        return tf
    }()
    
    let detailLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Detail"
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        return lb
    }()
    
    let detailTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.layer.borderWidth = 1.5
        tv.layer.cornerRadius = 5
        tv.layer.masksToBounds = true
        tv.font = UIFont.systemFont(ofSize: 16)
        return tv
    }()
    
    let createButton: UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.backgroundColor = Colors.BlueSteel
        bt.setTitle("CREATE", for: UIControl.State.normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        bt.setTitleColor(.white, for: UIControl.State.normal)
        bt.alpha = 0
        bt.addTarget(self, action: #selector(handleCreateOrEdit), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    
    var viewModel: TaskViewViewModelType? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        setupNav()
        
        setupViewModel()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var inputAccessoryView: UIView? {
        createButton.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 42)
        return createButton
    }
    
    //MARK: - Set up
    
    private func setupView() {
        view.backgroundColor = .white
        
        timeCreatedLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeCreatedLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleTextField)
        
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailLabel)
        
        detailTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailTextView)
        
        
        let constraints = [
            timeCreatedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            timeCreatedLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            titleLabel.topAnchor.constraint(equalTo: timeCreatedLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            
            detailLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            detailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            detailTextView.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 8),
            detailTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            detailTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            detailTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300-48-16)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupNav() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupViewModel() {
        if viewModel == nil {
            viewModel = TaskViewViewModel(database: Database(), editingTask: nil)
        }
        
        viewModel?.output.titleIsNil = titleIsNil()
        viewModel?.output.creationCompleted = creationCompleted()
    }
    
    //MARK: - Handler
    
    @objc
    func handleKeyboard(_ notification: Notification) {
        guard let keyboardInfo = notification.userInfo else { return }
        let duration = keyboardInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = keyboardInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let startingFrame = (keyboardInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endingFrame = (keyboardInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let isHiding = endingFrame.origin.y >= startingFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIView.KeyframeAnimationOptions.init(rawValue: curve), animations: {
            self.createButton.alpha = isHiding ? 0 : 1
        }, completion: nil)
    }
    
    @objc
    func handleCreateOrEdit() {
        viewModel?.input.createOrEditTask(title: (titleTextField.text) ?? "", detail: detailTextView.text)
    }
    
    func titleIsNil() -> (() -> Void)? {
        return { [unowned self] in
            self.titleTextField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func creationCompleted() -> (() -> Void)? {
        return { [unowned self] in
            self.navigationController?.popViewController(animated: true)
        }
    }
}
