//
//  NetworkService.swift
//  DataStorage
//
//  Created by Ринат on 31.08.2023.
//

import Foundation

final class NetworkService {
    static var accessToken = ""
    static var userID = ""

    private let session = URLSession.shared

    func getFiends(getData: @escaping (FriendsModel) -> Void) {
        guard let url = URL(string:
            "https://api.vk.com/method/friends.get?access_token=\(NetworkService.accessToken)&v=5.131&fields=online,photo_50")
        else {
            return
        }
        session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                let friends = try JSONDecoder().decode(FriendsModel.self, from: data)
                getData(friends)
                print(friends)
            } catch {
                print(error)
            }
        }.resume()
    }

    func getGroups(getData: @escaping (GroupsModel) -> Void) {
        guard let url = URL(string:
            "https://api.vk.com/method/groups.get?access_token=\(NetworkService.accessToken)&v=5.131&extended=1&fields=description")
        else {
            return
        }
        session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                let groups = try JSONDecoder().decode(GroupsModel.self, from: data)
                getData(groups)
                print(groups)
            } catch {
                print(error)
            }
        }.resume()
    }

    func getPhotos(getData: @escaping (PhotosModel) -> Void) {
        guard let url = URL(string:
            "https://api.vk.com/method/photos.get?access_token=\(NetworkService.accessToken)&album_id=wall&v=5.131")
        else {
            return
        }
        session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                let photos = try JSONDecoder().decode(PhotosModel.self, from: data)
                getData(photos)
                print(photos)
            } catch {
                print(error)
            }
        }.resume()
    }

    func getProfile(getData: @escaping (ProfileModel) -> Void) {
        guard let url = URL(string:
            "https://api.vk.com/method/account.getProfileInfo?access_token=\(NetworkService.accessToken)&album_id=wall&v=5.131")
        else {
            return
        }
        session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                let profile = try JSONDecoder().decode(ProfileModel.self, from: data)
                getData(profile)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getProfilePhoto(photoURL: String?, getData: @escaping (Data) -> Void) {
        DispatchQueue.global().async {
            if let url = URL(string: photoURL ?? ""), let data = try? Data(contentsOf: url) {
                getData(data)
            }
        }
    }
}
