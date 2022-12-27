//
//  GeneralView.swift
//  big_project_c_admin_ipados
//
//  Created by TEDDY on 12/27/22.
//

import SwiftUI

struct SessionDetailView: View {
    @ObservedObject var euni: EuniStore

    var euniId: Euni.ID?
    @State private var clickedEditButton: Bool = false
    @State private var clickedQRButton: Bool = false
    
    var selectedContent: Euni? {
        get {
            for sample in euni.eunis {
                if sample.id == euniId {
                    return sample
                }
            }
            return nil
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(selectedContent?.title ?? "")
                .font(.title)
                .fontWeight(.bold)
            HStack {
                HStack {
                    Image(systemName: "calendar")
                    Text(selectedContent?.time ?? "")
                    Image(systemName: "mappin.and.ellipse")
                    Text(selectedContent?.location ?? "")
                }
                .font(.caption2)
                
                Spacer()
                
                HStack {
                    Button {
                        // TODO: 내용 수정 기능 구현
                        clickedEditButton.toggle()
                    } label: {
                        Text("세미나 내용 수정하기")
                            .frame(width: 150)
                            .padding(12)
                            .fontWeight(.bold)
                            .foregroundColor(clickedEditButton ? Color.accentColor : Color.white)
                            .background(clickedEditButton ? Color.white : Color.accentColor)
                            .cornerRadius(15)
                    }
                    
                    Button {
                        // TODO: QR코드 연결
                        clickedQRButton.toggle()
                    } label: {
                        Text("QR코드")
                            .frame(width: 150)
                            .padding(12)
                            .fontWeight(.bold)
                            .foregroundColor(clickedQRButton ? Color.accentColor : Color.white)
                            .background(clickedQRButton ? Color.white : Color.accentColor)
                            .cornerRadius(15)
                    }

                }
            }
            
            Divider()
            

            
            Text("받은 Q&A")
                .font(.largeTitle)
                .fontWeight(.bold)
            

            Spacer()
        }
        .padding(.horizontal, 80)
    }
}


//struct SessionDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        SessionDetailView()
//    }
//}
