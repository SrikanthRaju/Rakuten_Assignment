//
//  DataParser.swift
//  Rakuten_Assignment
//
//  Created by Srikanth on 16/12/20.
//

import Foundation


struct LaureateJSONParser: DataParser {
    
    func parse<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        
        do {
        let result  = try decoder.decode(T.self, from: data)
            return result
        } catch {
            throw ParseError.decodingError
        }
    }
}



// MARK: - Data Parser Error Types

enum ParseError: Error {
    case decodingError
}





// MARK: - Data Parser protocol

protocol DataParser {
    
    func parse<T: Decodable>(data: Data) throws -> T
}
