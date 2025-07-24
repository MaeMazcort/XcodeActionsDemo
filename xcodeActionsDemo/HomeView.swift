import SwiftUI


// MARK: - HomeView
struct HomeView: View {
    @State private var isShowingNotification = false
    @State private var searchText = ""
    @State private var selectedCategory = "All"
    @State private var isShowingSearchResults = false
    @State private var userName: String = "Hi"



    init() {
        // Empty initializer since we removed map-related properties
    }

    var body: some View {
        
        NavigationView {
            ScrollView {
                NavigationLink(destination: Text("Notification View"), isActive: $isShowingNotification) { EmptyView() }
                NavigationLink(
                    destination: Text("Search View"),
                    isActive: $isShowingSearchResults
                ) { EmptyView() }

                VStack(alignment: .leading, spacing: 10) {
                    TextField("Let's eat...", text: $searchText, onCommit: {
                        if !searchText.isEmpty {
                            isShowingSearchResults = true
                        }
                    })
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .overlay(
                            HStack {
                                Spacer()
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        )

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(["All", "Hamburguers", "Tacos", "Sushi", "Coffee"], id: \ .self) { category in
                                Button(action: {
                                    selectedCategory = category
                                }) {
                                    Text(category)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 8)
                                        .background(selectedCategory == category ? Color.primaryGreen : Color(.systemGray5))
                                        .foregroundColor(selectedCategory == category ? .white : .black)
                                        .cornerRadius(20)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 10)
                }
                .padding(.horizontal)
                .padding()

                WeeklyActivitySummaryView()
                PopularNearbyView()
                .navigationTitle("Home")
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(trailing: Button(action: {
                    isShowingNotification = true
                }) {
                    Image(systemName: "bell.badge.fill")
                })
            }
        }
        .navigationBarBackButtonHidden(true)
        .accentColor(Color.primaryGreen)
        .onAppear {
            fetchUserNameFromDatabase()
        }
    }

    private func fetchUserNameFromDatabase() {
        // Since Firebase is removed, we'll use a default name
        userName = "Nina"
    }
}



// MARK: - PopularNearbyView
struct PopularNearbyView: View {
    struct Restaurant: Identifiable {
        let id = UUID()
        let image: Image
        let name: String
        let distance: String
        let calories: String
    }

    let restaurants: [Restaurant] = [
        Restaurant(image: Image(systemName: "fork.knife.circle.fill"), name: "Santoua", distance: "12 min", calories: "450 kcal"),
        Restaurant(image: Image(systemName: "takeoutbag.and.cup.and.straw.fill"), name: "Cus Cus Cus", distance: "8 min", calories: "520 kcal"),
        Restaurant(image: Image(systemName: "leaf.circle.fill"), name: "Green Garden", distance: "18 min", calories: "370 kcal"),
        Restaurant(image: Image(systemName: "circle.hexagongrid.circle.fill"), name: "Pizza Urbana", distance: "21 mn", calories: "900 kcal"),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Popular Nearby")
                .font(.title3.bold())
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(restaurants) { restaurant in
                        VStack(alignment: .leading, spacing: 6) {
                            ZStack {
                                Rectangle()
                                    .fill(Color.primaryGreen.opacity(0.1))
                                    .frame(width: 180, height: 140)
                                    .cornerRadius(16)
                                
                                restaurant.image
                                    .font(.system(size: 40))
                                    .foregroundColor(.primaryGreen)
                            }

                            VStack(alignment: .leading, spacing: 2) {
                                Text(restaurant.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)

                                HStack(spacing: 15) {
                                    Label(restaurant.distance, systemImage: "clock.fill")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    Label(restaurant.calories, systemImage: "flame.fill")
                                        .font(.caption)
                                        .foregroundColor(.primaryGreen.opacity(0.6))
                                }
                            }
                            .padding(.horizontal, 4)
                        }
                        .frame(width: 180)
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical, 8)
        .navigationBarBackButtonHidden(true)
    }
}


// MARK: - WeeklyActivitySummaryView
struct WeeklyActivitySummaryView: View {
    @State private var navigateToDetail = false

    var body: some View {
        Button(action: {
            navigateToDetail = true
        }) {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.primaryGreen.opacity(0.8), Color.navyBlue.opacity(0.85)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .cornerRadius(20)

                HStack {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("This Week's Activity")
                            .font(.title3.bold())
                            .foregroundColor(.white)

                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                CircleIcon(symbol: "figure.walk", color: .white.opacity(0.2))
                                Text("8,420 steps")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                            }

                            HStack {
                                CircleIcon(symbol: "ruler", color: .white.opacity(0.2))
                                Text("5.7 km")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                            }

                            HStack {
                                CircleIcon(symbol: "flame.fill", color: .white.opacity(0.2))
                                Text("388 kcal")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                            }
                        }
                    }

                    Spacer()

                    ZStack {
                        Circle()
                            .stroke(lineWidth: 10)
                            .opacity(0.2)
                            .foregroundColor(.white)

                        Circle()
                            .trim(from: 0.0, to: 0.65)
                            .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                            .foregroundColor(.white)
                            .rotationEffect(.degrees(-90))
                            .animation(.easeOut(duration: 1.0), value: 0.65)

                        Text("65%")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .frame(width: 70, height: 70)
                }
                .padding(20)
            }
        }
        .frame(width: 351, height: 165)
        .background(
            NavigationLink(destination: WeeklyActivityDetailView(), isActive: $navigateToDetail) {
                EmptyView()
            }
        )
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
    }
}

// Reusable icon in circle
struct CircleIcon: View {
    let symbol: String
    let color: Color

    var body: some View {
        ZStack {
            Circle()
                .fill(color)
                .frame(width: 28, height: 28)

            Image(systemName: symbol)
                .font(.system(size: 14, weight: .semibold)) // Estilo consistente
                .foregroundColor(.white)
                .frame(width: 18, height: 18) // Forzar íconos del mismo tamaño
        }
    }
}



// MARK: - WeeklyActivityDetailView
struct WeeklyActivityDetailView: View {
    var body: some View {
        Text("Detalle de la actividad semanal")
            .font(.title)
            .padding()
    }
}


// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return HomeView()
            .navigationBarBackButtonHidden(true)
    }
}
