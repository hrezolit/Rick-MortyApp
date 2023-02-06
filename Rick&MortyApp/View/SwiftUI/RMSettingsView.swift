//
//  RMSettingsView.swift
//  Rick&MortyApp
//
//  Created by Nikita on 5/2/23.
//

import SwiftUI

struct RMSettingsView: View {
    
    let viewModel: RMSettingsViewViewModel
    
    init(viewModel: RMSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cellViewModels) { viewModel in
            HStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .padding(15)
                        .background(Color(viewModel.iconContainerColor))
                        .cornerRadius(7)
                }
                Text(viewModel.title)
                    .padding(.leading, 25)
            }
            .padding(.bottom, 3)
        }
    }
}

struct RMSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RMSettingsView(
            viewModel: .init(
                cellViewModels: RMSettingsOption.allCases.compactMap({
                    RMSettingsCellViewModel(type: $0)
                })))
    }
}
