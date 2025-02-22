import Foundation
import SwiftKeychainWrapper

struct Token {
    static var localAccessToken: String?
    static var accessToken: String? {
        get {
            localAccessToken = KeychainWrapper.standard.string(forKey: "acccess-token")
            return localAccessToken
        }
        set(newToken) {
            KeychainWrapper.standard.set(newToken ?? "nil", forKey: "acccess-token")
            localAccessToken = newToken
        }
    }
    static func removeToken() {
        self.accessToken = nil
    }
}

enum Header {
    case accessToken, tokenIsEmpty, multipartForm
    func header() -> [String: String]? {
        guard let token = Token.accessToken,
            token != "nil" else {
            return ["Content-Type": "application/json"]
        }
        switch self {
        case .accessToken:
            return ["Authorization": token, "Content-Type": "application/json"]
        case .tokenIsEmpty:
            return ["Content-Type": "application/json"]
        case .multipartForm:
            return ["Authorization": token, "Content-Type": "multipart/form-data"]
        }
    }
}
