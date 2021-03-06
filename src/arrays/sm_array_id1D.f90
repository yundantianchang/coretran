  submodule (m_array1D) m_Array_id1D
    !! Routines for double precision integer arrays

  implicit none

  contains
  !====================================================================!
  module procedure arange_id1D
    !! Interfaced with [[arange]]
  !====================================================================!
  !module function arange_id1D(start,stp,_step) result(this)
  !integer(i64) :: start !! Start from here
  !integer(i64) :: stp !! Stop here
  !integer(i64) :: step !! Step size
  !integer(i64), allocatable :: res(:)
  integer(i64) :: i
  integer(i64) :: N
  integer(i64) :: step_
  step_ = 1
  if (present(step)) step_ = step
  N=((stp-start)/step_)+1
  if (size(res) /= N) call eMsg('arange_id1D:1D Array must be size '//str(N))
  if (step_ == 1) then
      do i = 1, N
          res(i) = start + i-1
      enddo
  else
      do i = 1, N
          res(i) = start + (i-1)*step_
      enddo
  endif
  end procedure
  !====================================================================!
  !====================================================================!
  module procedure diff_id1D
    !! Interfaced [[diff]]
  !====================================================================!
!  integer(i64), intent(in) :: this(:) !! 1D array
!  integer(i64) :: res(size(this)-1) !! Difference along array
  integer(i32) :: i
  integer(i32) :: N
  N=size(this)
  if (size(res) /= N-1) call eMsg('diff_id1D:Result must be size '//str(N-1))
  do i=1,N-1
    res(i) = this(i+1) - this(i)
  end do
  end procedure
  !====================================================================!
  !====================================================================!
  module procedure isSorted_id1D
    !! Interfaced with [[isSorted]]
  !====================================================================!
  !module function isSorted_id1D(this) result(yes)
  !integer(i64):: this(:) !! 1D array
  !logical :: yes !! isSorted
  integer :: i,N
  N=size(this)
  yes=.true.
  do i=2,N
    if (this(i) < this(i-1)) then
      yes=.false.
      return
    end if
  end do
  end procedure
  !====================================================================!
  !====================================================================!
  module procedure isSorted_id1Di1D
    !! Interfaced with [[isSorted]]
  !====================================================================!
  !module function isSorted_d1D(this) result(yes)
  !real(r64):: this(:) !! 1D array
  !integer(i32) :: indx(:)
  !logical :: yes !! isSorted
  integer :: i,N
  N=size(this)
  yes=.true.
  do i=2,N
    if (this(indx(i)) < this(indx(i-1))) then
      yes=.false.
      return
    end if
  end do
  end procedure
  !====================================================================!
  !====================================================================!
  module procedure repeat_id1D
    !! Interfaced with [[repeat]]
  !====================================================================!
!  integer(i64) :: this(:) !! 1D array
!  integer(i32) :: nRepeats !! Number of times each element should be repeated
!  integer(i64) :: res(size(this)*nRepeats)
  integer(i32) :: i,k,N,nTmp
  N = size(this)
  nTmp = N*nRepeats
  call allocate(res, nTmp)
  !if (size(res) /= nTmp) call eMsg('repeat_d1D:Result must be size '//str(nTmp))
  k=1
  do i = 1, N
    res(k:k+nRepeats-1) = this(i) ! Repeat the element
    k = k + nRepeats
  end do
  end procedure
  !====================================================================!
  !====================================================================!
  module procedure shuffle_id1D
    !! Interfaced with [[shuffle]]
  !====================================================================!
  !module subroutine shuffle_id1D(this)
  !integer(i64) :: this(:)
  integer(i32) :: i
  integer(i32) :: N
  integer(i32) :: r
  N=size(this)
  do i = 2, N
    call rngInteger(r, 1, i)
    call swap(this(i), this(r))
  end do
  end procedure
  !====================================================================!
end submodule
