//
//  SettingsRowViews.swift
//  FBAuth
//
//  Created by Reyab Saluja on 2023-10-02.
//

import SwiftUI

struct SettingsRowViews: View {
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
}

struct SettingsRowViews_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowViews(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
    }
}
