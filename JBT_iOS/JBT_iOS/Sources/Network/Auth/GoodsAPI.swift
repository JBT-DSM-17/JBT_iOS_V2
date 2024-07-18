import Foundation
import Moya

enum GoodsAPI {
    case registerNewGoods(dto: NewGoodsRequestDTO)
    case goodsDetail(id: Int)
    case goodsCategory(category: String?, location: [String]?, isBad: Bool)
}

extension GoodsAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://keen-feasible-snake.ngrok-free.app")!
    }
    
    var path: String {
        switch self {
        case .registerNewGoods:
            return "/goods/new"
        case .goodsDetail(let id):
            return "/goods/\(id)"
        case .goodsCategory:
            return "/goods"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .goodsDetail:
            return .get
        case .registerNewGoods, .goodsCategory:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .registerNewGoods(let dto):
            var formData = [MultipartFormData]()
            formData.append(MultipartFormData(provider: .data(dto.representative), name: "picture", fileName: "picture.png", mimeType: "image/png"))
            formData.append(MultipartFormData(provider: .data(dto.name.data(using: .utf8)!), name: "name"))
            formData.append(MultipartFormData(provider: .data(dto.description.data(using: .utf8)!), name: "description"))
            formData.append(MultipartFormData(provider: .data(dto.category.data(using: .utf8)!), name: "category"))
            formData.append(MultipartFormData(provider: .data(dto.price.description.data(using: .utf8)!), name: "price"))
            formData.append(MultipartFormData(provider: .data(dto.location.data(using: .utf8)!), name: "location"))
            formData.append(MultipartFormData(provider: .data(dto.detailLocation.data(using: .utf8)!), name: "location_detail"))
            formData.append(MultipartFormData(provider: .data(dto.isClassB.description.data(using: .utf8)!), name: "is_dokyung"))
            formData.append(MultipartFormData(provider: .data(dto.detail), name: "detail", fileName: "detail.png", mimeType: "image/png"))
            return .uploadMultipart(formData)
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
        switch self {
        case .registerNewGoods:
            return Header.multipartForm.header()
        case .goodsDetail, .goodsCategory:
            return Header.accessToken.header()
        }
    }
}
