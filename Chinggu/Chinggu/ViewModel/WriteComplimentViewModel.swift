//
//  WriteComplimentViewModel.swift
//  Chinggu
//
//  Created by chaekie on 2023/09/07.
//

import Foundation

class WriteComplimentViewModel: ObservableObject {
    @Published var categories: [Category] = Categories.allCases.map { Category(title: $0.title,
                                                                               example: $0.example)}

}
