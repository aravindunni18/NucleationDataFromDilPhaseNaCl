!** Compute free energy difference using BAR
program bar
  implicit none
  integer, parameter :: pr=kind(1.D0)
  real(pr), dimension(390000) :: x,y,z,w
  real(pr), dimension(30000,13) :: xx,yy,zz,ww
  real(pr), dimension(13) :: df1, df2
  real(pr), dimension(4) :: delta_F
  real(pr) :: beta, T
  integer :: i,j, is,ie
  real(pr) :: delta_F_avg,delta_Fsq_avg,delta_F_error

  open(unit=10,file='delta_fe.dat',action='read')
  read(10,'(2/)')
  do i=1,390000
    read(10,*)j,x(i),y(i),z(i),w(i)
  end do
  close(unit=10)

  T=298._pr
  beta=4184._pr/8.314_pr/T

  xx=reshape(x,(/30000,13/))
  yy=reshape(y,(/30000,13/))
  zz=reshape(z,(/30000,13/))
  ww=reshape(w,(/30000,13/))

  df1=-log(sum(yy,1)/30000._pr)
  df2=log(sum(ww,1)/30000._pr)
  write(6,*)sum(df1(1:12)),sum(df2(2:13))

  do i=1,4
    is=6000*i+1
    ie=is+6000-1
    call compute_deltaF_bar(xx(is:ie,:),zz(is:ie,:),df1,beta,delta_F(i))
  end do
  delta_F_avg=sum(delta_F)/4._pr
  delta_Fsq_avg=sum(delta_F*delta_F)/4._pr
  delta_F_error=sqrt((delta_Fsq_avg-delta_F_avg**2)/3._pr)*2.3534_pr
  write(6,'(4f10.4)')delta_F_avg,delta_F_error

contains
  subroutine compute_deltaF_bar(xx,zz,df1,beta,delta_F)
    real(pr), dimension(:,:), intent(in) :: xx,zz
    real(pr), dimension(:), intent(in) :: df1
    real(pr), intent(in) :: beta
    real(pr), intent(out) ::  delta_F

    integer :: N,M
    integer :: i
    real(pr) ::  df,dfh,dfl,a

    N=size(xx,1)
    M=size(df1)-1
    delta_F=0._pr
    do i=1,M
      df=df1(i)
      a=sum(1._pr/(1._pr+exp(beta*xx(:,i)-df)))/real(N,pr) - &
        sum(1._pr/(1._pr+exp(beta*zz(:,i+1)+df)))/real(N,pr)
      if(a < 0._pr)then
        dfl=df
        loop1:do
          df=df+1._pr
          a=sum(1._pr/(1._pr+exp(beta*xx(:,i)-df)))/real(N,pr) - &
            sum(1._pr/(1._pr+exp(beta*zz(:,i+1)+df)))/real(N,pr)
          if(a > 0._pr)then
            dfh=df
            exit loop1
          end if
        end do loop1
      else
        dfh=df
        loop2:do
          df=df-1._pr
          a=sum(1._pr/(1._pr+exp(beta*xx(:,i)-df)))/real(N,pr) - &
            sum(1._pr/(1._pr+exp(beta*zz(:,i+1)+df)))/real(N,pr)
          if(a < 0._pr)then
            dfl=df
            exit loop2
          end if
        end do loop2
      end if

      !** Bisection Method
      do
        if(dfh-dfl < 1.e-4_pr)exit
        df=(dfl+dfh)/2._pr
        a=sum(1._pr/(1._pr+exp(beta*xx(:,i)-df)))/real(N,pr) - &
          sum(1._pr/(1._pr+exp(beta*zz(:,i+1)+df)))/real(N,pr)
        if(a < 0._pr)dfl=df
        if(a > 0._pr)dfh=df
      end do
      delta_F=delta_F+dfh
    end do
  end subroutine compute_deltaF_bar
end program bar
