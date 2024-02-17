//
//  AlertModel.swift
//  Chinggu
//
//  Created by chaekie on 2023/09/07.
//

import Foundation

struct AlertContent: Identifiable {
    var id: String { title }
    var title: String
    var description: String

    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}

enum Alerts: CaseIterable{
    case cancelWriting
    case saveWriting

    var title: String {
        switch self {
        case .cancelWriting: return "정말로 나갈까요?"
        case .saveWriting: return "작성 중인 내용은 저장되지 않아요"
        }
    }

    var description: String {
        switch self {
        case .saveWriting: return "칭찬을 저장할까요?"
        case .cancelWriting: return "칭찬은 하루에 한 번만 쓸 수 있어요"
        }
    }
}
