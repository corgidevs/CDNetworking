import Foundation
import Combine

public enum APIError: Error {
    case statusCode(Int)
    case invalidResponse
}
public struct CDNetworking {
    let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func hit<T: Decodable>(url: URL, completion: @escaping (Result<T,Error>) -> Void) -> AnyCancellable {
        return session.dataTaskPublisher(for: url)
        .tryMap { try self.validate(data: $0.data, response: $0.response)
        }
        .decode(type: T.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
        .sink(receiveCompletion: {
            switch $0 {
            case .finished: ()
            case .failure(let error):
                completion(.failure(error))
            }
        }, receiveValue: { result in
            completion(.success(result))
        })
    }

    func validate(data: Data, response: URLResponse) throws -> Data {
        guard let response = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        guard 200..<300 ~= response.statusCode else {
            throw APIError.statusCode(response.statusCode)
        }
        return data
    }
}


