//
//  BirdDetailViewController.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

import UIKit

// MARK: - BirdDetailViewController
final class BirdDetailViewController: UIViewController {
    var presenter: BirdDetailViewPresenterProtocol?
    private var headerHeightConstraint: NSLayoutConstraint!
    lazy var headerView: BirdDetailHeaderView = {
        let header = BirdDetailHeaderView(frame: .zero)
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(BirdDetailViewCell.self, forCellReuseIdentifier: BirdDetailViewCell.reuseIdentifier)
        tv.separatorStyle = .none
        return tv
    }()
    
    lazy var addNoteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add a note", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapGoToAddNote), for: .touchUpInside)
        return button
    }()
    
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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(navBarView)
        navBarView.addSubview(backButton)
        view.addSubview(headerView)
        view.addSubview(tableView)
        view.addSubview(addNoteButton)
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 380)
        headerHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            navBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBarView.heightAnchor.constraint(equalToConstant: 53),
            
            backButton.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor),
            
            headerView.topAnchor.constraint(equalTo: navBarView.bottomAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addNoteButton.topAnchor),

            addNoteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addNoteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addNoteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            addNoteButton.heightAnchor.constraint(equalToConstant: 95)
        ])
    }
    
    @objc func didTapGoToAddNote() {
        print("Botón presionado")
        presenter?.goToAddNote()
    }
    
    @objc func didTapBackAction() {
        presenter?.dismissModule()
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension BirdDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNotes().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BirdDetailViewCell.reuseIdentifier, for: indexPath) as? BirdDetailViewCell else {
            return UITableViewCell()
        }
        let comment = presenter?.getNotes()[indexPath.row].comment ?? ""
        cell.setUpLabel(comment: comment)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let offset = scrollView.contentOffset.y
         headerView.updateImageSize(scrollOffset: offset)
         headerHeightConstraint.constant = headerView.currentHeight()
    }
}


// MARK: BirdDetailViewProtocol
extension BirdDetailViewController: BirdDetailViewProtocol {
}
