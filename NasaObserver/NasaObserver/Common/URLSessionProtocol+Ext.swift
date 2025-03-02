//
//  URLSessionProtocol+Ext.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 02/03/2025.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }
