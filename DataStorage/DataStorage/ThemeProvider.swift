//
//  ThemeProvider.swift
//  DataStorage
//
//  Created by Юлия Дебелова on 27.08.2023.
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
        case .white: Theme.currentTheme = WhiteTheme()
        case .blue: Theme.currentTheme = BlueTheme()
        case .green: Theme.currentTheme = GreenTheme()
        default: Theme.currentTheme = WhiteTheme()
        }
    }
}
