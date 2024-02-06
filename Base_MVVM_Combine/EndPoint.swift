//
//  EndPoint.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 02/02/2024.
//

import Foundation

enum EndPoint {
  case nowPlaying(page: Int)
  
  var domain: String {
    switch self {
    case .nowPlaying:
      return URLs.tmdb
    }
  }
  
  var path: String? {
    switch self {
    case .nowPlaying:
      return "/3/movie/now_playing"
    }
  }
  
  var method: String {
    switch self {
    case .nowPlaying:
      return "GET"
    }
  }
  
  var params: [String: String?] {
    var params: [String: String?] = [:]
    switch self {
    case .nowPlaying(let page):
      params["api_key"] = "dc9e9a73378330417bb4818abf1b60ed"
      params["page"] = String(page)
    }
    return params
  }
  
  var headers: [String: String?] {
    var headers: [String: String?] = [:]
    switch self {
    default:
      headers["Content-Type"] = "application/json"
    }
    return headers
  }
}

extension EndPoint {
  func request(body: Data?) -> URLRequest? {
    guard
      let url = URL(string: domain),
      var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
    else {
      return nil
    }
    if let path {
      urlComponents.path = path
    }
    urlComponents.queryItems = params.map({
      return URLQueryItem(name: $0, value: $1)
    })
    
    guard let urlRequest = urlComponents.url else {
      return nil
    }
    var request = URLRequest(url: urlRequest)
    request.httpMethod = method
    
    headers.forEach {
      request.setValue($1, forHTTPHeaderField: $0)
    }
    
    if let body {
      request.httpBody = body
    }
    
    return request
  }
}
