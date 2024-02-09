import Foundation

final class HomeService {
    
    func getPersonList(completion: @escaping (Result<[People], Error>)-> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/users"
        ServiceManager.shared.request(with: urlString, method: .get, decodeType: [People].self) { result in
            switch result {
            case .success(let peoples):
                completion(.success(peoples))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
