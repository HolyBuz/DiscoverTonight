import Foundation

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

class Resource {
    
    private var urlComponent: URLComponents {
        var urlComponent = URLComponents()
        urlComponent.scheme = scheme
        urlComponent.host = host
        urlComponent.path = path
        urlComponent.queryItems = queryItems
        return urlComponent
    }
    
    var queryItems: [URLQueryItem]? {
        return parameters.map { key, value in
            return URLQueryItem(name: key, value: value as? String)
        }
    }
    
    var url: URL {
        return urlComponent.url!
    }
    
    var httpBody: Data?
    
    var httpMethod: HTTPMethod
    
    private var host = "api.themoviedb.org"
    private var scheme = "https"
    private let path: String
    private var parameters = [String: Any]()
    
    init(version: String = "3", httpMethod: HTTPMethod = .GET , path: String, parameters: [String: Any]? = nil, data: Data? = nil) {
        
        self.path = "/" + version + "/" + path
        self.httpBody = data
        self.httpMethod = httpMethod
        
        if let parameters = parameters {
            self.parameters.merge(parameters) { (_, new) in new }
        }
        self.parameters["api_key"] = Credentials.apiKey
    }
}
