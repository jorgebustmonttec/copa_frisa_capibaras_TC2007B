import SwiftUI

struct AplicacionView: View {
    @State private var selectedTab = 2 // Set HomePageView as the default view
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                NotificacionView() // Enlaza a NotificacionView aquí
                    .tabItem {
                        Image(systemName: "bell.fill")
                        Text("Notificaciones")
                    }
                    .tag(0)
                
                BusquedaView() // Enlaza a BusquedaView aquí
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Búsqueda")
                    }
                    .tag(1)
                
                MatchTest() // Enlaza a HomePageView aquí
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Inicio")
                    }
                    .tag(2)
                
                PerfilView() // Enlaza a PerfilView aquí
                    .tabItem {
                        Image(systemName: "person")
                        Text("Perfil")
                    }
                    .tag(3)
                
                LeaderboardView() // Enlaza a LeaderboardView aquí
                    .tabItem {
                        Image(systemName: "trophy.fill")
                        Text("Clasificacion")
                    }
                    .tag(4)
            }
            //.navigationBarTitle("Detalle del Jugador")
            .navigationBarItems(trailing: NavigationLink(destination: UserOptionsView()) {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .padding()
            })
        }
    }
}

struct AplicacionView_Previews: PreviewProvider {
    static var previews: some View {
        AplicacionView()
            .environmentObject(UserViewModel())
    }
}
