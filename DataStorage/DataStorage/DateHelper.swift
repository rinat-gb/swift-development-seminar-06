//
//  DateHelper.swift
//  DataStorage
//
//  Created by Ринат on 31.08.2023.
//

import Foundation

final class DateHelper {
    static func getDateString(date: Date?) -> String {
        if date == nil { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date!)
    }
}
