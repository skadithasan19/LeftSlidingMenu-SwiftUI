//
//  DeviceLandingPage.swift
//  FirstAlertSA
//
//  Created by Hasan, MdAdit on 4/8/20.
//  Copyright © 2020 First Alert Inc. All rights reserved.
//

import SwiftUI

struct LandingPage: View {
    
    @State var showMenu = false
    
    @State var searchAction = false
    
    @ObservedObject var SharedLeftMenu = LeftMenuAction.shareInstance
    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
        }
        
        return
            GeometryReader { geometry in
                
                NavigationView {
                    ZStack(alignment: .leading) {
                        
                        self.SharedLeftMenu.selectedItem.containedView()
                            
                            .navigationBarTitle(Text(self.SharedLeftMenu.selectedItem.viewType.rawValue).font(.title), displayMode: .inline)
                            .navigationBarItems(leading: (
                                Button(action: { withAnimation {
                                    self.showMenu.toggle()
                                    }
                                }) {
                                    Image(systemName: "line.horizontal.3")
                                        .frame(width: 44, height: 44)
                                        .imageScale(.large)
                                        .foregroundColor(Color.black)
                            }))
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height)
                            .offset(x: self.showMenu ? ((geometry.size.width/2) + 80) : 0)
                        //  .disabled(self.showMenu ? true : false)
                        
                        if self.showMenu {
                            LeftMenuView(showMenu: self.$showMenu)
                                .frame(width: ((geometry.size.width/2) + 80))
                                .transition(.move(edge: .leading))
                        }
                    }
                    .gesture(drag)
                } 
        }
    }
}



extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = .white
        
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.backgroundColor = .green
        
        let compactAppearance = UINavigationBarAppearance()
        compactAppearance.backgroundColor = .orange
        
        navigationBar.standardAppearance = standardAppearance
        navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
        navigationBar.compactAppearance = compactAppearance
    }
}
