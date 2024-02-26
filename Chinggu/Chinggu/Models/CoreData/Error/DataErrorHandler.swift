//
//  DataErrorHandler.swift
//  Chinggu
//
//  Created by Junyoo on 2/20/24.
//

import Foundation

@MainActor
protocol DataErrorHandler: AnyObject {
    //AnyObject 채택함으로써 class type만 채택하게끔 해야 self에 대한 속성 변경 가능
    var errorDescription: String { get set }
    var showErrorAlert: Bool { get set }
    func handleError(_ error: Error)
}

extension DataErrorHandler {
    func handleError(_ error: Error) {
        if let error = error as? DataControllerError {
            self.errorDescription = error.errorMessage
        } else {
            self.errorDescription = "알 수 없는 에러가 발생했어요. \n나중에 다시 시도해주세요."
        }
        self.showErrorAlert = true
    }
}
