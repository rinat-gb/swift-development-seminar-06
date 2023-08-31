//
//  Theme.swift
//  DataStorage
//
//  Created by Ринат on 31.08.2023.
//

import UIKit

enum ThemeTypes: String {
    case white
    case blue
    case green
}

protocol AppThemeProtocol {
    var type: ThemeTypes { get set }
    var backgroundColor: UIColor { get }
}

enum Theme {
    static var currentTheme: AppThemeProtocol = WhiteTheme()
}

final class WhiteTheme: AppThemeProtocol {
    var type: ThemeTypes = .white
    var backgroundColor: UIColor = .white
}

final class BlueTheme: AppThemeProtocol {
    var type: ThemeTypes = .blue
    var backgroundColor: UIColor = .init(red: 228 / 255, green: 231 / 255, blue: 1, alpha: 1)
}

final class GreenTheme: AppThemeProtocol {
    var type: ThemeTypes = .green
    var backgroundColor: UIColor = .init(red: 206 / 255, green: 1, blue: 162 / 255, alpha: 1)
}
