# JJSlider
swift版本的侧滑框架

## 示例
![](https://github.com/JJCrystalForest/JJSlider/blob/master/example.gif)

##使用方法
使其成为根控制器
```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initWindow()
        return true
    }

    func initWindow() {
        window?.backgroundColor = UIColor.white
        let nvc = BaseNaviCtrl.init(rootViewController: ViewController())
        let sliderVC = SliderViewCtrl.init(SideMenuViewCtrl(), nvc)
        window?.rootViewController = sliderVC
        window?.makeKeyAndVisible()
    }
```
