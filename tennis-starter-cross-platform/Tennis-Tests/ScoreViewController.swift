import UIKit

class ScoreViewController : UIViewController
{
    
    @IBOutlet weak var p1NameLabel: UILabel!
    @IBOutlet weak var p2NameLabel: UILabel!
    
    @IBOutlet weak var p1PointsLabel: UILabel!
    @IBOutlet weak var p2PointsLabel: UILabel!
    
    @IBOutlet weak var p1GamesLabel: UILabel!
    @IBOutlet weak var p2GamesLabel: UILabel!
    
    @IBOutlet weak var p1SetsLabel: UILabel!
    @IBOutlet weak var p2SetsLabel: UILabel!
    
    @IBOutlet weak var p1PreviousSetsLabel: UILabel!
    @IBOutlet weak var p2PreviousSetsLabel: UILabel!
    
    @IBOutlet weak var player1Button: UIButton!
    @IBOutlet weak var player2Button: UIButton!
    
    @IBAction func p1AddPoint(_ sender: UIButton) {
  
    }

    @IBAction func p2AddPoint(_ sender: UIButton) {
        
    }
    
    /**
     This function should allow the user to start scoring a new Tennis Match
     */
    @IBAction func restart(_ sender: Any) {
        
    }
    
    
}
