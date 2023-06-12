program BinaryToReadable

  implicit none
  
  character(len=20) :: input_file = "cls_data.1"
  character(len=20) :: output_file = "Data.1"
  
  integer, parameter :: max_values = 100 ! Maximum number of values in the binary file
  
  integer :: num_values, i, ierr
  integer, allocatable :: iter(:), n(:), m(:), s(:),k(:)
  
  ! Open the binary file for reading
  open(unit=10, file=input_file, access='stream', form='unformatted',action='read', status='old', iostat=ierr)
  if (ierr /= 0) then
    write(*, *) "Error opening binary file:", trim(input_file)
    stop
  end if
  
  ! Determine the number of values in the binary file
  inquire(file=input_file, size=num_values)
  num_values = num_values / (5 * 4) ! Assuming each value is of size 4 bytes andthere are 3 values per row
  
  ! Allocate arrays based on the number of values
  allocate(iter(num_values), n(num_values), m(num_values), s(num_values), k(num_values))
  
  ! Read data from the binary file
  i = 1
  do while (ierr == 0)
    read(unit=10, iostat=ierr) iter(i), n(i), m(i),s(i),k(i)
    i = i + 1
  end do
  
  ! Close the binary file
  close(unit=10)
  
  ! Adjust the number of values based on the actual read count
  num_values = i - 2 ! Subtract 2 to exclude the last failed read and the initial i=1 value
  
  ! Open the output file for writing
  open(unit=20, file=output_file, status='replace', action='write', iostat=ierr)
  if (ierr /= 0) then
    write(*, *) "Error opening output file:", trim(output_file)
    stop
  end if
  
  ! Write the readable data to the output file
  do i = 1, num_values
    write(unit=20, fmt='(I10,4X,I10,4X,I10,4X,I10,4X,I10)') iter(i), n(i),m(i),s(i),k(i)
  end do
  
  ! Close the output file
  close(unit=20)
  
  write(*, *) "Conversion complete!"
  
  ! Deallocate arrays
  deallocate(iter, n, m, s)
  
end program BinaryToReadable

