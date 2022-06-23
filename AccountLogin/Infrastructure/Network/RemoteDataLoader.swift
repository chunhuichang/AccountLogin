//
//  RemoteDataLoader.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/23.
//

import Foundation

public enum DataLoaderError: Swift.Error {
    case noResponse
    case parseDataError(Error)
    case customerError((title: String, msg: String))
    case unknowNetworkFailure(Error)
    
    var description : (title: String, msg: String) {
        switch self {
        case .customerError(let messagePackage):
            return (messagePackage.title, messagePackage.msg)
            
        default:
            return ("網路錯誤", "伺服器沒有回應")
        }
    }
}

public enum DataLoaderResult<T> {
    case success(T)
    case failure(DataLoaderError)
}

public protocol DataServiceLoader {
    typealias CompletionHanlder<T> = (DataLoaderResult<T>) -> Void
    typealias DonwloadCompletionHanlder = (Data?, URLResponse?, Error?) -> Void
    
    func load<T: Decodable>(type: T.Type, config: ApiConfig, completion :@escaping CompletionHanlder<T>)
    func download(from url: URL, completion: @escaping DonwloadCompletionHanlder)
}

public final class RemoteDataLoader: DataServiceLoader {
    public init() {
    }
    
    public func load<T: Decodable>(type: T.Type, config: ApiConfig, completion :@escaping CompletionHanlder<T>) {
        var components: URLComponents = .init()
        components.scheme = "https"
        components.host = config.host
        components.path = "\(config.path)"
        
        if let apiParams = config.queryParameters, !apiParams.isEmpty {
            var urlQueryItems = [URLQueryItem]()
            apiParams.forEach { urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)")) }
            components.queryItems = urlQueryItems
        }
        
        guard let url = components.url else {
            completion(.failure(.customerError((title: "", msg: "url is nil"))))
            return
        }
        
        var request = URLRequest.init(url: url)
        request.httpMethod = config.method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("vqYuKPOkLQLYHhk4QTGsGKFwATT4mBIGREI2m8eD", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("", forHTTPHeaderField: "X-Parse-REST-API-Key")
        if let sessionToken = config.sessionToken {
            request.addValue(sessionToken, forHTTPHeaderField: "X-Parse-Session-Token")
        }
        
        if let apiParams = config.bodyParamaters, !apiParams.isEmpty {
            request.httpBody = apiParams.retriveData()
        }
        
        URLSession.shared.dataTask(with: request) {  data, resp, error in
            if let err = error {
                completion(.failure(.unknowNetworkFailure(err)))
                return
            }
            
            guard let data = data else {
                return
            }
            
            if let result = try? JSONDecoder().decode(type.self, from: data) {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                return completion(.failure(.noResponse))
            }
            
        }.resume()
    }
    
    public func download(from url: URL, completion: @escaping DonwloadCompletionHanlder) {
        URLSession.shared.dataTask(with: url) { data, resp, error in
            DispatchQueue.main.async {
                completion(data, resp, error)
            }
        }.resume()
    }
}

private extension Dictionary {
    func retriveData() -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: self)
        } catch {
            return "".data(using: .utf8) ?? Data()
        }
    }
}
