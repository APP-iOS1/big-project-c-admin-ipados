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
    
    @ObservedObject var seminarStore: SeminarStore
    @EnvironmentObject var attendanceStore : AttendanceStore
    
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
                            Text("세션 수정하기")
                                .padding(.vertical, 13)
                                .padding(.trailing, 28)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.accentColor)
                                .cornerRadius(15)
                        }
                        .sheet(isPresented: $clickedEditButton) {
                            EditSessionView(seminarStore: seminarStore, seminar: selectedContent ?? Seminar(id: "", image: [], name: "", date: Date(), startingTime: "", endingTime: "", category: "", location: "", locationUrl: "", hostName: "", hostImage: "", hostIntroduction: "", seminarDescription: "", seminarCurriculum: ""))
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
            isDeviceCapacity = (DataScannerViewController.isSupported && DataScannerViewController.isAvailable)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct SessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SessionDetailView(seminarStore: SeminarStore())
    }
}
