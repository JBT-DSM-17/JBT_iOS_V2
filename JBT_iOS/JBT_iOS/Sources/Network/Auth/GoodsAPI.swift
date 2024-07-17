import Foundation
import Moya

enum GoodsAPI {
    case goodsRegister(name: String, price: Int, location: String, locationDetail: String, description: String)
    case goodsDetail(id: Int)
    case goodsCategory(category: String?, location: [String]?, isBad: Bool)
}

extension GoodsAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://keen-feasible-snake.ngrok-free.app")!
    }
    
    var path: String {
        switch self {
        case .goodsRegister:
            return "/goods"
        case .goodsDetail(let id):
            return "/goods/\(id)"
        case .goodsCategory:
            return "/goods"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .goodsRegister:
            return .post
        case .goodsDetail:
            return .get
        case .goodsCategory:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .goodsRegister(let name, let price, let location, let locationDetail, let description):
            return .requestParameters(
                parameters: [
                    "name": name,
                    "price": price,
                    "location": location,
                    "location_detail": locationDetail,
                    "description": description
                ], encoding: JSONEncoding.default)
        case .goodsDetail:
            return .requestPlain
        case .goodsCategory(category: let category, location: let location, isBad: let isBad):
            var parameters: [String: Any] = [
                "is_dokyung": isBad
            ]
            
            if let category = category {
                parameters["category"] = category
            }
            
            if let location = location {
                parameters["location"] = location
            }
            
            return .requestParameters(
                parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return Header.accessToken.header()
    }
}
