//
//  ProfileViewController.swift
//  DataStorage
//
//  Created by Ринат on 31.08.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    private var nameLabelView: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    private var imageView = UIImageView()

    private var profile: ProfileModel? = nil

    init() {
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = Constants.Titles.profileTitle

        NetworkService().getProfile { [weak self] profile in
            self?.profile = profile
            self?.update()
        }
    }

    private func setupViews() {
        view.addSubview(nameLabelView)
        view.addSubview(imageView)
    }

    private func setupConstraints() {
        nameLabelView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabelView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameLabelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: nameLabelView.bottomAnchor, constant: 10),
        ])
    }

    func update() {
        let firstName = profile?.response.firstName ?? ""
        let lastName = profile?.response.lastName ?? ""
        let screenName = profile?.response.screenName ?? ""

        var fullName: String

        if firstName.isEmpty && lastName.isEmpty {
            fullName = Constants.NoNames.friendNoNameText
        } else if !firstName.isEmpty && !lastName.isEmpty {
            fullName = firstName + " " + lastName
        } else if !firstName.isEmpty && lastName.isEmpty {
            fullName = firstName
        } else {
            fullName = lastName
        }

        DispatchQueue.main.async {
            if screenName.isEmpty {
                self.nameLabelView.text = fullName
            } else {
                self.nameLabelView.text = fullName + "(" + screenName + ")"
            }
            NetworkService().getProfilePhoto(photoURL: self.profile?.response.photo) { [weak self] photoData in
                guard let photo = UIImage(data: photoData) else {
                    return
                }
                DispatchQueue.main.async {
                    self?.imageView.image = photo
                }
            }
        }
    }
}
