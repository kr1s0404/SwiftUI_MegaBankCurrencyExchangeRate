//
//  WidgetApp.swift
//  MegaBankExchangeRate
//
//  Created by Kris on 3/27/22.
//

import SwiftUI
import WidgetKit

@main
struct MyWidget: Widget {
    let kind: String = "MyWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MyWidgetEntryView(data: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemLarge])
    }
}

struct MyWidget_Previews: PreviewProvider {
    
    
    static var previews: some View {
        MyWidgetEntryView(data: Model.fakeDate())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
