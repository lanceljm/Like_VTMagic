//
//  ViewController.swift
//  联动
//
//  Created by ljm on 2017/6/9.
//  Copyright © 2017年 ljm. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

let sliderWidth = screenWidth / 4
let sliderHeight = screenHeight * 0.02




class ViewController: UIViewController,
                        UIScrollViewDelegate ,
                        UITableViewDelegate ,
                        UITableViewDataSource {
    
    static let shared = ViewController()
    
    
    /* 图片 */
    public var myImageView:UIImageView?
    
    /* 一个完整的scorllview */
    public var bigScrollView:UIScrollView?
    
    /* 小的选项框 */
    public var selectScrollView:UIScrollView?
    
    /* 详细内容 */
    public var detailScrollView:UIScrollView?
    
    /* label下相应的滑条 */
    public var sliderLab:UILabel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        setupBigScrollView()
        setupSelectScrollView()
        setupDetailScrollView()
        setupSliderLab()
    
    }
    
    
    //MARK: -  bigScrollView
    func setupBigScrollView() {
        bigScrollView = UIScrollView(frame: UIScreen.main.bounds) /* CGRect(x: 0,
                                                   y: (navigationController?.navigationBar.frame.height)! ,
                                                   width: screenWidth,
                                                   height: screenHeight - (navigationController?.navigationBar.frame.height)!)*/
    
        
        bigScrollView?.contentSize = CGSize(width: 0, height: screenHeight * 2)
        
        bigScrollView?.delegate = self
        bigScrollView?.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        
        /*
         *
         *  设置图片
         *
         */
        myImageView = UIImageView(frame: CGRect(x: 0,
                                                y: 0,
                                                width: screenWidth,
                                                height: screenHeight / 4)
        )
        myImageView?.image = UIImage(named: "bg")
        

        bigScrollView?.addSubview(myImageView!)
    }
    
    //MARK: -  selectScrollView
    func setupSelectScrollView() {
        
        selectScrollView = UIScrollView(frame: CGRect(x: 0,
                                                      y: (myImageView?.frame.maxY)!,
                                                      width: screenWidth,
                                                      height: screenHeight * 0.1)
        )
        
        selectScrollView?.contentSize = CGSize(width: screenWidth * 2, height: screenHeight * 0.1)
        selectScrollView?.delegate = self
        selectScrollView?.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        
        for index in 0...8 {
            let myLab = UILabel(frame: CGRect(x: 0 + screenWidth / 4 * CGFloat(Float(index)),
                                              y: 0,
                                              width: view.frame.width / 4,
                                              height: view.frame.height * 0.1)
            )
            myLab.backgroundColor = UIColor (
                                            colorLiteralRed:Float(Double(arc4random()%256)/255.0),
                                            green: Float(arc4random()%256)/255.0,
                                            blue: Float(arc4random()%256)/255.0,
                                            alpha: 1)
            
            myLab.text = String(format: "第%d张", index + 1) as String
            myLab.textAlignment = .center
            /* 添加手势 */
            let tapgestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(handTapAction(sender:)))
            myLab.addGestureRecognizer(tapgestureRecognizer)
            myLab.isUserInteractionEnabled = true
            selectScrollView?.addSubview(myLab)
            
        }
        
        bigScrollView?.addSubview(selectScrollView!)
        
    }
    
    //MARK: -  选择label
    func setupSliderLab() {
        sliderLab = UILabel(frame: CGRect(x: 0,
                                          y: screenHeight * 0.08,
                                          width: sliderWidth,
                                          height: sliderHeight)
        )
        
        sliderLab?.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        selectScrollView?.addSubview(sliderLab!)
    }
    
    //MARK: -  detailScrollView
    func setupDetailScrollView() {
        detailScrollView = UIScrollView(frame: CGRect(x: 0,
                                                      y: (selectScrollView?.frame.maxY)!,
                                                      width: screenWidth,
                                                      height: screenHeight * 2)
        )
        detailScrollView?.delegate = self
        detailScrollView?.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        detailScrollView?.contentSize = CGSize(width: screenWidth * 9, height: 0)
        detailScrollView?.isPagingEnabled = true
        
        for index in 0 ... 8 {
            let myLab = UILabel(frame: CGRect(x: 0 + screenWidth * CGFloat(Float(index)),
                                              y: 0,
                                              width: screenWidth,
                                              height: screenHeight * 0.5)
            )
            
            myLab.text = NSString(format: "第%d张", index + 1) as String
            myLab.textAlignment = .center
            myLab.isUserInteractionEnabled = true
        
            let mytableview = UITableView(frame: CGRect(x:5,
                                                        y:10,
                                                        width:screenWidth - 10,
                                                        height:screenHeight * 2 - 20),
                                          style: .plain)
            mytableview.delegate = self
            mytableview.dataSource = self
            myLab.addSubview(mytableview)
            detailScrollView?.addSubview(myLab)
            
        }
        bigScrollView?.addSubview(detailScrollView!)
        
        view.addSubview(bigScrollView!)
        
    }
    
    
    //MARK: -   tableviewdelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if (cell == nil)  {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier)
        }
        cell?.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        return cell!
    }
    
    
    //MARK: -   scrollview的滑动处理
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == bigScrollView {
            
            /* 实现滑动停留 */
            if scrollView.contentOffset.y > screenWidth * 0.5 {
                selectScrollView?.frame = CGRect(x: 0,
                                                 y: (myImageView?.frame.maxY)! + scrollView.contentOffset.y - screenWidth * 0.5,
                                                 width: screenWidth,
                                                 height: screenHeight * 0.1)
                
                detailScrollView?.frame = CGRect(x: 0,
                                                 y: (selectScrollView?.frame.maxY)! + scrollView.contentOffset.y - screenWidth * 0.5 ,
                                                 width: screenWidth,
                                                 height: screenHeight * 2)
                
            }else
            {
                selectScrollView?.frame = CGRect(x: 0,
                                                 y: (myImageView?.frame.maxY)!,
                                                 width: screenWidth,
                                                 height: screenHeight * 0.1)
                
                detailScrollView?.frame = CGRect(x: 0,
                                                 y: (selectScrollView?.frame.maxY)!,
                                                 width: screenWidth,
                                                 height: screenHeight * 2)
            }
            
            /* 隐藏滑条 */
            if scrollView.contentOffset.y > -64 {
                navigationController?.navigationBar.alpha = scrollView.contentOffset.y / 64
            }
            
        }else if scrollView == detailScrollView
        {
            
            /* 实现红条移动 */
            sliderLab?.frame = CGRect(x: (detailScrollView?.contentOffset.x)! / screenWidth * (screenWidth / 4),
                                      y: (selectScrollView?.frame.height)! * 0.8,
                                      width: sliderWidth,
                                      height: sliderHeight)
            
            /*
             *
             *  实现上下联动
             *
             */
            if (detailScrollView?.contentOffset.x)! > screenWidth * 3 {
                selectScrollView?.contentOffset = CGPoint(x:(scrollView.contentOffset.x - 3 * screenWidth) / screenWidth * (screenWidth / 4),
                                                          y: 0)
            }

        }
        
        /*
         *
         *  实现图片的拉伸效果
         *
         */
        if scrollView == bigScrollView {
            if scrollView.contentOffset.y < 0 {
                myImageView?.frame = CGRect(x: 0,
                                            y: scrollView.contentOffset.y,
                                            width: screenWidth,
                                            height: screenHeight / 4 - scrollView.contentOffset.y)
            }
        }

    }
    
    
    //MARK: -   手势的action 实现相应label的滑动效果
    func handTapAction(sender:UITapGestureRecognizer)  {
        sliderLab?.frame = CGRect(x: (sender.view?.frame.origin.x)!,
                                  y: (selectScrollView?.frame.height)! * 0.8,
                                  width: sliderWidth,
                                  height: sliderHeight)
        
        detailScrollView?.setContentOffset(CGPoint(x:(sender.view?.frame.origin.x)! / (screenWidth / 4) * screenWidth,
                                                   y:0),
                                           animated: true)
        
    }
}

