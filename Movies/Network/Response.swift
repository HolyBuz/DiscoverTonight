import Foundation

struct Response {
    private var data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    public func decode<T: Decodable>(_ type: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let response = try decoder.decode(T.self, from: data)
            return response
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
