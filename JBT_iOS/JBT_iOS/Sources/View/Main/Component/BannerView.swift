//
//  BannerView.swift
//  JBT_iOS
//
//  Created by 강인혜 on 7/16/24.
//

import SwiftUI

struct BannerView: View {
    @State private var selection = 0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    let images = ["Banner1", "Banner2", "Banner3"]
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .gray400
        UIPageControl.appearance().pageIndicatorTintColor = .gray100
        UIPageControl.appearance().backgroundStyle = .minimal
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(0..<3) { i in
                Image("\(images[i])").resizable()
                    .frame(height: 148)
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
        .onReceive(timer, perform: { _ in
            withAnimation {
                selection = selection < 3 ? selection + 1 : 0
            }
        })
        .frame(height: 210)
    }
    
}

#Preview {
    BannerView()
}
