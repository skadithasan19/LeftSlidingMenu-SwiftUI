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
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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

struct Menu {
    var title:String
    var icon:String
}

public enum ViewType: String {
    case Home
    case Accounts
    case FAQ
    case TermsAndPrivacy
}

class CommonView {
    
    var viewType:ViewType = .Home
    
    init(title:String) {
        
        switch title {
        case "Home":
            viewType = .Home
            break
        case "Accounts":
            viewType = .Accounts
            break
        case "FAQ":
            viewType = .FAQ
            break
        case "Terms & Privacy":
            viewType = .TermsAndPrivacy
            break
        default:
            viewType = .Home
            break
        }
    }
    
    func getViewType() -> ViewType {
        return viewType
    }
    
    func containedView() -> AnyView {
        
        switch viewType {
        case .Home:
            return AnyView(HomeView())
            
        case .Accounts:
            return AnyView(AccountView())
            
        case .FAQ:
            return AnyView(FAQView())
            
        case .TermsAndPrivacy:
            return AnyView(TermsAndPrivacyView())
        }
    }
}
