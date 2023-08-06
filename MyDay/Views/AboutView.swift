//
//  AboutView.swift
//  MyDay
//
//  Created by Sp1der on 2023/8/5.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("Icon")
                    .resizable()
                    .frame(width: 80, height: 80)
                Text("My Day")
                    .font(.title)
                    .bold()
                Text("iOS version")
                    .font(.footnote)
                    .padding(.bottom,20)
                Text("作者：Sp1der")
                Spacer()
            }
            .padding(.top, 50)
            .navigationTitle("About")
            
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
