

import Foundation
class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {
    }
    
    func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                // Handle invalid or empty data
                return
            }
            
            completion(.success(data))
        }.resume()
    }
    
    
}
