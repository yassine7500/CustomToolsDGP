//
//  ApiServiceTool.swift
//  CustomToolsDGP
//
//  Created by David Galán on 23/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

public enum HttpMethodType: String {
    case get = "GET"
    case post = "POST"
}

public class ApiService: NSObject {
    
    var defaultSession: URLSession!
    var dataGetTask: URLSessionDataTask?
    
    var expectedContentLength: Int64 = 0
    var buffer = Data()
    
    public func fetchFeedForUrlString(idText: String, urlString: String, httpMethod: HttpMethodType, params: [String : Any], userTokenForAuthorization: String?, timeoutBigger: Bool = false, completion: @escaping (_ data: Any?, _ error: Bool)->Void) {
        
        guard InternetConnectionTool().isConnectedToNetwork() else {
            completion("errorInternetConnection", true)
            return
        }
        
        DateTools().setGlobalStartDate(id: "ApiService - \(idText)")
        
        dataGetTask?.cancel()
        defaultSession = URLSession(configuration: .default)
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if timeoutBigger {
            request.timeoutInterval = 900
        } else {
            request.timeoutInterval = 15
        }
        
        if params.count > 0 {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        }
        
        if userTokenForAuthorization != nil, userTokenForAuthorization != "" {
            request.setValue("\(userTokenForAuthorization!)", forHTTPHeaderField: "Authorization")
        }
        
        defer {dataGetTask?.resume()}
        dataGetTask = defaultSession.dataTask(with: request) { data, response, error in
            
            defer {
                self.dataGetTask = nil
            }
            
            DateTools().setGlobalEndDate()
            
            if error != nil {
                completion(error, true)
            } else {
                completion(data, false)
            }
            
        }
    }
    
    
    public func fetchFeedForUrlStringDelegate(idText: String, urlString: String, httpMethod: HttpMethodType, params: [String : String], userTokenForAuthorization: String?, timeoutBigger: Bool = false) {
        
        DateTools().setGlobalStartDate(id: "ApiServiceDelegate - \(idText)")
        
        dataGetTask?.cancel()
        defaultSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if timeoutBigger {
            request.timeoutInterval = 900
        } else {
            request.timeoutInterval = 15
        }
        
        if params.count > 0 {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        }
        
        if userTokenForAuthorization != nil, userTokenForAuthorization != "" {
            request.setValue("\(userTokenForAuthorization!)", forHTTPHeaderField: "Authorization")
        }
        
        dataGetTask = defaultSession.dataTask(with: request)
        dataGetTask!.resume()
    }
    
}

extension ApiService: URLSessionDataDelegate {
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        expectedContentLength = response.expectedContentLength
        print("expectedContentLength: ", expectedContentLength)
        completionHandler(.allow)
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        buffer.append(data)
        let percentageDownloaded = Double(buffer.count) / Double(expectedContentLength)
        DispatchQueue.main.async {
            print("percentageDownloaded:", percentageDownloaded)
        }
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        DispatchQueue.main.async {
            
            DateTools().setGlobalEndDate()
            
            if error != nil {
                print("ERROR")
            } else {
                print("SUCCESS")
                print("# BUFFER >", self.buffer)
                print("- - - - - - -")
            }
        }
    }
    
}



