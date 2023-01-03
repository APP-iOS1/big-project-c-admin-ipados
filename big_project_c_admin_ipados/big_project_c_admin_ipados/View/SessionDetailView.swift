//
//  SessionDetailView.swift
//  big_project_c_admin_ipados
//
//  Created by TEDDY on 12/27/22.
//

import SwiftUI
import VisionKit

struct SessionDetailView: View {
    @State private var showCameraScannerView = false
    @State private var isDeviceCapacity = false
    @State private var showDeviceNotCapacityAlert = false
    
    //    @State private var scanIdResult : String = ""
    //    @State private var scanUserUidResult : String = ""
    //    @State private var scanUserNickNameResult : String = ""
    @ObservedObject var seminarStore: SeminarStore
    @EnvironmentObject var attendanceStore : AttendanceStore
    //    @ObservedObject var questionInfo: QuestionStore
    
    //    @Binding var seminarList: Seminar
    
    
    var seminarId: Seminar.ID?
    @State private var clickedEditButton: Bool = false
    @State private var clickedQRButton: Bool = false
    
    var selectedContent: Seminar? {
        get {
            for sample in seminarStore.seminarList {
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
    
    @State private var isDeleteButton: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text(selectedContent?.name ?? "강의 제목")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        //  MARK: -View : 수정 버튼
                        // TODO: EditSession 연결
                        Button {
                            clickedEditButton.toggle()
                        } label: {
                            Text("수정 하기")
                                .padding(.vertical, 13)
                                .padding(.trailing, 28)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.accentColor)
                                .cornerRadius(15)
                        }
                        .sheet(isPresented: $clickedEditButton) {
                            EditSessionView(seminarStore: seminarStore, seminar: selectedContent ?? Seminar(id: "", image: [], name: "", date: Date(), startingTime: "", endingTime: "", category: "", location: "", locationUrl: "", host: "", hostIntroduction: "", seminarDescription: "", seminarCurriculum: ""))
                        }
                        
                    }
                    
                    .frame(minHeight: 50)
                    
                    
                    HStack {
                        Image(systemName: "calendar")
                        Text(selectedContent?.createdDate ?? "2023-01-01")
                            .font(.subheadline)
                            .padding(.trailing, 15)
                        Image(systemName: "mappin.and.ellipse")
                        Text(selectedContent?.location ?? "멋쟁이사자처럼 광화문 오피스")
                            .font(.subheadline)
                        
                        Spacer()
                        
                        Button {
                            clickedQRButton.toggle()
                        } label: {
                            Text("QR 출석 체크")
                                .padding(.vertical, 13)
                                .padding(.horizontal, 30)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .background(Color.accentColor)
                                .cornerRadius(15)
                        }
                         Spacer()
                        Button {
                            isDeleteButton.toggle()
                        } label: {
                            Text("삭제 하기")
                                .padding(.vertical, 13)
                                .padding(.trailing, 28)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.accentColor)
                                .cornerRadius(15)
                        }
                        .alert(isPresented: $isDeleteButton) {
                            Alert(title: Text("삭제 하시겠습니까?"),
                                  message: Text("삭제 후 복구 불가!"),
                                  primaryButton: .destructive(Text("삭제"), action: {
                                seminarStore.deleteSeminar(seminar: selectedContent ?? Seminar(id: "", image: [], name: "", date: Date(), startingTime: "", endingTime: "", category: "", location: "", locationUrl: "", host: "", hostIntroduction: "", seminarDescription: "", seminarCurriculum: ""))
                            }), secondaryButton: .cancel(Text("취소")))
                        }
                    }
                    .frame(minHeight: 30)
                    
                    Divider()
                        .padding(.vertical, 20)
                    
                    
                    // MARK: -View : Q&A 리스트 관리
                    // TODO: Question 데이터 연결 (댓글 내용, 시간대 띄워주기)
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
                                            leading: 10,
                                            bottom: 10,
                                            trailing: 10
                                        )
                                    )
                                
                            )
                            .listRowSeparator(.hidden)
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(PlainListStyle())
                    .padding(.leading, -13)
                    
                    
                    
                    Spacer()
                }
                .padding(.leading, 40)
                .padding(.trailing, 10)
                
                
                // MARK: -View : 오른쪽 사이드 유저 리스트
                SessionDetailUserList(selectedContent: selectedContent)
                    .frame(width: geo.size.width/4.5)
                    .padding(.trailing, 20)
            }
        }
        .sheet(isPresented: $showCameraScannerView) {
            CameraScanner(startScanning: $showCameraScannerView, seminarID: selectedContent?.id ?? "")
                .alert("스캐너 사용불가", isPresented: $showDeviceNotCapacityAlert, actions: {})
        }
        .onAppear {
            //            print("온어피어")
            //            print("세미나 아이디", selectedContent?.id)
            isDeviceCapacity = (DataScannerViewController.isSupported && DataScannerViewController.isAvailable)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


//
//
//            ZStack {
//                if selectedContent == nil {
//                    Image("LoginLogo")
//                        .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
//                }
//                else {
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text(selectedContent?.name ?? "")
//                                .font(.title)
//                                .fontWeight(.bold)
//                            HStack {
//                                HStack {
//                                    Image(systemName: "calendar")
//                                    Text(selectedContent?.createdDate ?? "")
//                                        .font(.subheadline)
//                                        .padding(.trailing, 5)
//                                    Image(systemName: "mappin.and.ellipse")
//                                    Text(selectedContent?.location ?? "")
//                                        .font(.subheadline)
//                                }
//
//                                Spacer()
//
//                                HStack {
//
//                                        Button {
//                                            // TODO: 내용 수정 기능 구현
//                                            clickedEditButton = true
//                                        } label: {
//                                            Text("세미나 내용 수정하기")
//                                                .frame(width: 150)
//                                                .padding(12)
//                                                .fontWeight(.bold)
//                                                .foregroundColor(Color.white)
//                                                .background(Color.accentColor)
//                                                .cornerRadius(15)
//                                        }
//                                        .fullScreenCover(isPresented: $clickedEditButton) {
////                                            EditSessionView(seminarInfo: seminarInfo, selectedContent: selectedContent)
//                                            EditTestView(seminarInfo: seminarInfo, seminarID: selectedContent?.id ?? "")
//                                        }
//
//
//                                    Button {
//                                        // TODO: QR코드 연결
//                                        if isDeviceCapacity {
//                                            self.showCameraScannerView = true
//                                        } else {
//                                            self.showDeviceNotCapacityAlert = true
//                                        }
//                                    } label: {
//                                        Text("QR코드")
//                                            .frame(width: 150)
//                                            .padding(12)
//                                            .fontWeight(.bold)
//                                            .foregroundColor(Color.white)
//                                            .background(Color.accentColor)
//                                            .cornerRadius(15)
//                                    }
//
//                                }
//                            }
//
//                            Divider()
//                                .padding(.vertical, 20)
//
//
//                            // MARK: -View : Q&A 리스트 관리
//                            Text("받은 Q&A")
//                                .font(.largeTitle)
//                                .fontWeight(.bold)
//
//                            List(dummyQuestions, id:\.self) { question in
//                                Text(question)
//                                    .padding()
//                                    .listRowBackground(
//                                        RoundedRectangle(cornerRadius: 10)
//                                            .fill(Color.secondary.opacity(0.15))
//                                            .foregroundColor(.white)
//                                            .padding(
//                                                EdgeInsets(
//                                                    top: 10,
//                                                    leading: 0,
//                                                    bottom: 10,
//                                                    trailing: 0
//                                                )
//                                            )
//
//                                    )
//                                    .listRowSeparator(.hidden)
//                            }
//                            .scrollContentBackground(.hidden)
//                            .listStyle(InsetGroupedListStyle())
//                            .padding(.leading, -13)
//
//
//
//                            Spacer()
//                        }
//                        .padding(.leading, 40)
//
//
//                        // MARK: -View : 오른쪽 사이드 유저 리스트
//        //                SessionDetailUserList(seminarID: seminarId)
//                        SessionDetailUserList(selectedContent: selectedContent)
//                            .frame(width: geo.size.width/4.5)
//                            .padding(.trailing, 20)
//                    }
//                }
//            }
//            .sheet(isPresented: $showCameraScannerView) {
//                CameraScanner(startScanning: $showCameraScannerView, seminarID: selectedContent?.id ?? "")
//                        }
//            .alert("스캐너 사용불가", isPresented: $showDeviceNotCapacityAlert, actions: {})
//        }
//        .onAppear {
////            print("온어피어")
////            print("세미나 아이디", selectedContent?.id)
//            isDeviceCapacity = (DataScannerViewController.isSupported && DataScannerViewController.isAvailable)
//        }
//
//    }
//}


struct SessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SessionDetailView(seminarStore: SeminarStore())
    }
}
