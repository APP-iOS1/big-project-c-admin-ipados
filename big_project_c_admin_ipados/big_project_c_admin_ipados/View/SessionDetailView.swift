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
    @StateObject var questionStore: QuestionStore = QuestionStore()
    //    @ObservedObject var questionInfo: QuestionStore
    
    //    @Binding var seminarList: Seminar
    @Binding var seminarId: Seminar.ID?
    @State private var clickedEditButton: Bool = false
    @State private var clickedQRButton: Bool = false
    
    //MARK: - 게시글 삭제를 위한 Alert 띄우기 Flag 추가
    @State private var isDeleteButton: Bool = false
    
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
    var body: some View {
        GeometryReader { geo in
            HStack {
                VStack(alignment: .leading) {
                    
                    HStack {
                        VStack(alignment: .leading) {
                            // MARK: - 세미나 티이틀
                            Text(selectedContent?.name ?? "")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            HStack {
                                 // MARK: - 날짜, 위치
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: "calendar")
                                        Text(selectedContent?.createdDate ?? "")
                                            .font(.subheadline)
                                            .padding(.trailing, 5)
                                        Image(systemName: "mappin.and.ellipse")
                                        Text(selectedContent?.location ?? "")
                                            .font(.subheadline)
                                        
                                    }
                                    HStack {
                                        // MARK: - 날짜, 위치
                                        Button {
                                            clickedEditButton.toggle()
                                        } label: {
                                            Text("수정 하기")
                                                .padding(.vertical, 13)
                                                .padding(.trailing, 28)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color.accentColor)
                                                .cornerRadius(15)
                                        }
                                        .sheet(isPresented: $clickedEditButton) {
                                            EditSessionView(seminarStore: seminarStore, seminar: selectedContent ?? Seminar(id: "", image: [], name: "", date: Date(), startingTime: "", endingTime: "", category: "", location: "", locationUrl: "", hostName: "", hostImage : "", hostIntroduction: "", seminarDescription: "", seminarCurriculum: ""))
                                        }
                                        
                                        
                                        Button {
                                            isDeleteButton.toggle()
                                        } label: {
                                            Text("삭제 하기")
                                                .padding(.vertical, 13)
                                                .padding(.trailing, 28)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color.accentColor)
                                                .cornerRadius(15)
                                        }
                                        .alert(isPresented: $isDeleteButton) {
                                            Alert(title: Text("삭제 하시겠습니까?"),
                                                  message: Text("삭제 후 복구 불가!"),
                                                  primaryButton: .destructive(Text("삭제"), action: {
                                                seminarStore.deleteSeminar(seminar: selectedContent ?? Seminar(id: "", image: [], name: "", date: Date(), startingTime: "", endingTime: "", category: "", location: "", locationUrl: "", hostName: "", hostImage : "", hostIntroduction: "", seminarDescription: "", seminarCurriculum: ""))
                                            }), secondaryButton: .cancel(Text("취소")))
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                // MARK: - QR 코드 버튼
                                HStack {
                                    Button {
                                        // TODO: QR코드 연결
                                        if isDeviceCapacity {
                                            self.showCameraScannerView = true
                                        } else {
                                            self.showDeviceNotCapacityAlert = true
                                        }
                                        
                                    } label: {
                                        Text("QR 출석체크")
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
                            
                            
                            // MARK: -View : Q&A 리스트 관리
                            HStack {
                                Text("받은 Q&A")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                Spacer()
                                Button {
                                    questionStore.fetchQuestion(seminarID: seminarId ?? "")
                                } label: {
                                    Image(systemName: "arrow.clockwise")
                                        .foregroundColor(.black)
                                        .padding(.trailing, 20)
                                        .font(.title3)
                                    
                                }
                                
                            }
                            
                            
                            
                            List(questionStore.questionList, id:\.self) { question in
                                Text(question.question)
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
                            .listStyle(InsetListStyle())
                            .padding(.leading, -13)
                            .refreshable {
                                questionStore.fetchQuestion(seminarID: seminarId ?? "")
                            }
                            
                            
                        }
                        
                        .frame(minHeight: 50)
                        
                        
                        // MARK: -View : 오른쪽 사이드 유저 리스트
                        SessionDetailUserList(selectedContent: selectedContent)
                            .frame(width: geo.size.width/4.5)
                            .padding(.trailing, 20)
                    }
                    .padding(.leading, 40)
                    .padding(.trailing, 10)
                    
                    
                   
                }
            }
            .sheet(isPresented: $showCameraScannerView) {
                CameraScanner(startScanning: $showCameraScannerView, seminarID: selectedContent?.id ?? "")
                    .alert("스캐너 사용불가", isPresented: $showDeviceNotCapacityAlert, actions: {})
            }
            .onAppear {
                isDeviceCapacity = (DataScannerViewController.isSupported && DataScannerViewController.isAvailable)
                
                questionStore.fetchQuestion(seminarID: seminarId ?? "")
            }
            .onChange(of:seminarId) { newValue in
                questionStore.fetchQuestion(seminarID: newValue ?? "")
                
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//struct SessionDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        SessionDetailView(seminarStore: SeminarStore())
//    }
//}
