//
//  SearchBar.swift
//  big_project_c_admin_ipados
//
//  Created by 조운상 on 2023/01/03.
//

import SwiftUI
 
struct SearchBar: View {
    
    @Binding var text: String
 
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
 
                TextField("관리자 계정을 검색해주세요", text: $text)
                    .foregroundColor(.primary)
 
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
            .font(.system(size: 20))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
        .border(Color.accentColor)
        .padding(.trailing, 30)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
