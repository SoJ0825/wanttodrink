import UIKit

class OrderHeaderView: UIView {

    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var customerCost: UILabel!
    
    func updateCustomerData(name: String, cost: String) {
        customerName.text = name
        customerCost.text = "小計：" + cost
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    var contentView:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = loadViewFromNib(frame: frame)
        addSubview(contentView)
        
//        contentView.frame = frame // 加上這段才可以在初始化的時候，變更 frame 大小，否則會改讀 xib 的設定
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        contentView = loadViewFromNib()
//        addSubview(contentView)
    }

    func loadViewFromNib(frame: CGRect) -> UIView {
        let className = type(of: self)
        let bundle = Bundle(for: className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        let nib = UINib(nibName: name!, bundle: bundle)
        
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = frame
        return view
    }

}
