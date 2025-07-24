import SwiftUI

struct NavigationBar: View {
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            SocialGeneralView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Social")
                }
                .tag(0)
            
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(1)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile test")
                }
                .tag(2)
            
        }
        .navigationBarBackButtonHidden(true)
        .accentColor(Color.primaryGreen)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
            .navigationBarBackButtonHidden(true)
    }
}



