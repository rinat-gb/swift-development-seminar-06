//
//  ThemeProvider.swift
//  DataStorage
//
//  Created by Ринат on 31.08.2023.
//

import Foundation

final class ThemeProvider {
    static func putData() {
        let theme = Theme.currentTheme.type
        UserDefaults.standard.set(theme.rawValue, forKey: "theme")
    }

    static func getData() {
        let theme = UserDefaults.standard.string(forKey: "theme")
        let themeType = ThemeTypes(rawValue: theme ?? "white")
        switch themeType {
        case .whiteTheme: Theme.currentTheme = WhiteTheme()
        case .blueTheme: Theme.currentTheme = BlueTheme()
        case .greenTheme: Theme.currentTheme = GreenTheme()
        default: Theme.currentTheme = WhiteTheme()
        }
    }
}
