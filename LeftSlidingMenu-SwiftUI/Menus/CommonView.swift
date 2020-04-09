//
//  CommonView.swift
//  LeftSlidingMenu-SwiftUI
//
//  Created by Hasan, MdAdit on 4/9/20.
//  Copyright © 2020 FirstAlert. All rights reserved.
//

import SwiftUI


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
