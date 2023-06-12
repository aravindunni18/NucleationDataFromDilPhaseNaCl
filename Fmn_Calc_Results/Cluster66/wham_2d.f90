program wham_2d
  implicit none
  integer, parameter :: pr=kind(1.D0)
  integer :: Mx,My   !** M : Number of bins
  integer :: S   !** S: Number of windows 
  character(len=20), dimension(:), allocatable :: filenames

  integer :: n
  integer, dimension(:,:,:), allocatable :: nijk
  integer, dimension(:,:), allocatable :: Njk
  integer, dimension(:), allocatable :: Ni

  real(PR) :: xlow,xhigh,xbin,x
  real(PR) :: ylow,yhigh,ybin,y
  real(pr) :: u
  real(pr), dimension(:,:,:), allocatable :: cijk
  real(pr), dimension(:,:), allocatable :: pjk,F_wham
  real(pr), dimension(:), allocatable :: fi,F_x,F_y

  real(pr) :: fi_old, fi_new
  real(pr) :: eps, den
  integer :: i,j,k, ierror

  real(pr), parameter :: tol=1.0e-6_pr   !** convergence criterion


  open(unit=10,file='wham_input',action='read')
  !** Number of bins
  read(10,*)xlow,xhigh,xbin
  Mx=nint((xhigh-xlow)/xbin)
  read(10,*)ylow,yhigh,ybin
  My=nint((yhigh-ylow)/ybin)
  !** Number of Windows
  read(10,*)S
  allocate(filenames(S))
  do i=1,S
    read(10,'(a)')filenames(i)
  end do
  close(unit=10)
  allocate(nijk(S,Mx,My),Ni(S),Njk(Mx,My),cijk(S,Mx,My),fi(S),pjk(Mx,My),F_wham(Mx,My),F_x(Mx),F_y(My))

  do i=1,S
    nijk(i,:,:)=0
    cijk(i,:,:)=0._pr
    open(unit=10,file=trim(filenames(i)),action='read')
    read(10,*)
    do
      read(unit=10,fmt=*,iostat=ierror)x,y,n,u
      if(ierror == -1)exit
      j=nint((x-xlow)/xbin)
      k=nint((y-ylow)/ybin)
      nijk(i,j,k)=n
      cijk(i,j,k)=exp(-u)
    end do
    close(unit=10)
  end do

  Ni=sum(sum(nijk,2),2)
  Njk=sum(nijk,1)
  fi=1._pr

  do
    do j=1,Mx
      do k=1,My
        den=0._pr
        do i=1,S
          den=den+real(Ni(i),pr)*cijk(i,j,k)/fi(i)
        end do
        if(Njk(j,k) == 0)then
          pjk(j,k)=1.0e-15_pr
        else
          pjk(j,k)=real(Njk(j,k),pr)/den
        end if
      end do
    end do
    
    eps=0._pr
    do i=1,S
      fi_old=fi(i)
      fi_new=0._pr
      do j=1,Mx
        do k=1,My
          fi_new=fi_new+cijk(i,j,k)*pjk(j,k)
        end do
      end do
      fi(i)=fi_new
      eps=eps + (1._pr-fi_new/fi_old)**2
    end do
    if(eps < tol)exit
  end do
  F_wham=-log(pjk)

  open(unit=10,file='free_energy.dat')
  do j=1,Mx
    do k=1,My
!!$      x=xlow+(real(j,pr)-0.5_pr)*xbin
!!$      y=ylow+(real(y,pr)-0.5_pr)*ybin
      if(Njk(j,k) /= 0)then
        write(unit=10,fmt='(f10.4)',advance='no')F_wham(j,k)
      else
        write(unit=10,fmt='(a10)',advance='no')'Inf'
      end if
    end do
    write(10,*)
  end do
  close(unit=10)

  F_x=-log(sum(exp(-F_wham),2,(Njk/=0)))
  F_y=-log(sum(exp(-F_wham),1,(Njk/=0)))

  open(unit=10,file='free_energy_x.dat')
  do j=1,Mx
      x=xlow+(real(j,pr)-0.5_pr)*xbin
      if(sum(Njk(j,:)) /= 0)write(unit=10,fmt='(i5,f10.4)')nint(x),F_x(j)
  end do
  close(unit=10)

end program wham_2d
