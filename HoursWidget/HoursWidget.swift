//
//  HoursWidget.swift
//  HoursWidget
//
//  Created by Jerome Paulos on 12/18/22.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct HoursWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack(spacing: 6) {
            ForEach(0...2, id: \.self) { index in
                HoursItem(
                    compact: true,
                    snapshot: Hours.Snapshot(
                        name: "Library",
                        color: .green,
                        message: "closes in 2m"
                    )
                )

                if index < 2 {
                    Divider()
                }
            }
        }.padding()
    }
}

struct HoursWidget: Widget {
    let kind: String = "HoursWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            HoursWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("What's Open?")
        .description("Displays the hours of campus services")
    }
}

struct HoursWidget_Previews: PreviewProvider {
    static var previews: some View {
        HoursWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
