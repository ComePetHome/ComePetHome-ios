//
//  AnimalDetailView.swift
//  ComePetHome
//
//  Created by 주진형 on 1/3/24.
//

import SwiftUI

struct AnimalDetailView: View {
    @State var isMapOpen: Bool = false
    var animalName: String
    var animalBreeds: String
    var animalAge: String
    var isLike: Bool
    var body: some View {
        ScrollView {
            Image("Dog")
                .resizable()
                .frame(width: .screenWidth * 0.9, height: .screenWidth * 0.9)
                .clipShape(RoundedRectangle(cornerRadius: 26))
            
            HStack {
                Text("개")
                    .frame(width: .screenWidth * 0.2, height: .screenWidth * 0.08)
                    .background(Color("MainColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Text("\(animalBreeds)")
                    .frame(width: .screenWidth * 0.2, height: .screenWidth * 0.08)
                    .background(Color("MainColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Text("\(animalAge.replacingOccurrences(of: "[()]", with: "", options: .regularExpression))")
                    .frame(width: .screenWidth * 0.2, height: .screenWidth * 0.08)
                    .background(Color("MainColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Text("5Kg")
                    .frame(width: .screenWidth * 0.2, height: .screenWidth * 0.08)
                    .background(Color("MainColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Spacer()
            }
            .padding(.leading, .screenWidth * 0.05)
            HStack {
                Text("입양대기")
                    .frame(width: .screenWidth * 0.2, height: .screenWidth * 0.08)
                    .background(Color("MainColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Spacer()
            }
            .padding(.leading, .screenWidth * 0.05)
            
            VStack {
                HStack {
                    Text("입소날짜")
                    Rectangle()
                        .frame(width: .screenWidth * 0.001, height: .screenWidth * 0.05)
                    Text("2023-11-27")
                    Spacer()
                }
                .padding([.leading, .trailing], .screenWidth * 0.05)
                .padding(.top, .screenWidth * 0.02)
                HStack {
                    Text("보호센터")
                    Rectangle()
                        .frame(width: .screenWidth * 0.001, height: .screenWidth * 0.05)
                    Text("노원 댕댕 하우스")
                    Spacer()
                    Button {
                        isMapOpen.toggle()
                    } label: {
                        if isMapOpen {
                            Text("지도접기")
                                .foregroundStyle(.black)
                                .opacity(0.5)
                                .font(Font.system(size: 12))
                            Image(systemName: "chevron.up")
                                .foregroundStyle(.black)
                                .opacity(0.5)
                                .font(Font.system(size: 12))
                        } else {
                            Text("지도보기")
                                .foregroundStyle(.black)
                                .opacity(0.5)
                                .font(Font.system(size: 12))
                            Image(systemName: "chevron.down")
                                .foregroundStyle(.black)
                                .opacity(0.5)
                                .font(Font.system(size: 12))
                        }
                    }
                    
                }
                .padding([.leading, .trailing], .screenWidth * 0.05)
                .padding(.top, .screenWidth * 0.01)
            }
            if isMapOpen {
                ZStack {
                    Rectangle()
                        .fill(Color("MainColor"))
                        .frame(width: .screenWidth * 0.95, height: .screenHeight * 0.48, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    VStack {
                        ShelterMapView()
                            .frame(width: .screenWidth * 0.95, height: .screenHeight * 0.4, alignment: .center)
                        Spacer()
                        HStack {
                            Text("상세주소")
                                .foregroundStyle(Color.black)
                            
                            Rectangle()
                                .frame(width: .screenWidth * 0.001, height: .screenWidth * 0.05)
                            Text("서울 노원구 수락산로 258")
                            Spacer()
                        }
                        .padding([.leading, .trailing], .screenWidth * 0.05)
                        Spacer()
                    }
                }
                .padding([.bottom], 10)
            }
            VStack {
                HStack {
                    Text("동물소개")
                        .font(Font.system(size: 18))
                    Spacer()
                }
                .padding([.leading], -5)
                .padding([.bottom], 5)
                Text("""
                    둥글둥글하고 부드러운 어감이 들어서 붙여준 이름 ‘보리’. 보리는 사람을 정말 좋아하고, 특히
                    쓰다듬어 주는 것을 좋아해요.
                    사람이랑 같이 있으면 다리 사이로 들어가서 얼굴도 비비고 애교가 정말 많은 보리! 동시에 보리는 겁이 정말 많은 아이에요.
                    좋아하는 사람이 곁에 있어도 아직 바깥을 무서워하는 모습을 보입니다. 아직 사회성이 조금 부족해서 다른 동물 친구들을 만나면 피하거나, 밖에 나가면 걷지 않으려고 하며 구석으로 들어가려고 해요. 그래서 현재 보리는 센터에서 산책훈련이나
                    다른 강아지들과의 교감 등 다양한 교육을 통해, 조금씩 사회성을 키우면서 점점 씩씩하게 발전하고 있답니다.
                    보리는 사람한테 낯가림 없이 금방 친해지는 순딩이에요. 사람의 애정을 많이 필요로 하는 아이에요
                    """)
                .padding([.leading,.trailing], -5)
            }
            .padding()
            .frame(width: .screenWidth * 0.95, alignment: .center)
            .background(Color("MainColor"))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            NavigationLink {
                AnimalYoutubeWebView(urlString: "https://www.youtube.com/watch?v=MDvcp-gOwYQ&t=36s")
            } label: {
                Text("동물 영상 보기")
                    .foregroundStyle(Color.white)
                    .font(Font.system(size: 20))
                    .frame(width: .screenWidth * 0.95, height: .screenWidth * 0.18)
            }
            .frame(width: .screenWidth * 0.95, height: .screenWidth * 0.18)
            .background(Color("AccentColor"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding([.top], 12)
        }
        .navigationTitle("\(animalName)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                    
                } label: {
                    Image(systemName: isLike ? "heart.fill" : "heart")
                        .foregroundStyle(Color("ExtraColor"))
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AnimalDetailView(animalName: "컬리", animalBreeds: "믹스", animalAge: "2(세)1(개월)", isLike: true)
    }
}
