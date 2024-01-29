import Foundation

final class HomeService {
    
    func getPersonList(completion: @escaping (Result<PersonList, Error>)-> Void) {
        let urlString = URL(string: "https://run.mocky.io/v3/65af81de-e83e-4cce-b751-f239388fdff5")
        
        guard let url = urlString else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print("ERROR \(#function) Detalhe do erro: \(error.localizedDescription)")
                completion(.failure(error.localizedDescription as! Error))
                return
            }
            
            guard let data else { 
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(error?.localizedDescription as! Error))
                return
            }
            
            do {
                let personList: PersonList = try JSONDecoder().decode(PersonList.self, from: data)
                print("Success -> \(#function)")
                completion(.success(personList))
            } catch  {
                print("Error -> \(#function)")
                completion(.failure(error.localizedDescription as! Error))
            }
        }
        task.resume()
    }
}
