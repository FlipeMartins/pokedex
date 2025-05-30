//
//  MockHelper.swift
//  Pokedex
//
//  Created by Felipe Martins on 30/05/25.
//

import Foundation

class MockHelper {
    
    static func mockData<T: Decodable>(of type: T.Type,
                                          fileName: String,
                                          fileExtension: String,
                                          completion: @escaping (T) -> Void) {

        guard let path = Bundle.main.path(forResource: fileName, ofType: fileExtension),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            fatalError()
        }

        do {
            let decodedValue = try JSONDecoder().decode(type.self, from: data)
            completion(decodedValue)
        } catch {
            fatalError()
        }

    }
    
}
