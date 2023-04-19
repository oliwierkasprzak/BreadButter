//
//  DetailView.swift
//  Bread&Butter
//
//  Created by Oliwier Kasprzak on 27/02/2023.
//

import SwiftUI

struct DetailView: View {
    let user: User
    var body: some View {
        Text(user.name)
    }
}


