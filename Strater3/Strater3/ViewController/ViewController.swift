//
//  ViewController.swift
//  Strater3
//
//  Created by kyaw htet aung on 2021/01/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableViewMovies: UITableView!
    @IBOutlet weak var viewForToolbar: UIView!
    @IBOutlet weak var ivMenu: UIImageView!
    @IBOutlet weak var ivSearch: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        tableViewMovies.dataSource = self
        tableViewMovies.register(UINib(nibName: String(describing: MovieSliderTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieSliderTableViewCell.self))
        tableViewMovies.register(UINib(nibName: String(describing: PopularFilmTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PopularFilmTableViewCell.self))
        tableViewMovies.register(UINib(nibName: String(describing: MovieShowTImeTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieShowTImeTableViewCell.self))
    }


}

extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieSliderTableViewCell.self)) as? MovieSliderTableViewCell else {
                return UITableViewCell()
            }
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PopularFilmTableViewCell.self)) as? PopularFilmTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieShowTImeTableViewCell.self)) as? MovieShowTImeTableViewCell else {
                return UITableViewCell()
            }
            return cell
        default:
            return UITableViewCell()
        }
        
        
    }
    
    
}
