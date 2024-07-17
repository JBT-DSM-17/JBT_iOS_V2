import Foundation
import Moya

enum AuthAPI {
    case login(userId: String, password: String)
    case signup(userId: String, nickname: String, phone: String, password: String)
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://keen-feasible-snake.ngrok-free.app")!
    }
    
    var path: String {
        switch self {
        case .signup:
            return "/auth/signup"
        case .login:
            return "/auth/login"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signup:
            return .post
        case .login:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .signup(let userId, let nickname, let phone, let password):
            return .requestParameters(
                parameters: [
                    "user_id": userId,
                    "nickname": nickname,
                    "phone": phone,
                    "password": password
                ], encoding: JSONEncoding.default)
        case .login(let userId, let password):
            return .requestParameters(
                parameters: [
                    "user_id": userId,
                    "password": password
                ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
