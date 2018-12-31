# linux-tools
linux上的小工具集锦

 两个swap脚本工具，可以监测进程对swap的使用情况。

1.seePidSwap.sh: 该工具监测指定进程的swap的使用情况，参数有-p，-i， -n

-p 指定进程pid
-i 刷新间隔
-n 监测时长，多少个时间间隔

例： seePidSwap.sh -p 1234 -i 3 -n 60

监测pid为1234的进程的swap使用情况，3秒钟刷新一次，持续60个间隔

2 seeAllSwap.sh： 打印所有进程swap的占用情况

