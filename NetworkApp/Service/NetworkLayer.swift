
protocol NetworkLayer {
    func request<T: Decodable>(with urlString: String, method: HTTPMethod, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
}
