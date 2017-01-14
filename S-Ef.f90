program EfS
implicit none
integer :: ok,chT,TEM
character*30 :: mz,casename
real :: t1,x,y,s,m,Fermi
write(*,*)'|--------------------------------S-Ef-------------------------------------- |'
write(*,*)'This program can extract the S_m data corresponding to Temp in casename.trace at 100K,300K,600K.others chars quit program!.'
write(*,*)'Input file name format is casename.trace.'
write(*,*)'History : 2014/9/4   ljw4010@sina.cn    2nd release                     '
write(*,*)'|-------------------------------------------------------------------------- |'
write(*,*)'Please enter the casename='
read(*,*)casename


write(*,*)'Please enter the output file name='
read(*,*)mz
write(*,*)'Please enter Fermi='
read(*,*)Fermi
 
20  FORMAT('  m(eV)','      S(mV/K)')
21  FORMAT(F10.5,' ',F10.5)

do while(1)
write(*,*)'Please enter the 100,300, 600(0 quit!)to choose the Calculation Method :'  
read(*,*)chT 
ok=0
open(11,file=trim(casename)//'.trace',iostat=ok,POSITION='REWIND')
    read(11,*,iostat=ok)

select case(chT)

case(100)
open(12,file=trim(mz)//'-100K.txt')
write(12,20)
        
do while(ok==0)
read(11,*,iostat=ok)x,t1,y,m,s
      if(t1==100.0) then
        write(12,21) (x-Fermi)*13.6,s*1.0D+6
      end if
enddo
 12 close(12)
  close(11)
write(*,*)chT,'K has calculated!' 

case(600)
open(13,file=trim(mz)//'-600K.txt')
write(13,20)
        
do while(ok==0)
read(11,*,iostat=ok)x,t1,y,m,s
      if(t1==600.0) then
        write(13,21) (x-Fermi)*13.6,s*1.0D+6
      end if
enddo
 13 close(13)
 close(11)
write(*,*)chT,'K has calculated!' 

case(300)
open(14,file=trim(mz)//'-300K.txt')
write(14,20)
        
do while(ok==0)
read(11,*,iostat=ok)x,t1,y,m,s
      if(t1==300.0) then
        write(14,21) (x-Fermi)*13.6,s*1.0D+6
      end if
enddo
 close(14)
  close(11)
write(*,*)chT,'K has calculated!' 

case default
write(*,*)'quiting the program!' 
exit

end select
end do
write(*,*)'|--------------------------------------THE END------------------------------ |'
end program EfS
