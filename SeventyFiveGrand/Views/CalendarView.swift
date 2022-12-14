//
//  CalendarView.swift
//  SeventyFiveGrand
//
//  Created by Jerome Paulos on 12/15/22.
//

import SwiftUI
import FeedKit

struct CalendarView: View {
    @State private var selectedDate = Date()
    @State private var events: [RSSFeedItem] = []
    
    private var eventsByDay: [String:[RSSFeedItem]] {
        var result: [String:[RSSFeedItem]] = [:]

        events.forEach { event in
            let day = event.pubDate?.formatted(date: .numeric, time: .omitted)
            result[day!] = result[day!] ?? []
            result[day!]?.append(event)
        }
        
        return result
    }
    
    var body: some View {
        if events.isEmpty {
            Button("Load Events", action: fetchEvents)
        } else {
            TabView {
                ForEach(Array(eventsByDay.keys), id: \.self) { day in
                    List {
                        Text(day).font(.headline)

                        ForEach(eventsByDay[day]!, id: \.guid?.value) { event in
                            Text(event.title!)
                        }
                    }
                }
            }.tabViewStyle(.page(indexDisplayMode: .never))
        }
        
//        VStack {
//            NavigationView {
//                List {
//                    Section {
//                        DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
//                            .datePickerStyle(.graphical)
//
//                        Button("Load Events", action: fetchEvents)
//                    }
//
//                    ForEach(events, id: \.guid?.value) { event in
//                        NavigationLink {
//                            Group {
//                                let url = URL(string: event.link! + "#main-title")!
//                                WebView(url: url)
//                            }.navigationTitle(event.title!)
//                        } label: {
//                            HStack {
//                                Image(systemName: "star.fill").foregroundColor(.yellow)
//
//                                VStack(alignment: .leading) {
//                                    Text(event.title!)
//                                        .lineLimit(1)
//                                        .truncationMode(.tail)
//
//                                    Text(event.pubDate!.formatted())
//                                        .font(.subheadline)
//                                        .foregroundColor(.secondary)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
    }
    
    func fetchEvents() -> Void {
        let feedUrl = URL(string: "https://webapps.macalester.edu/eventscalendar/events/rss/")!
        let parser = FeedParser(URL: feedUrl)
        parser.parseAsync { result in
            switch result {
                case .success(let feed):
                    events = feed.rssFeed!.items!
                case .failure(let error):
                    print(error)
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(tab: "calendar")
    }
}
