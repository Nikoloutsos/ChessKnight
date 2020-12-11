//
//  ViewController.swift
//  chessKnight
//
//  Created by Konstantinos Nikoloutsos on 9/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var chessSizeSlider: UISlider!
    @IBOutlet weak var chessSizeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var chessBoardUIView: ChessBoardUIView!
    lazy var presenter = ViewControllerPresenter(with: self)
    override func viewDidLoad() {
        super.viewDidLoad()
        chessBoardUIView.delegate = presenter
        
        let config = Configuration(sizeOfChessBoard: 8)
        chessBoardUIView.applyConfiguration(conf: config)
        presenter.initGame(conf: config)
        chessSizeSlider.value = 8
    }
    
    
    @IBAction func onStartButtonPressed(_ sender: UIButton) {
        presenter.onStartButtonPressed()
    }
    
    
    @IBAction func onClearButtonPressed(_ sender: Any) {
        let config = Configuration(sizeOfChessBoard: 8)
        chessBoardUIView.applyConfiguration(conf: config)
        presenter.changeChessBoardConfiguration(conf: config)
        chessSizeSlider.value = 8
        onChessSizeSliderValueChanged(chessSizeSlider)
        
    }
    
    @IBAction func onReconfigureButtonPressed(_ sender: Any) {
        
        let config = Configuration(sizeOfChessBoard: Int(chessSizeSlider.value))
        chessBoardUIView.applyConfiguration(conf: config)
        presenter.changeChessBoardConfiguration(conf: config)
    }
    
    
    
    @IBAction func onChessSizeSliderValueChanged(_ sender: UISlider) {
        
        let value = Int(sender.value)
        chessSizeLabel.text = "N = \(value)"
    }
    
    
    
    
    
    
}

extension ViewController : ViewControllerPresenterView{
    func showPathFound(pathList: [Path]) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pathDisplayVC = storyboard.instantiateViewController(withIdentifier: "pathDisplayVC") as!PathsDisplayViewController
        pathDisplayVC.pathsToBeShown = pathList
       
        navigationController?.pushViewController(pathDisplayVC, animated: true)
    }
    
    func showNoPathFound() {
        let alert = UIAlertController(title: "Oups no paths found", message: "Tip: try again by dragging the pieces into other squares", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func reRenderChessBoard() {
        chessBoardUIView.setNeedsDisplay()
    }
}
   











