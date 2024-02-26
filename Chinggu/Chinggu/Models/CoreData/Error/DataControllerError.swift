//
//  DataControllerError.swift
//  Chinggu
//
//  Created by Junyoo on 2/19/24.
//

import Foundation

enum DataControllerError: Error {
    case saveError
    case deleteError
    case fetchError
    case generalError

    var errorMessage: String {
        switch self {
        case .saveError:
            return "칭찬 저장 중 에러가 발생했어요. \n나중에 다시 시도해 주세요."
        case .deleteError:
            return "칭찬 삭제 중 에러가 발생했어요. \n나중에 다시 시도해 주세요."
        case .fetchError:
            return "칭찬 불러오기 중 에러가 발생했어요. \n나중에 다시 시도해 주세요."
        default:
            return "데이터 처리 중 에러가 발생했어요. \n나중에 다시 시도해 주세요."
        }
    }
}
