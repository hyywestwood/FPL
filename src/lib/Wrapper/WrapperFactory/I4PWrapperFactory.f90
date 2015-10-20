module I4PWrapperFactory

USE WrapperFactory
USE IR_Precision, only: I1P, I4P
USE DimensionsWrapper
USE DimensionsWrapper0D_I4P
USE DimensionsWrapper1D_I4P
USE DimensionsWrapper2D_I4P
USE DimensionsWrapper3D_I4P
USE DimensionsWrapper4D_I4P
USE DimensionsWrapper5D_I4P
USE DimensionsWrapper6D_I4P
USE DimensionsWrapper7D_I4P

implicit none
private

    type, extends(WrapperFactory_t) :: I4PWrapperFactory_t
    private

    contains
        procedure         :: create0D => I4PWrapperFactory_Create0D
        procedure         :: create1D => I4PWrapperFactory_Create1D
        procedure         :: create2D => I4PWrapperFactory_Create2D
        procedure         :: create3D => I4PWrapperFactory_Create3D
        procedure         :: create4D => I4PWrapperFactory_Create4D
        procedure         :: create5D => I4PWrapperFactory_Create5D
        procedure         :: create6D => I4PWrapperFactory_Create6D
        procedure         :: create7D => I4PWrapperFactory_Create7D
        procedure, public :: hasSameType => I4PWrapperFactory_hasSameType
    end type

    type(I4PWrapperFactory_t), public :: WrapperFactoryI4P

contains

    function I4PWrapperFactory_hasSameType(this, Value) result(hasSameType)
        class(I4PWrapperFactory_t), intent(IN) :: this
        class(*),                   intent(IN) :: Value
        logical                                :: hasSameType
        hasSameType = .false.
        select type(Value)
            type is (integer(I4P))
                hasSameType = .true.
        end select
    end function I4PWrapperFactory_hasSameType


    subroutine I4PWrapperFactory_Create0D(this, Value, Wrapper)
    !-----------------------------------------------------------------
    !< Create I4P 0D Wrapper
    !-----------------------------------------------------------------
        class(I4PWrapperFactory_t),              intent(IN)    :: this
        class(*),                                intent(IN)    :: Value
        class(DimensionsWrapper_t), allocatable, intent(INOUT) :: Wrapper
    !-----------------------------------------------------------------
        if(allocated(Wrapper)) then
            call Wrapper%Free()
            deallocate(Wrapper)
        endif
        if(this%hasSameType(Value)) then
            allocate(DimensionsWrapper0D_I4P_t::Wrapper)
            call Wrapper%SetDimensions(Dimensions=0_I1P)
            select type (Wrapper)
                type is(DimensionsWrapper0D_I4P_t)
                    call Wrapper%Set(Value=Value)
            end select
        endif
    end subroutine I4PWrapperFactory_Create0D


    subroutine I4PWrapperFactory_Create1D(this, Value, Wrapper)
    !-----------------------------------------------------------------
    !< Create I4P 1D Wrapper
    !-----------------------------------------------------------------
        class(I4PWrapperFactory_t),              intent(IN)    :: this
        class(*),                                intent(IN)    :: Value(:)
        class(DimensionsWrapper_t), allocatable, intent(INOUT) :: Wrapper
    !-----------------------------------------------------------------
        if(allocated(Wrapper)) then
            call Wrapper%Free()
            deallocate(Wrapper)
        endif
        if(this%hasSameType(Value(1))) then
            allocate(DimensionsWrapper1D_I4P_t::Wrapper)
            call Wrapper%SetDimensions(Dimensions=1_I1P)
            select type (Wrapper)
                type is(DimensionsWrapper1D_I4P_t)
                    call Wrapper%Set(Value=Value)
            end select
        endif
    end subroutine I4PWrapperFactory_Create1D


    subroutine I4PWrapperFactory_Create2D(this, Value, Wrapper)
    !-----------------------------------------------------------------
    !< Create I4P 2D Wrapper
    !-----------------------------------------------------------------
        class(I4PWrapperFactory_t),              intent(IN)    :: this
        class(*),                                intent(IN)    :: Value(:,:)
        class(DimensionsWrapper_t), allocatable, intent(INOUT) :: Wrapper
    !-----------------------------------------------------------------
        if(allocated(Wrapper)) then
            call Wrapper%Free()
            deallocate(Wrapper)
        endif
        if(this%hasSameType(Value(1,1))) then
            allocate(DimensionsWrapper2D_I4P_t::Wrapper)
            call Wrapper%SetDimensions(Dimensions=2_I1P)
            select type (Wrapper)
                type is(DimensionsWrapper2D_I4P_t)
                    call Wrapper%Set(Value=Value)
            end select
        endif
    end subroutine I4PWrapperFactory_Create2D


    subroutine I4PWrapperFactory_Create3D(this, Value, Wrapper)
    !-----------------------------------------------------------------
    !< Create I4P 3D Wrapper
    !-----------------------------------------------------------------
        class(I4PWrapperFactory_t),              intent(IN)    :: this
        class(*),                                intent(IN)    :: Value(:,:,:)
        class(DimensionsWrapper_t), allocatable, intent(INOUT) :: Wrapper
    !-----------------------------------------------------------------
        if(allocated(Wrapper)) then
            call Wrapper%Free()
            deallocate(Wrapper)
        endif
        if(this%hasSameType(Value(1,1,1))) then
            allocate(DimensionsWrapper3D_I4P_t::Wrapper)
            call Wrapper%SetDimensions(Dimensions=3_I1P)
            select type (Wrapper)
                type is(DimensionsWrapper3D_I4P_t)
                    call Wrapper%Set(Value=Value)
            end select
        endif
    end subroutine I4PWrapperFactory_Create3D


    subroutine I4PWrapperFactory_Create4D(this, Value, Wrapper)
    !-----------------------------------------------------------------
    !< Create I4P 4D Wrapper
    !-----------------------------------------------------------------
        class(I4PWrapperFactory_t),              intent(IN)    :: this
        class(*),                                intent(IN)    :: Value(:,:,:,:)
        class(DimensionsWrapper_t), allocatable, intent(INOUT) :: Wrapper
    !-----------------------------------------------------------------
        if(allocated(Wrapper)) then
            call Wrapper%Free()
            deallocate(Wrapper)
        endif
        if(this%hasSameType(Value(1,1,1,1))) then
            allocate(DimensionsWrapper4D_I4P_t::Wrapper)
            call Wrapper%SetDimensions(Dimensions=4_I1P)
            select type (Wrapper)
                type is(DimensionsWrapper4D_I4P_t)
                    call Wrapper%Set(Value=Value)
            end select
        endif
    end subroutine I4PWrapperFactory_Create4D


    subroutine I4PWrapperFactory_Create5D(this, Value, Wrapper)
    !-----------------------------------------------------------------
    !< Create I4P 5D Wrapper
    !-----------------------------------------------------------------
        class(I4PWrapperFactory_t),              intent(IN)    :: this
        class(*),                                intent(IN)    :: Value(:,:,:,:,:)
        class(DimensionsWrapper_t), allocatable, intent(INOUT) :: Wrapper
    !-----------------------------------------------------------------
        if(allocated(Wrapper)) then
            call Wrapper%Free()
            deallocate(Wrapper)
        endif
        if(this%hasSameType(Value(1,1,1,1,1))) then
            allocate(DimensionsWrapper5D_I4P_t::Wrapper)
            call Wrapper%SetDimensions(Dimensions=5_I1P)
            select type (Wrapper)
                type is(DimensionsWrapper5D_I4P_t)
                    call Wrapper%Set(Value=Value)
            end select
        endif
    end subroutine I4PWrapperFactory_Create5D


    subroutine I4PWrapperFactory_Create6D(this, Value, Wrapper)
    !-----------------------------------------------------------------
    !< Create I4P 6D Wrapper
    !-----------------------------------------------------------------
        class(I4PWrapperFactory_t),              intent(IN)    :: this
        class(*),                                intent(IN)    :: Value(:,:,:,:,:,:)
        class(DimensionsWrapper_t), allocatable, intent(INOUT) :: Wrapper
    !-----------------------------------------------------------------
        if(allocated(Wrapper)) then
            call Wrapper%Free()
            deallocate(Wrapper)
        endif
        if(this%hasSameType(Value(1,1,1,1,1,1))) then
            allocate(DimensionsWrapper6D_I4P_t::Wrapper)
            call Wrapper%SetDimensions(Dimensions=6_I1P)
            select type (Wrapper)
                type is(DimensionsWrapper6D_I4P_t)
                    call Wrapper%Set(Value=Value)
            end select
        endif
    end subroutine I4PWrapperFactory_Create6D


    subroutine I4PWrapperFactory_Create7D(this, Value, Wrapper)
    !-----------------------------------------------------------------
    !< Create I4P 7D Wrapper
    !-----------------------------------------------------------------
        class(I4PWrapperFactory_t),              intent(IN)    :: this
        class(*),                                intent(IN)    :: Value(:,:,:,:,:,:,:)
        class(DimensionsWrapper_t), allocatable, intent(INOUT) :: Wrapper
    !-----------------------------------------------------------------
        if(allocated(Wrapper)) then
            call Wrapper%Free()
            deallocate(Wrapper)
        endif
        if(this%hasSameType(Value(1,1,1,1,1,1,1))) then
            allocate(DimensionsWrapper7D_I4P_t::Wrapper)
            call Wrapper%SetDimensions(Dimensions=7_I1P)
            select type (Wrapper)
                type is(DimensionsWrapper7D_I4P_t)
                    call Wrapper%Set(Value=Value)
            end select
        endif
    end subroutine I4PWrapperFactory_Create7D


end module I4PWrapperFactory
