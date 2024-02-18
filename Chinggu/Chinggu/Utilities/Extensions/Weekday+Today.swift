//
//  Weekday+Today.swift
//  Chinggu
//
//  Created by Sebin Kwon on 2023/08/31.
//

import Foundation

extension Weekday {
    static var today: Weekday {
        let index = (Calendar.current.component(.weekday, from: Date()) + 5) % 7
        return Weekday.allCases[index]
    }
}
