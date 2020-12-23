//
//  BundleResource.swift
//  Rakuten_Assignment
//
//  Created by Srikanth on 16/12/20.
//

import Foundation


struct JSONBundleFile: BundleResource {
    var fileName: String
    var fileType: String {
        return "json"
    }
    
    init(withName filename: String) {
        self.fileName = filename
    }
}


















// MARK: - Bundle Resource Error Types

enum ResourceError: Error {
  case fileNotFound
}





// MARK: - Bundle Resource protocol

protocol BundleResource {
    var fileName: String { get set}
    var fileType: String { get }
}

// MARK: Bundle Resource protocol Extension

// To load data from bundle based on file name and filetype
extension BundleResource {
    
    func getFilePath() throws -> String {
        if let path = Bundle.main.path(forResource: self.fileName, ofType: self.fileType) {
            return path
        } else {
            throw ResourceError.fileNotFound
        }
    }
}
