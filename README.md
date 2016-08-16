# LLAlertView
自定义AlertView

## <a id="Demo"></a>Demo
![(可视化重新加载按钮)](https://github.com/LvJianfeng/LLAlertView/blob/master/screen.gif)

## <a id="点击回调"></a>点击回调
* 支持Block
* 支持Delegate

## <a id="如何使用LLNoDataView"></a>使用LLAlertView
<!--* cocoapods导入：`pod 'LLAlertView'`-->
* 手动导入：
      * 将`LLAlertView.h` , `LLAlertView.m`两个文件拽入项目中
    * 导入主头文件：`#import "LLAlertView.h"`

## <a id="点击回调"></a>Delegate
```objc
//请下载工程查看Demo使用
alertView.delegate = self;
```

## <a id="点击回调"></a>Block
```objc
//请下载工程查看Demo使用
alertView.clickActionBlock = ^{
  NSLog(@"去更新");
};
```


