# WatchFolder-Notify

主要代码引用自 [WatchFolder](https://github.com/AHK-just-me/WatchFolder)

对多个文件夹的变动情况进行监控，通过Tray来提示。

#### 使用方法 ####
和`notify_conf.json`放到一个文件夹里就可以了。

配置说明：
只有两个项：`watch_dir`和`watch_file`
* `watch_dir` 是一个列表，代表要监控哪些文件夹，子文件夹也会被监控
* `watch_file` 也是一个列表，元素可以是字符串或者一个dict。只有符合要求的变化才会被提示。
  * 如果是字符串，它用于正则匹配文件完整路径
  * 如果是dict，它需要有`re`和`action`两个key。`re`用于正则匹配文件完整路径；`action`可以为`c,d,m,r`中的一个，分别对应增删改和重命名
