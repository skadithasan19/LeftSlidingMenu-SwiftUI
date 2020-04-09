//
//  LeftMenuView.swift
//  KeechaoSwiftUI+Combine
//
//  Created by Hasan, MdAdit on 3/22/20.
//  Copyright © 2020 Hasan, MdAdit. All rights reserved.
//

import SwiftUI
import Combine

class LeftMenuAction: ObservableObject {
    
    static let shareInstance = LeftMenuAction()
    
    @Published var selectedItem = CommonView(title:"Home")
}

struct LeftMenuView: View {
     
    var menus = [Menu(title: "Home", icon: "house"),
                 Menu(title: "Accounts", icon: "person.crop.circle"),
                 Menu(title: "FAQ", icon: "questionmark.circle"),
                 Menu(title: "Terms & Privacy", icon: "doc.fill")]
    
    @Binding var showMenu: Bool
    
    var body: some View {
        HStack {
            List(menus, id: \.title) { item in
                MenuCell(showMenu: self.$showMenu, item: item)
            }
            Divider()
        }.padding(.top, 50)
        .navigationBarTitle(Text("").font(.title), displayMode: .inline)
    }
}

struct MenuCell: View {
    
    @Binding var showMenu:Bool
    
    var item:Menu
    
    @ObservedObject var SharedLeftMenu = LeftMenuAction.shareInstance
     
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: item.icon)
                    .frame(width:30)
                    .font(Font.system(size: 20, weight: .ultraLight))
                    .foregroundColor(.gray)
                Text(item.title)
                    .foregroundColor(.gray)
                    .font(Font.system(size: 18, weight: .light))
                    .multilineTextAlignment(.leading)
                Spacer()
            }
        }.padding()
            .onTapGesture(perform: {
                withAnimation {
                    self.SharedLeftMenu.selectedItem = CommonView(title: self.item.title)
                    self.showMenu.toggle()
                }
            })
    }
}


