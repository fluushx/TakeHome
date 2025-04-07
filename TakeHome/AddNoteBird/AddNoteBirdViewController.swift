//
//  AddNoteBirdViewController.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.

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
    lazy var navBarTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        tf.backgroundColor = .systemGray6
        return tf
    }()
    lazy var sendingCommentView: GenericLoadingIndicatorView = {
        let view = GenericLoadingIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
}

// MARK: - View Life Cycle
extension AddNoteBirdViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        view.addSubview(navBarView)
        navBarView.addSubview(backButton)
        navBarView.addSubview(navBarTitleLabel)
        view.addSubview(imageView)
        view.addSubview(textField)
        view.addSubview(sendingCommentView)
        
        textField.delegate = self
        textField.inputAccessoryView = createAccessoryToolbar()
        
        NSLayoutConstraint.activate([
            navBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBarView.heightAnchor.constraint(equalToConstant: 53),
            navBarTitleLabel.centerXAnchor.constraint(equalTo: navBarView.centerXAnchor),
            navBarTitleLabel.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor),
            
            imageView.topAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageHeight),
            imageView.widthAnchor.constraint(equalToConstant: imageWidth),
            
            textField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            textField.heightAnchor.constraint(equalToConstant: 150),
            
            sendingCommentView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 50),
            sendingCommentView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        let title = presenter?.addNoteTitle()
        imageView.image = presenter?.getBirdImage()
        navBarTitleLabel.text = title
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
        textField.isEnabled = false
        callAddNote(textField.text ?? "")
    }
}

// MARK: - AddNoteBirdViewProtocol
extension AddNoteBirdViewController: AddNoteBirdViewProtocol {
    func showLoading() {
        DispatchQueue.main.async {
            self.sendingCommentView.startLoading()
            self.sendingCommentView.updateMessage("Sending comment...")
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.sendingCommentView.showSuccess()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.sendingCommentView.stopLoading()
                self.textField.isEnabled = true
                self.textField.text = ""
            }
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            self.sendingCommentView.showRetry()
            self.sendingCommentView.updateMessage("Failed to complete action.\n Would you like to retry?")
            self.sendingCommentView.retryAction = { [weak self] in
                guard let self = self else { return }
                self.sendingCommentView.retryButton.isEnabled = true
                self.sendingCommentView.startLoading()
                self.sendingCommentView.updateMessage("Sending comment...")
                self.textField.isEnabled = false
                self.callAddNote(self.textField.text ?? "")
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension AddNoteBirdViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        callAddNote(textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }
}
