//
//  HomeView.swift
//  SeventyFiveGrand
//
//  Created by Jerome Paulos on 12/14/22.
//

import SwiftUI
import OrderedCollections

struct HomeView: View {
    @State private var links = [Link]()
    
    var allLinks: OrderedDictionary<String, [Link]> {
        OrderedDictionary(grouping: links, by: \.category)
    }

    var categoriesWithLinks: [String: [Link]] {
        var result: [String: [Link]] = [:]

        links.forEach { link in
            if result[link.category] == nil {
                result[link.category] = []
            }

            result[link.category]?.append(link)
        }

        return result
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(allLinks.keys), id: \.self) { category in
                    Section {
                        ForEach(allLinks[category]!) { link in
                            NavigationLink {
                                WebView(url: link.urlObject)
                                    .navigationTitle(link.name)
                            } label: {
                                HStack {
                                    link.icon.foregroundColor(.accentColor)
                                    Text(link.name)
                                }
                            }
                        }
                    } header: {
                        Text(category)
                    }
                }
            }.listStyle(.sidebar).headerProminence(.increased)
                .task {
                    links = await NetworkManager.getLinks() ?? []
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(tab: "home")
    }
}
