//
//  BannerView.swift
//  JBT_iOS
//
//  Created by 강인혜 on 7/16/24.
//

import SwiftUI

struct BannerView: View {
    @State private var selection = 0
    let timer = Timer.publish(every: 3, on: .main, in: .common)
    let images = ["Banner1", "Banner2", "Banner3"]
    
    var body: some View {
        VStack(alignment: .center) {
            TabView(selection: $selection) {
                ForEach(0..<3) { i in
                    Image("\(images[i])").resizable()
                }
            }.tabViewStyle(PageTabViewStyle())
        }
    }
}

#Preview {
    BannerView()
}
