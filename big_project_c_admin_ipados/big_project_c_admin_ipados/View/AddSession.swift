//
//  AddSession.swift
//  big_project_c_admin_ipados
//
//  Created by TEDDY on 12/27/22.
//

import SwiftUI
import PhotosUI

struct AddSessionView: View {
    
    // MARK: - Seminar(Sesseion 정보) -> Store에서 나중에 가져올 예정
    @ObservedObject var seminar: SeminarStore

    // MARK: - 이미지 받아오기(PhotoURL)
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var image: String = ""
    
    //MARK: - Name (타이틀)
    @State private var name: String = ""
    
    // MARK: - date, startTime, endingTime (Date 피커)
    @State private var date: Date = Date()
    @State private var startringTime: String = ""
    @State private var endingTime: String = ""
    
    // MARK: - Category (카테고리)
    @State private var category: [String] = ["프론트","백엔드", "디자인", "블록체인"]
    // 카테고리 피커 돌리기
    @State private var selectedCategory: String = ""
    
    // MARK: - location 피커(3개 장소 임의로)
    @State private var location: String = ""
    @State private var loactionUrl: String = ""
    
    // MARK: - host, hostIntroduction (호스트 인포 - 프로필 사진, 강사소개)
    @State private var host: String = ""
    @State private var hostIntroduce: String = ""
    
    // MARK: - seminarDescription, seminarCurriculum (세미나 상세내용, 상세 커리큘럼)
    @State private var seminarDescription: String = ""
    @State private var seminarCurriculum: String = ""
    
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading) {
                    
                    // MARK: - 세미나 기본정보 타이틀
                    VStack(alignment: .leading) {
                        Text("세미나 기본정보")
                            .font(.largeTitle)
                    }
                    
                    Divider()
                    
                    
                    // 세미나 기본정보
                    
                    VStack {
                        Text("타이틀")
                            .font(.title2)
                        
                        TextField("세미나의 타이틀을 입력해 주세요.", text: $name)
                    }
                    
                    
                    HStack {
                        if image.isEmpty {
                            Image(systemName: "circle.fill")
                        } else {
                            AsyncImage(url: URL(string: image), scale: 2.0)
                                .frame(width: 250, height: 250)
                        }
                    }
                    
                    
                    //MARK: - datePicker
                    VStack(alignment: .leading) {
                        Text("날짜를 입력해주세요.")
                        HStack {
                            //TODO: - 날짜, 시간 DatePicker를 아이콘으로 만들고, 해당 값을 TextLabel로 작성되도록 하기
                            DatePicker("날짜", selection: $date, displayedComponents: .date)
                                .datePickerStyle(CompactDatePickerStyle())
                            Text("시작시간")
                            TextField("", text: $startringTime)
                            Spacer()
                            Text("종료시간")
                            TextField("", text: $endingTime)
                            //                                DatePicker("시간", selection: $date, displayedComponents: .hourAndMinute)
                            //                                Text("~")
                            //                                DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                        }
                    }
                    
                    //MARK: - categoryPicker
                    VStack {
                        HStack(spacing: 220) {
                            Text("세미나 유형을 선택해주세요.")
                            
                            Picker("세미나 유형을 선택해주세요", selection: $selectedCategory) {
                                ForEach(category, id: \.self) {
                                    Text($0)
                                }
                            }
                        }
                    }
                    // MARK: - PlacePicker
                    VStack(alignment: .leading) {
                        
                        HStack(spacing: 50) {
                            Text("장소")
                            TextField("", text: $location)
                            
                            // TODO: - 웹뷰 혹은 URL ? -> 내부 협의 필요
                            Text("세부장소")
                            //                                Spacer()
                            TextField("", text: $loactionUrl)
                        }
                    }
                    
                    // MARK: - HostInfo ( 호스트 인포 - 프로필 사진, 강사소개)
                    VStack {
                        Text("강사 소개")
                        HStack {
                            if host.isEmpty  {
                                Image(systemName: "circle.fill")
                            } else {
                                AsyncImage(url: URL(string: host), scale: 0.5)
                            }
                            VStack {
                                ZStack(alignment: .leading) {
                                    TextEditor(text: $hostIntroduce)
                                        .padding()
                                        .background(Color(.secondarySystemBackground))
                                        .frame(height: 150)
                                }
                            }
                            
                        }
                    }
                    
                    // MARK: - 세미나 상세내용
                    VStack {
                        VStack(alignment: .leading) {
                            Text("세미나 상세내용")
                            ZStack(alignment: .leading) {
                                TextEditor(text: $seminarDescription)
                                    .padding()
                                    .background(Color(.secondarySystemBackground))
                                    .frame(height: 300)
                                
                                if seminarDescription == "" {
                                    Text("내용을 입력해주세요.")
                                        .opacity(0.5)
                                        .offset(x: 180)
                                }
                            }
                            
                        }
                        Divider()
                        
                        // MARK: - 상세 커리큘럼
                        ZStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text("상세 커리큘럼을 입력해주세요.")
                                TextEditor(text: $seminarCurriculum)
                                    .padding()
                                    .background(Color(.secondarySystemBackground))
                                    .frame(height: 300)
                                
                                if seminarCurriculum == "" {
                                    Text("내용을 입력해주세요.")
                                        .opacity(0.5)
                                        .offset(x: 180, y: -160)
                                }
                            }
                        }
                        
                        // MARK: - 세미나 등록하기 버튼 추가 (데이터)
                        VStack(alignment: .center) {
                            Button {
                                seminar.addSeminar(seminar: Seminar(id: UUID().uuidString, image: [image], name: name, date: date, startingTime: startringTime, endingTime: endingTime, category: selectedCategory, location: location, locationUrl: loactionUrl, host: host, hostIntroduction: hostIntroduce, seminarDescription: seminarDescription, seminarCurriculum: seminarCurriculum))
                            } label: {
                                Text("세미나 등록하기")
                                    .foregroundColor(.white)
                                    .padding()
                                // 등록하기
                            }
                            
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .background {
                                Color.mint
                            }
                            .cornerRadius(10)
                            
                        }
                    }
                }
            }
        }
        .padding(.all, 50)
    }
}





struct AddSessionView_Previews: PreviewProvider {
    static var previews: some View {
        AddSessionView(seminar: SeminarStore())
    }
}


//                    TextField("날짜", text: $sessionSchedule)
//                    DatePicker("날짜", selection: $sessionSchedule,
//                               displayedComponents: .date)
//                    DatePicker("시간", selection: $sessionSchedule,
//                               displayedComponents: .hourAndMinute)

