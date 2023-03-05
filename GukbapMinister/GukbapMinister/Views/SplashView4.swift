//
//  SplashView4.swift
//  GukbapMinister
//
//  Created by 이원형 on 2023/03/05.
//

import SwiftUI

struct SplashView4: View {
    @State private var isActive = false
    
    let randomGukbaps = Gukbaps.allCases.shuffled()
    
    var body: some View {
        HStack{
            if isActive{
                MainTabView()
            }else{
                ZStack{
                    Color("AccentColor")
                        .ignoresSafeArea(.all)

                    VStack{
                        Spacer()
                        VStack{
                            HStack{
                                Text("내 주변")
                                Spacer()
                            }
                            .font(.system(size: UIScreen.main.bounds.maxY * 0.045))
                            
                            HStack{
                                Text("국밥 찾을땐?")
                                Spacer()
                            }
                            .font(.system(size: UIScreen.main.bounds.maxY * 0.045))

                            HStack{
                                Text("국밥부장관")
                                Spacer()
                            }
                            .font(.system(size: UIScreen.main.bounds.maxY * 0.045))
                            .fontWeight(.medium)

                          

                        }.foregroundColor(.white)
                            .padding(.leading,30)
                        Image(randomGukbaps[0].imageName)
                            .resizable()
                            .frame(width:UIScreen.main.bounds.width * 0.8 ,height:UIScreen.main.bounds.height * 0.4)
                            .rotationEffect(Angle(degrees: -0))
                         //   .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                            .offset(x:0, y: 0)
                           
                            Spacer()
             
                                VStack{
                                    Text("국밥부장관")
                                    Text("Goodvibe")
                                }
                                .font(.title3)
                                .foregroundColor(.white)
                            .opacity(0.5)
                            
                        }
                    }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        self.isActive = true
                    }
                }
            }
        }
      
    }
}

struct SplashView4_Previews: PreviewProvider {
    static var previews: some View {
        SplashView4()
    }
}
