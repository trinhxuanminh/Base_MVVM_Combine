//
//  MovieCVC.swift
//  Base_MVVM_Combine
//
//  Created by Trịnh Xuân Minh on 06/02/2024.
//

import UIKit

class MovieCVC: BaseCollectionViewCell {
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var genresLabel: UILabel!
  @IBOutlet weak var voteLabel: UILabel!
  
  private var viewModel: MovieViewModel! {
    didSet {
      binding()
    }
  }
  
  override func prepareForReuse() {
    removeSubs()
    super.prepareForReuse()
  }
  
  override func binding() {
    viewModel.poster
      .assign(to: \.image, on: posterImageView)
      .store(in: &subscriptions)
    
    viewModel.title
      .assign(to: \.text, on: nameLabel)
      .store(in: &subscriptions)
    
    viewModel.genres
      .assign(to: \.text, on: genresLabel)
      .store(in: &subscriptions)
    
    viewModel.vote
      .assign(to: \.text, on: voteLabel)
      .store(in: &subscriptions)
  }
}

extension MovieCVC {
  func setViewModel(_ viewModel: MovieViewModel) {
    self.viewModel = viewModel
  }
}
