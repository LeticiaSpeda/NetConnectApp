import Foundation

final class HomeService {
    
    func getPersonList(completion: @escaping (Result<[People], Error>)-> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error in \(#function): \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                print("Invalid response in \(#function): Status Code \(statusCode)")
                completion(.failure(NSError(domain: "Invalid response", code: statusCode, userInfo: nil)))
                return
            }
            
            do {
                let decodeded = try JSONDecoder().decode([People].self, from: data)
                print("Success in \(#function)")
                completion(.success(decodeded))
            } catch {
                print("Error decoding JSON in \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
