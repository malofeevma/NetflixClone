//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Maksim Malofeev on 26/09/2022.
//

import UIKit

class HomeViewController: UIViewController {

    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)

        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self

        configureNavBar()

        let headerView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height/2))
        homeFeedTable.tableHeaderView = headerView
    }

    private func configureNavBar() {
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)

        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]

        navigationController?.navigationBar.tintColor = .white
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
//        var content = cell.defaultContentConfiguration()
//
//        content.text = "Hellow, world!"
//
//        cell.contentConfiguration = content
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset

        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}
