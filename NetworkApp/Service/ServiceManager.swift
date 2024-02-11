import Foundation

final class ServiceManager: NetworkLayer {

    static var shared = ServiceManager()
    private var baseUrl: String
    private var requestBuider: RequestBuilder
    private(set) var session: URLSession
    private var decoder:  JSONDecoder
    
    init(session: URLSession = URLSession.shared ,baseUrl: String? = nil, requestBuider: RequestBuilder = DefaulRequestBuilder(), decoder:  JSONDecoder = JSONDecoder()) {
        self.session = session
        self.requestBuider = requestBuider
        self.decoder = decoder
        if let baseUrl {
            self.baseUrl = baseUrl
        } else if let baseUrlString = Bundle.main.infoDictionary?["BaseUrl"] as? String { //busca no info.plist
            self.baseUrl = baseUrlString
        } else {
            self.baseUrl = ""
        }
    }
    
    func request<T>(with endpoint: Endpoint, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        let urlString = baseUrl + endpoint.url
        
        guard let url = URL(string: urlString) else {
            NetworkLogger.logError(error: .invalidURL(url: urlString))
            completion(.failure(.invalidURL(url: urlString)))
            return
        }
        
        let request = requestBuider.buildRequest(with: endpoint, url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            NetworkLogger.log(request: request, response: response, data: data, error: error)
            if let error {
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
                let object: T = try self.decoder.decode(T.self, from: data)
                completion(.success(object))
            } catch  {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
    
}
