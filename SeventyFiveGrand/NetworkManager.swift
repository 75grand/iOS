//
//  NetworkManager.swift
//  SeventyFiveGrand
//
//  Created by Jerome Paulos on 12/18/22.
//

import Foundation

struct NetworkManager {

    static private var baseUrl: String {
        #if targetEnvironment(simulator)
            return "http://localhost:8000/api"
        #else
            return "https://75grand.net/api"
        #endif
    }

    static func getHours() async -> [Hours]? {
        await get(
            url: "/hours",
            decodeTo: [Hours].self
        )
    }
    
    static func getLinks() async -> [Link]? {
        await get(
            url: "/links", // https://opensheet.elk.sh/1gv_sQRICWTmUycCE8PUe0RyVRUNZTHnGi7MSfrnJHP8/Links
            decodeTo: [Link].self
        )
    }

    /// Converts a string to a URL, prepending the base URL to otherwise invalid paths
    private static func stringToUrl(_ string: String) -> URL? {
        if string.starts(with: "/") {
            return URL(string: baseUrl + string)
        } else {
            return URL(string: string)
        }
    }

    private static func get<T: Decodable>(url urlString: String, decodeTo type: T.Type) async -> T? {
        guard let url = stringToUrl(urlString) else {
            print("Unable to transform to URL: \(urlString)")
            return nil
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Error fetching or parsing data: \(error)")
        }
        
        return nil
    }

}
