
//http://qiita.com/Takeshi_Akutsu/items/dbf54df8e8a50e8ed5be
//上記ページを参考に作成
import UIKit

class rulePageViewController: UIPageViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
        self.dataSource = self //追加
    }
    
    func getFirst() -> rule0ViewController {
        return storyboard!.instantiateViewController(withIdentifier: "rule0ViewController") as! rule0ViewController   }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func getSecond() -> rule1ViewController {
        return storyboard!.instantiateViewController(withIdentifier: "rule1ViewController")as! rule1ViewController
    }
    
    func getThird() -> rule2ViewController {
        return storyboard!.instantiateViewController(withIdentifier: "rule2ViewController")as! rule2ViewController
    }
    
    func getFourth() -> rule3ViewController {
        return storyboard!.instantiateViewController(withIdentifier: "rule3ViewController")as! rule3ViewController
    }
    
    func getFifth() -> rule4ViewController {
        return storyboard!.instantiateViewController(withIdentifier: "rule4ViewController")as! rule4ViewController
    }
    
    func getSixth() -> rule5ViewController {
        return storyboard!.instantiateViewController(withIdentifier: "rule5ViewController")as! rule5ViewController
    }
}

extension rulePageViewController : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: rule1ViewController.self) {
            return getFirst()
        } else if viewController.isKind(of: rule2ViewController.self){
            return getSecond()
        } else if viewController.isKind(of: rule3ViewController.self){
            return getThird()
        } else if viewController.isKind(of: rule4ViewController.self){
            return getFourth()
        } else if viewController.isKind(of: rule5ViewController.self){
            return getFifth()
        }
            return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: rule0ViewController.self) {
            return getSecond()
        } else if viewController.isKind(of: rule1ViewController.self){
            return getThird()
        } else if viewController.isKind(of: rule2ViewController.self){
            return getFourth()
        } else if viewController.isKind(of: rule3ViewController.self){
            return getFifth()
        } else if viewController.isKind(of: rule4ViewController.self){
            return getSixth()
        }
        return nil
    }
}
