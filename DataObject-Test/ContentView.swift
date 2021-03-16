//
//  ContentView.swift
//  DataObject-Test
//
//  Created by Leif on 3/15/21.
//

import SwiftUI
import DataObject

struct ContentView: View {
    @State private var currentView: AnyView = AnyView(ProgressView())
    
    var body: some View {
        currentView
            .onAppear {
                "https://avatars.githubusercontent.com/u/8268288?s=460&u=f3ef15376e7a613d4f739fa42624a07c03c0370e&v=4"
                    .url?
                    .func { (url) in
                        DispatchQueue.global().async {
                            url.get { (dataObject) in
                                dataObject.sout()
                                
                                dataObject.data.value(as: Data.self)
                                    .map { UIImage(data: $0) }?
                                    .replace(nilWith: UIImage())
                                    .func { image in
                                        DispatchQueue.main.async {
                                            currentView = AnyView(
                                                Image(uiImage: image)
                                                    .padding()
                                            )
                                        }
                                    }
                                
                            }
                        }
                        
                        currentView = AnyView(
                            Text("Loading...")
                                .padding()
                        )
                    }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
