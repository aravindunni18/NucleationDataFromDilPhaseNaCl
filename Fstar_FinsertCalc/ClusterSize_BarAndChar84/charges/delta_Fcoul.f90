program delta_Fcoul
  implicit none
  integer, parameter :: pr=kind(1.D0)
  integer :: i,j
  real(pr) :: de1,de1_v,e1(55),ee1(5,11),ee1_m(11),ee1_v(11),l
  real(pr) :: de2,de2_v,e2(55),ee2(5,11),ee2_m(11),ee2_v(11)
  real(pr) :: beta,T

  T=298._pr
  beta=4184._pr/8.314_pr/T
  open(unit=10,file='coul.dat',action='read')
  read(10,'(/)')
  do i=1,55
    read(10,*)j,e1(i),e2(i)
  end do 
  close(unit=10)

  ee1=reshape(e1,(/5,11/))
  ee2=reshape(e2,(/5,11/))

  !** Mean
  ee1_m=sum(ee1(2:5,:),1)/4._pr
  ee2_m=sum(ee2(2:5,:),1)/4._pr
  !** Variance
  ee1_v=(sum(ee1(2:5,:)**2,1)/4._pr-ee1_m**2)/3._pr
  ee2_v=(sum(ee2(2:5,:)**2,1)/4._pr-ee2_m**2)/3._pr

  de1=0._pr
  de2=0._pr
  de1_v=0._pr
  de2_v=0._pr
  do i=1,11
    l=2._pr*real(i-1,pr)/10._pr
    if(i==1 .or. i==11)then
      de1=de1+ee1_m(i)
      de2=de2+l*ee2_m(i)
      de1_v=de1_v+ee1_v(i)
      de2_v=de2_v+(l**2)*ee2_v(i)
    elseif(mod(i-1,2) == 1)then
      de1=de1+4._pr*ee1_m(i)
      de2=de2+4._pr*l*ee2_m(i)
      de1_v=de1_v+16._pr*ee1_v(i)
      de2_v=de2_v+16._pr*(l**2)*ee2_v(i)
    else
      de1=de1+2._pr*ee1_m(i)
      de2=de2+2._pr*l*ee2_m(i)
      de1_v=de1_v+4._pr*ee1_v(i)
      de2_v=de2_v+4._pr*(l**2)*ee2_v(i)
    end if
  end do
  de1=de1*0.1_pr/3._pr
  de2=de2*0.1_pr/3._pr
  de1_v=de1_v*(0.1_pr/3._pr)**2
  de2_v=de2_v*(0.1_pr/3._pr)**2
  write(6,*)beta*de1,beta*de2
  write(6,*)beta*sqrt(de1_v)*2.3534_pr,beta*sqrt(de2_v)*2.3534_pr


end program delta_Fcoul
