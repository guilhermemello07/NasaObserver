//
//  DateFormatter.swift
//  NasaObserver
//
//  Created by Guilherme Teixeira de Mello on 01/03/2025.
//

import Foundation

class DateFormatterHelper {
    static let shared = DateFormatterHelper()
    
    private init() { }
    
    // For the API call
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    // To display dates in a better way
    func displayDate(from apiDateString: String) -> String {
        let apiFormatter = DateFormatter()
        apiFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = apiFormatter.date(from: apiDateString) else {
            return apiDateString
        }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        displayFormatter.timeStyle = .none
        
        return displayFormatter.string(from: date)
    }
}
