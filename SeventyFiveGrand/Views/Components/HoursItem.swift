//
//  HoursItem.swift
//  SeventyFiveGrand
//
//  Created by Jerome Paulos on 12/18/22.
//

import SwiftUI

struct HoursItem: View {
    var compact = false
    @State var snapshot: Hours.Snapshot

    var body: some View {
        let layout = compact
            ? AnyLayout(VStackLayout(alignment: .leading, spacing: 0))
            : AnyLayout(HStackLayout())

        layout {
            HStack {
                Circle().fill(snapshot.color).fixedSize()
                Text(snapshot.name)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Spacer()
            }

            Text(snapshot.message)
                .foregroundColor(.secondary)
                .fixedSize()
                .lineLimit(1)
                .truncationMode(.head)
        }
    }
}

struct HoursItem_Previews: PreviewProvider {
    static var previews: some View {
        HoursItem(
            compact: true,
            snapshot: Hours.Snapshot(
                name: "Library",
                color: .green,
                message: "closes in 2m"
            )
        ).padding()
    }
}
