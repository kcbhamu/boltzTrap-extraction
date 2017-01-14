program ST
implicit none
integer :: i,k,ok,mn
real :: t1,N1,y,s,st1
real :: TMAX,TGRID,T
DOUBLE PRECISION :: m,n,Nm,t2
character*10 :: form,casename

write(*,*)'|--------------------------------S-T-fixed doping-------------------------- |'
write(*,*)'Input file name format is casename.trace_fixdoping.'
write(*,*)'We have three kinds of calculation methods:'
write(*,*)'1:m + n ;m is Initial concentration,n is The concentration step.'
write(*,*)'2:m * n ;m is Initial concentration,n is The concentration step.'
write(*,*)'3:default(m * n);The first five concentration value is positive'
write(*,*)'                The next five concentration value is negative'
write(*,*)'        ;m is Initial concentration,n is The concentration step.'
write(*,*)'        ;t is the constant relaxation time.'
write(*,*)'History : 2014/9/18   ljw4010@sina.cn    3nd release                     '
write(*,*)'|-------------------------------------------------------------------------- |'
write(*,*)'Please enter the casename='
read(*,*)casename
open(11,file=trim(casename)//'.trace_fixdoping',iostat=ok)
    i = 1
    read(11,*,iostat=ok)

write(*,*)'|-------------------------------------INPUT-------------------------------- |'

write(*,*)'Please enter the 1,2or 3 to choose the Calculation Method :'
read(*,*) mn
write(*,*)'Please enter the m='
read(*,*) m
write(*,*)'Please enter the n='
read(*,*) n
write(*,*)'Please enter the max temperature ,T_MAX='
read(*,*) TMAX
write(*,*)'Please enter the temperature grid ,T_GRID='
read(*,*) TGRID
write(*,*)'Please enter the constant relaxation time ,t='
read(*,*) t2

write(*,*)'|-------------------------------------THE START----------------------------- |'
T = TMAX/TGRID
20  FORMAT('  T[K]','    N','            S(',ES8.1,')','      R(',ES8.1,')')
21  FORMAT(F6.1,F14.8,F13.5,ES18.5)
22  FORMAT(1X,'No. ',I2,' the ',ES8.1,' doping is OK !')
!23  FORMAT(1X,'No. ',I2,' the ',ES8.1,' doping is not OK !')
select case (mn)
case(1)
do while (ok == 0)
    write(form,'(ES8.1)')m
    open(12,file=trim(form)//'.txt')
    write(12,20) m,m
    write(*,22)i,m

    m  = m + n

    do k=1,T
        read(11,*,iostat=ok)t1,N1,y,s,st1
        write(12,21)t1,N1,s*1.0D+6,1/(st1*t2)
    enddo

    close(12)
    i = i + 1
    read(11,*,iostat=ok)
enddo

case(2)
do while (ok == 0)
    write(form,'(ES8.1)')m
    open(12,file=trim(form)//'.txt')
    write(12,20) m,m
    write(*,22)i,m

	m  = m * n

    do k=1,T
        read(11,*,iostat=ok)t1,N1,y,s,st1
        write(12,21)t1,N1,s*1.0D+6,1/(st1*t2)
    enddo

    close(12)
    i = i + 1
    read(11,*,iostat=ok)
enddo


case default 
   Nm=-m
do while (ok == 0)
    
      
    if(i==6) then 
       m = Nm
    end if
      
    write(form,'(ES8.1)')m
    open(12,file=trim(form)//'.txt')
    write(12,20) m,m
    write(*,22)i,m

    if(i<6) then
	m  = m * n
    end if

    if(i>=6) then
        m= m * n
       end if

    do k=1,T
        read(11,*,iostat=ok)t1,N1,y,s,st1
        write(12,21)t1,N1,s*1.0D+6,1/(st1*t2)
    enddo

    close(12)
    i = i + 1
    read(11,*,iostat=ok)
enddo
end select
write(*,*)'|--------------------------------------THE END------------------------------|'
end program ST
