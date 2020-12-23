//
//  NobelLaureatesParser.swift
//  Rakuten_Assignment
//
//  Created by Srikanth on 16/12/20.
//

import Foundation

final class LaureatesParser {
    
    
    let resource: BundleResource
    let parser: DataParser

    init(resource: BundleResource, parser: DataParser) {
        self.resource = resource
        self.parser = parser
    }
    
    // MARK: - Parse Laureates data
    func parse(completion: @escaping (Result<[LaureateModel], Error>) -> Void) {

        do {
            let path = try resource.getFilePath()
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let result: [LaureateModel] = try parser.parse(data: data)
            completion(.success(result))
        } catch {
            completion(.failure(error))
        }
    }
}
