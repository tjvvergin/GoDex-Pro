//
//  LoadingView.swift
//  GODEX Pro
//
//  Created by Tyler Vergin on 5/11/23.
//

import SwiftUI

struct LoadingView: View {
    
    
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Please wait while we load the Pokemon")
                .multilineTextAlignment(.center)
                .padding(50)
            ProgressView()
                .padding(50)
        }
    }
}


//struct LoadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadingView(currentView: )
//    }
//}
