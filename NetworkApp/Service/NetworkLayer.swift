
protocol NetworkLayer {
    func request<T: Decodable>(with endpoint: Endpoint, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable
}
