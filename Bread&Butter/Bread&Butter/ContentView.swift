//
//  ContentView.swift
//  Bread&Butter
//
//  Created by Oliwier Kasprzak on 26/02/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \UserCached.name, ascending: true)
    ]) var coreUsers: FetchedResults<UserCached>
   
    var body: some View {
        NavigationView {
            List(coreUsers) { user in
             
                NavigationLink {
                    DetailView(user: User(id: user.id!, isActive: user.isActive, name: user.name ?? "Unknown name", age: Int(user.age), company: user.company!, email: user.email!, address: user.address!, about: user.about!, registered: user.registered!, tags: [], friends: []))
                } label: {
                    Text(user.name ?? "Unknown name")
                }
            }
            .task {
                
                await loadData()
            
            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedData = try? JSONDecoder().decode([User].self, from: data) {
                for user in decodedData {
                    let newUser = UserCached(context: moc)
                    newUser.id = user.id
                    newUser.isActive = user.isActive
                    newUser.name = user.name
                    newUser.age = Int16(user.age)
                    newUser.email = user.email
                    newUser.company = user.company
                    newUser.address = user.address
                    newUser.registered = user.registered
                    newUser.about = user.about
                    
                    for friend in decodedData {
                        let newFriend = FriendCached(context: moc)
                        newFriend.id = friend.id
                        newFriend.name = friend.name
                        newUser.addToFriend(newFriend)
                    }
                }
                                
             }
            try? moc.save()

            } catch {
                
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
