//
//  AddSession.swift
//  big_project_c_admin_ipados
//
//  Created by TEDDY on 12/27/22.
//

import SwiftUI
import PhotosUI

struct SessionDetailView: View {
    
    // MARK: - 이미지 받아오기(PhotoURL)
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    
    // MARK: - Event(Sesseion 정보) -> Store에서 나중에 가져올 예정
    // title, createdBy, Category, place, photoURL, body, introduce, curriculum)
    // photoURL -> 호스트 소개 프로필 사진을 받아오는 변수값으로 활용
    
    @State private var title: String = ""
    
    
    // MARK: - Category 피커 (4개 카테고리 임의로)
    @State private var categories: [String] = ["선택","A", "B", "C", "D"]
    @State private var selectedCategory: String = ""
    
    
    // MARK: - Place 피커(3개 장소 임의로)
    @State private var placeCategories: [String] = ["Place1", "Place2", "Place3"]
    @State private var SelectedPlaceCategory: String = ""

    // MARK: - createBy (Date 피커)
    @State private var sessionSchedule: Date = Date()
    
    
    // MARK: - TextEditor (세미나 상세내용, 상세 커리큘럼)
    @State private var bodyText: String = ""
    @State private var curriculumText: String = ""
    
    var body: some View {
        ZStack {
            HStack {
                // 세미나 등록하기
                // TODO: - 사진 추가 시, 여러장이 업로드 되도록 기능 보완 필요
                VStack(alignment: .leading) {
                    HStack {
                        PhotosPicker(
                            selection: $selectedItem,
                            matching: .images,
                            photoLibrary: .shared()) {
                                Text("+")
                                    .font(.title)
                            }
                            .tint(.purple)
                            .controlSize(.large)
                            .buttonStyle(.borderedProminent)
                        
                            .onChange(of: selectedItem) { newItem in
                                Task {
                                    // Retrieve selected asset in the form of Data
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        selectedImageData = data
                                    }
                                }
                            }
                        
                        if let selectedImageData,
                           let uiImage = UIImage(data: selectedImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 250)
                            
                        }
                    }
                    .frame(width: 200, height: 200)

                    // 세미나 기본정보
                    VStack(alignment: .leading) {
                        Text("세미나 기본정보")
                            .font(.title)
                       
                        
                        // 세부내용
                        VStack {
                            TextField("세미나의 이름을 입력해 주세요.", text: $title)
                        }
                        Divider()
                        
                        //MARK: - datePicker
                        VStack(alignment: .leading) {
                            Text("날짜를 입력해주세요.")
                            HStack {
                                //TODO: - 날짜, 시간 DatePicker를 아이콘으로 만들고, 해당 값을 TextLabel로 작성되도록 하기
                                DatePicker("날짜", selection: $sessionSchedule, displayedComponents: .date)
                                    .datePickerStyle(CompactDatePickerStyle())
                                DatePicker("시간", selection: $sessionSchedule, displayedComponents: .hourAndMinute)
                                Text("~")
                                DatePicker("", selection: $sessionSchedule, displayedComponents: .hourAndMinute)
                            }
                            
                        }
                        
                        Divider()
                        
                        //MARK: - categoryPicker
                        VStack {
                            HStack(spacing: 220) {
                                Text("세미나 유형을 선택해주세요")
                                
                                Picker("세미나 유형을 선택해주세요",selection: $selectedCategory) {
                                    ForEach(categories, id: \.self) {
                                        Text($0)
                                    }
                                }
                            }
                        }
                        Divider()
                        
                        // MARK: - PlacePicker
                        VStack(alignment: .leading) {
                            
                            HStack(spacing: 250) {
                                Text("장소를 입력해주세요.")
                                
                                Picker("장소를 입력해주세요",selection: $SelectedPlaceCategory) {
                                    ForEach(placeCategories, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .datePickerStyle(.compact)
                                .labelsHidden()
                            }
                        }
                        
                        Divider()
                        
                        // TODO: - 호스트 소개부분 기능구현 예정
                        VStack(alignment: .leading) {
                            Text("강사소개")
                        }
                        .frame(width: 500, height: 200)
                        
                    }
                }
                .frame(width: 500, height: 900)
        
                    
                Spacer()
                
                Divider()
                
                // MARK: - 세미나 상세내용
                VStack {
                    VStack(alignment: .leading) {
                        Text("세미나 상세내용")
                        ZStack(alignment: .leading) {
                            TextEditor(text: $bodyText)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .frame(height: 300)
                            
                            if bodyText == "" {
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
                            TextEditor(text: $curriculumText)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .frame(height: 300)
                            
                            if curriculumText == "" {
                                Text("내용을 입력해주세요.")
                                    .opacity(0.5)
                                    .offset(x: 180, y: -160)
                            }
                        }
                    }
                    
                    // MARK: - 세미나 등록하기 버튼 추가 (데이터)
                    VStack(alignment: .center) {
                        Button {
                            // 등록하는 버튼 ~
                        } label: {
                            Text("세미나 등록하기")
                                .foregroundColor(.white)
                                .padding()
                            // 등록하기
                        }
                        .frame(width: 330, height: 40)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .background {
                            Color.mint
                        }
                        .cornerRadius(10)

                    }
                }
                .frame(width: 500, height: 900)
            }
        }
        
        .padding(.all, 200)
    }
    
}





struct SessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SessionDetailView()
    }
}


//                    TextField("날짜", text: $sessionSchedule)
//                    DatePicker("날짜", selection: $sessionSchedule,
//                               displayedComponents: .date)
//                    DatePicker("시간", selection: $sessionSchedule,
//                               displayedComponents: .hourAndMinute)
