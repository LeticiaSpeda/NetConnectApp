import Foundation

final class ServiceManager: NetworkLayer {

    static var shared = ServiceManager()
    private var baseUrl: String
    
    private(set) var session = URLSession.shared
    
    init(baseUrl: String? = nil) {
        if let baseUrl {
            self.baseUrl = baseUrl
        } else if let baseUrlString = Bundle.main.infoDictionary?["BaseUrl"] as? String { //busca no info.plist
            self.baseUrl = baseUrlString
        } else {
            self.baseUrl = ""
        }
    }
    
    func request<T>(with endpoint: Endpoint, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        let url = baseUrl + endpoint.url
        
        guard let url: URL = URL(string: endpoint.url) else {
            completion(.failure(.invalidURL(url: url)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error {
                print("ERROR \(#function) Detalhe do erro: \(error.localizedDescription)")
                completion(.failure(.networkFailure(error)))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let object: T = try decoder.decode(T.self, from: data)
                print("SUCCESS -> \(#function)")
                completion(.success(object))
            } catch  {
                print("ERROR -> \(#function)")
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
    
}
