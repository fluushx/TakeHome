//
//  BirdDetailViewController.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

import UIKit

// MARK: - BirdDetailViewController
final class BirdDetailViewController: UIViewController {
    var presenter: BirdDetailViewPresenterProtocol?
    private var dataNotes = [Notes]()
    private var notesLoadFailed = false
    private var noteAddedObserver: NSObjectProtocol?
    
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
        tv.register(ErrorBirdDetailViewCell.self, forCellReuseIdentifier: ErrorBirdDetailViewCell.reuseIdentifier)
        tv.separatorStyle = .none
        tv.alwaysBounceVertical = true
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
    
    lazy var navBarTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Atrás", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapBackAction), for: .touchUpInside)
        return button
    }()
    lazy var belowHeaderIndicator: GenericLoadingIndicatorView = {
        let view = GenericLoadingIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(navBarView)
        navBarView.addSubview(navBarTitleLabel)
        navBarView.addSubview(backButton)
        view.addSubview(headerView)
        view.addSubview(tableView)
        view.addSubview(addNoteButton)
        self.dataNotes = presenter?.getNotes() ?? []
            
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 380)
        headerHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            navBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBarView.heightAnchor.constraint(equalToConstant: 53),
            navBarTitleLabel.centerXAnchor.constraint(equalTo: navBarView.centerXAnchor),
            navBarTitleLabel.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor),
            
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
        setUpHeaderView()
        configureNoteAddedObserver()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let observer = noteAddedObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    @objc func didTapGoToAddNote() {
        presenter?.goToAddNote()
    }
    
    @objc func didTapBackAction() {
        presenter?.dismissModule()
    }
    @objc private func handleNoteAdded() {
        presenter?.callUpdateNotes()

    }
    func setUpHeaderView() {
        let image = presenter?.getBirdImage() ?? UIImage()
        let title = presenter?.getTitleNav()
        headerView.configure(with: image)
        navBarTitleLabel.text = title
    }
    
    private func configureNoteAddedObserver() {
        noteAddedObserver = NotificationCenter.default.addObserver(
            forName: .noteAdded,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.handleNoteAdded()
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension BirdDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let notes = dataNotes

        switch (notesLoadFailed, dataNotes.count) {
        case (true, _):
            tableView.backgroundView = nil
            return 1
        case (false, 0):
            setEmptyBackgroundView(
                for: tableView
            )
            return 0
        case (false, _):
            tableView.backgroundView = nil
            return notes.count
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if notesLoadFailed {
            let cell = tableView.dequeueReusableCell(withIdentifier: ErrorBirdDetailViewCell.reuseIdentifier, for: indexPath) as? ErrorBirdDetailViewCell
            cell?.configureErrorState { [weak self] in
                self?.notesLoadFailed = false
                self?.presenter?.callUpdateNotes()
            }
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: BirdDetailViewCell.reuseIdentifier, for: indexPath) as! BirdDetailViewCell
            let note = dataNotes[indexPath.row]
            cell.setUpLabel(comment: note.comment)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let offset = scrollView.contentOffset.y
         headerView.updateImageSize(scrollOffset: offset)
         headerHeightConstraint.constant = headerView.currentHeight()
    }
    func setEmptyBackgroundView(for tableView: UITableView) {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "no comments about the bird"
        label.textAlignment = .center
        label.textColor = .gray
        
        tableView.backgroundView = label
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            label.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 48)
        ])
    }
}
    
// MARK: BirdDetailViewProtocol
extension BirdDetailViewController: BirdDetailViewProtocol {
    func showLoading() {
        DispatchQueue.main.async {
            self.showBelowHeaderIndicator()
            self.tableView.isHidden = true

        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.hideBelowHeaderIndicator(after: 2.0)

        }
    }
    
    func showError() {
        DispatchQueue.main.async { [self] in
            self.notesLoadFailed = true
            self.tableView.reloadData()
        }
    }
    
    func updateNotes(_ notes: [Notes]) {
        self.notesLoadFailed = false
        self.dataNotes = notes
        self.tableView.reloadData()
    }
}

extension BirdDetailViewController {
    func showBelowHeaderIndicator() {
        belowHeaderIndicator.tag = 999
        belowHeaderIndicator.startLoading()
        belowHeaderIndicator.isHidden = false
        belowHeaderIndicator.updateMessage("Loading comments list...")
        
        if belowHeaderIndicator.superview == nil {
            view.addSubview(belowHeaderIndicator)
            belowHeaderIndicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                belowHeaderIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                belowHeaderIndicator.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 50)
            ])
        }
        
        tableView.isHidden = true
    }
    
    func hideBelowHeaderIndicator(after delay: TimeInterval = 2.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }
            self.belowHeaderIndicator.stopLoading()
            self.belowHeaderIndicator.removeFromSuperview()
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
}
