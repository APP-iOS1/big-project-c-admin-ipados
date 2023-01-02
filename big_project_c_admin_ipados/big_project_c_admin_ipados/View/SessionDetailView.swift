//
//  SessionDetailView.swift
//  big_project_c_admin_ipados
//
//  Created by TEDDY on 12/27/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct SessionDetailView: View {
    @ObservedObject var seminarInfo: SeminarStore
//    @ObservedObject var questionInfo: QuestionStore

    var seminarId: Seminar.ID?
    @State private var clickedEditButton: Bool = false
    @State private var clickedQRButton: Bool = false
    
    var selectedContent: Seminar? {
        get {
            for sample in seminarInfo.seminarList {
                if sample.id == seminarId {
                    return sample
                }
            }
            return nil
        }
    }
    
    let dummyQuestions: [String] = [
        "댓글입니다아아아아아아아아아아1",
        "댓글입니다아아아아아아아아아아2",
        "댓글입니다아아아아아아아아아아3",
        "댓글입니다아아아아아아아아아아4",
        "댓글입니다아아아아아아아아아아1",
        "댓글입니다아아아아아아아아아아2",
        "댓글입니다아아아아아아아아아아3",
        "댓글입니다아아아아아아아아아아1",
        "댓글입니다아아아아아아아아아아2",
        "댓글입니다아아아아아아아아아아3",
        "댓글입니다아아아아아아아아아아1",
        "댓글입니다아아아아아아아아아아2",
        "댓글입니다아아아아아아아아아아3",
        "댓글입니다아아아아아아아아아아1",
        "댓글입니다아아아아아아아아아아2",
        "댓글입니다아아아아아아아아아아3",
        "댓글입니다아아아아아아아아아아1",
        "댓글입니다아아아아아아아아아아2",
        "댓글입니다아아아아아아아아아아3"
    ]
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                VStack(alignment: .leading) {
                    Text(selectedContent?.name ?? "")
                        .font(.title)
                        .fontWeight(.bold)
                    HStack {
                        HStack {
                            Image(systemName: "calendar")
                            Text(selectedContent?.createdDate ?? "")
                                .font(.subheadline)
                                .padding(.trailing, 5)
                            Image(systemName: "mappin.and.ellipse")
                            Text(selectedContent?.location ?? "")
                                .font(.subheadline)
                        }
                        
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
                                    .foregroundColor(Color.white)
                                    .background(Color.accentColor)
                                    .cornerRadius(15)
                            }
                            
                            Button {
                                clickedQRButton.toggle()
                            } label: {
                                Text("QR코드")
                                    .frame(width: 150)
                                    .padding(12)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                    .background(Color.accentColor)
                                    .cornerRadius(15)
                            }

                        }
                    }
                    
                    Divider()
                        .padding(.vertical, 20)
                    
                    WebImage(url: URL(string: selectedContent?.postImageUrl ?? ""))
                        .resizable()
                        .cornerRadius(25)
                        .frame(width: 50, height: 50)

                    // MARK: -View : Q&A 리스트 관리
                    Text("받은 Q&A")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    List(dummyQuestions, id:\.self) { question in
                        Text(question)
                            .padding()
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.secondary.opacity(0.15))
                                    .foregroundColor(.white)
                                    .padding(
                                        EdgeInsets(
                                            top: 10,
                                            leading: 0,
                                            bottom: 10,
                                            trailing: 0
                                        )
                                    )
                                
                            )
                            .listRowSeparator(.hidden)
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(InsetGroupedListStyle())
                    .padding(.leading, -13)

                    Spacer()
                }
                .padding(.leading, 40)
                .onAppear {
                    seminarInfo.fetchSeminar()
                }
                
                
                // MARK: -View : 오른쪽 사이드 유저 리스트
                SessionDetailUserList()
                    .frame(width: geo.size.width/4)
                    .padding(.trailing, 20)
            }
            .sheet(isPresented: $clickedQRButton) {
                ScanQRView()
            }
            
        }
        
    }
}


struct SessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SessionDetailView(seminarInfo: SeminarStore())
    }
}
