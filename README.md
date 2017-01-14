# boltzTrap-extraction
Extracting Boltzrap data

S-Ef.f90：提取塞贝克随化学势变化数据

S-T-fixdoping.f90：提取塞贝克随固定载流子浓度的变化数据

本套码由Fortran语言编写，编译过程如下：

 打开终端切换到root用户输入：

[code]ifort -c S-Ef.f90[/code]

回车没报错，继续输入： 

[code]ifort -o S-Ef S-Ef.f90[/code]

回车即可

S-T-fixdoping.f90编译同上。
