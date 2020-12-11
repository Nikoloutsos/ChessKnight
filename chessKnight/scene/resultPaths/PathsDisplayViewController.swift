//
//  PathsDisplayViewController.swift
//  chessKnight
//
//  Created by Konstantinos Nikoloutsos on 10/12/20.
//

import UIKit

class PathsDisplayViewController: UIViewController {
    var pathsToBeShown : [Path]?

    @IBOutlet weak var pathsUITableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PathTableViewCell", bundle: bundle)
        pathsUITableView.register(nib, forCellReuseIdentifier: "pathCell")
        
        pathsUITableView.delegate = self
        pathsUITableView.dataSource = self
    }
}



extension PathsDisplayViewController : UITableViewDataSource{
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pathsToBeShown?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "pathCell", for: indexPath) as? PathTableViewCell{
            
            cell.pathLabel.text = pathsToBeShown![indexPath.row].algebraicNotation
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}


extension PathsDisplayViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showToast(message: "Path copied to clipboard", font: .systemFont(ofSize: 12.0))
        UIPasteboard.general.string = pathsToBeShown![indexPath.row].algebraicNotation
    }
}

