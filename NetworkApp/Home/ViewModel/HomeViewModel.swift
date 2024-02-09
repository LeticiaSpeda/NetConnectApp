import UIKit

protocol HomeViewModelDelegate: AnyObject {
    func success()
    func error(message: String)
}

final class HomeViewModel {
    
    private let service =  HomeService()
    private var peopleList: [People] = []
    weak var delegate: HomeViewModelDelegate?
    
    var numberOfRowsInSection: Int {
        return peopleList.count
    }
    
    func fetchRequest() {
        service.getPersonList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                self.peopleList = success
                self.delegate?.success()
            case .failure(let error):
                self.delegate?.error(message: error.localizedDescription)
            }
        }
    }
    
    func loadCurrentPeople(indexPath: IndexPath) -> People {
        return peopleList[indexPath.row]
    }
}
