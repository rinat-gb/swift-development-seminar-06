//
//  FriendsTableViewController.swift
//  DataStorage
//
//  Created by Ринат on 31.08.2023.
//

import UIKit

final class FriendTableViewController: UITableViewController {
    private var friendsModel: FriendsModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = Constants.Titles.friendsTitle
        tableView.register(FriendCell.self, forCellReuseIdentifier: Constants.CellNames.friendsCellName)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(showPersonalInfo))
        NetworkService().getFiends { [weak self] friendsModel in
            if friendsModel.response?.count == 0 {
                // а нету друзей! меняем заголовое на "Нет друзей"
                DispatchQueue.main.async {
                    self?.title = Constants.TitlesNoItems.friendsTitle
                }
            } else {
                self?.friendsModel = friendsModel

                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }

    @objc private func showPersonalInfo() {
        let animation = CATransition()
        animation.type = .fade
        animation.duration = 1
        navigationController?.view.layer.add(animation, forKey: nil)
        navigationController?.pushViewController(ProfileViewController(), animated: false)
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return friendsModel?.response?.count ?? 0
    }

    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let friendCell =
            tableView.dequeueReusableCell(withIdentifier: Constants.CellNames.friendsCellName, for: indexPath) as? FriendCell
        else {
            return UITableViewCell()
        }
        guard let friend = friendsModel?.response?.items?[indexPath.row] else {
            return UITableViewCell()
        }
        friendCell.update(friend: friend)
        return friendCell
    }
}
