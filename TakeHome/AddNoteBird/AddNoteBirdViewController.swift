//
//  AddNoteBirdViewController.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.

import UIKit

// MARK: - AddNoteBirdViewController
final class AddNoteBirdViewController: UIViewController {
    var presenter: AddNoteBirdViewPresenterProtocol?
    private let imageHeight: CGFloat = 133
    private let imageWidth: CGFloat = 127
    
    let navBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Atrás", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapBackAction), for: .touchUpInside)
        return button
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .blue
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "This is a new note"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.returnKeyType = .done
        return tf
    }()
}

// MARK: - View Life Cycle
extension AddNoteBirdViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        
        view.addSubview(navBarView)
        navBarView.addSubview(backButton)
        view.addSubview(imageView)
        view.addSubview(textField)
        
        textField.delegate = self
        textField.inputAccessoryView = createAccessoryToolbar()
        
        NSLayoutConstraint.activate([
            navBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBarView.heightAnchor.constraint(equalToConstant: 53),
            
            backButton.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor),
            
            imageView.topAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageHeight),
            imageView.widthAnchor.constraint(equalToConstant: imageWidth),
            
            textField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            textField.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        textField.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }
    
    @objc func didTapBackAction() {
        presenter?.dismissModule()
    }
    
    func callAddNote(_ comment: String) {
        Task { [weak self] in
            guard let strongSelf = self else { return }
            await strongSelf.presenter?.callAddNote(comment: comment)
        }
    }
    
    func createAccessoryToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        toolbar.setItems([flexibleSpace, saveButton, flexibleSpace], animated: false)
        return toolbar
    }
    
    @objc func didTapSaveButton() {
        callAddNote(textField.text ?? "")
        textField.resignFirstResponder()
    }
}

// MARK: - AddNoteBirdViewProtocol
extension AddNoteBirdViewController: AddNoteBirdViewProtocol {
}

// MARK: - UITextFieldDelegate
extension AddNoteBirdViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        callAddNote(textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }
}
