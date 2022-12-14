//
//  Hours.swift
//  SeventyFiveGrand
//
//  Created by Jerome Paulos on 12/19/22.
//

import Foundation
import SwiftUI

struct Hours: Decodable {
    var name: String
    var events: [Event]
    
    func getSnapshot(for date: Date) -> Snapshot {
        if let event = getEvent(for: date) {
            let timeAgoParts = RelativeDateTimeFormatter().localizedString(
                for: event.startDate < date ? event.startDate : event.endDate,
                relativeTo: date
            ).split(separator: " ", maxSplits: 1)

            let timeAgo = String(timeAgoParts[0]) + String(timeAgoParts[1].first!)

            return Snapshot(
                name: name,
                color: event.startDate > date ? .green : .red,
                message: timeAgo
            )
        }
        
        return Snapshot(
            name: name,
            color: .gray,
            message: "Error"
        )
    }

    /// Get current event or next event
    private func getEvent(for date: Date) -> Event? {
        for (index, event) in events.enumerated() {
            // Skip events in the past
            if date > event.endDate {
                continue
            }

            // The current event
            if date >= event.startDate {
                return event
            }

            // If there is another date
            if index + 1 < events.count {
                let nextEvent = events[index + 1]
                
                // If date hasn't begun
                if date < nextEvent.startDate {
                    return nextEvent
                }
            }
        }
        
        return nil
    }
    
    struct Event: Decodable {
        var textBeforeStart: String
        var startDate: Date
        var textBeforeEnd: String
        var endDate: Date
    }
    
    struct Snapshot {
        var name: String
        var color: Color
        var message: String
    }
}
