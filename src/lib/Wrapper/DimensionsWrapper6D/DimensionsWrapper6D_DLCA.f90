module DimensionsWrapper6D_DLCA

USE DimensionsWrapper6D
USE IR_Precision, only: I4P, str
USE ErrorMessages

implicit none
private

    type, extends(DimensionsWrapper6D_t) :: DimensionsWrapper6D_DLCA_t
        character(len=:), allocatable :: Value(:,:,:,:,:,:)
    contains
    private
        procedure, public :: Set            => DimensionsWrapper6D_DLCA_Set
        procedure, public :: Get            => DimensionsWrapper6D_DLCA_Get
        procedure, public :: GetShape       => DimensionsWrapper6D_DLCA_GetShape
        procedure, public :: GetPointer     => DimensionsWrapper6D_DLCA_GetPointer
        procedure, public :: GetPolymorphic => DimensionsWrapper6D_DLCA_GetPolymorphic
        procedure, public :: isOfDataType   => DimensionsWrapper6D_DLCA_isOfDataType
        procedure, public :: Print          => DimensionsWrapper6D_DLCA_Print
        procedure, public :: Free           => DimensionsWrapper6D_DLCA_Free
        final             ::                   DimensionsWrapper6D_DLCA_Final
    end type           

public :: DimensionsWrapper6D_DLCA_t

contains


    subroutine DimensionsWrapper6D_DLCA_Final(this) 
    !-----------------------------------------------------------------
    !< Final procedure of DimensionsWrapper6D
    !-----------------------------------------------------------------
        type(DimensionsWrapper6D_DLCA_t), intent(INOUT) :: this
    !-----------------------------------------------------------------
        call this%Free()
    end subroutine


    subroutine DimensionsWrapper6D_DLCA_Set(this, Value) 
    !-----------------------------------------------------------------
    !< Set DLCA Wrapper Value
    !-----------------------------------------------------------------
        class(DimensionsWrapper6D_DLCA_t), intent(INOUT) :: this
        class(*),                          intent(IN)    :: Value(:,:,:,:,:,:)
        integer                                          :: err
    !-----------------------------------------------------------------
#ifdef __GFORTRAN__ 
        call msg%Warn(txt='Setting value: Array of deferred length allocatable arrays not supported in Gfortran)',&
                      file=__FILE__, line=__LINE__ )
#else   
        select type (Value)
            type is (character(len=*))
                allocate(character(len=len(Value))::               &
                                    this%Value(size(Value,dim=1),  &
                                    size(Value,dim=2),             &
                                    size(Value,dim=3),             &
                                    size(Value,dim=4),             &
                                    size(Value,dim=5),             &
                                    size(Value,dim=6)),            &
                                    stat=err)
                this%Value = Value
                if(err/=0) &
                    call msg%Error( txt='Setting Value: Allocation error ('//&
                                    str(no_sign=.true.,n=err)//')', &
                                    file=__FILE__, line=__LINE__ )
            class Default
                call msg%Warn( txt='Setting value: Expected data type (character(*))', &
                               file=__FILE__, line=__LINE__ )

        end select
#endif
    end subroutine


    subroutine DimensionsWrapper6D_DLCA_Get(this, Value) 
    !-----------------------------------------------------------------
    !< Get deferred length character array Wrapper Value
    !-----------------------------------------------------------------
        class(DimensionsWrapper6D_DLCA_t), intent(IN)  :: this
        class(*),                          intent(OUT) :: Value(:,:,:,:,:,:)
    !-----------------------------------------------------------------
        select type (Value)
            type is (character(len=*))
                if(all(this%GetShape() == shape(Value))) then
                    Value = this%Value
                else
                    call msg%Warn(txt='Getting value: Expected shape ('//    &
                                  str(no_sign=.true.,n=this%GetShape())//')',&
                                  file=__FILE__, line=__LINE__ )
                endif
            class Default
                call msg%Warn(txt='Getting value: Expected data type (character(*))',&
                              file=__FILE__, line=__LINE__ )
        end select
    end subroutine


    function DimensionsWrapper6D_DLCA_GetShape(this) result(ValueShape) 
    !-----------------------------------------------------------------
    !< Get Wrapper Value Shape
    !-----------------------------------------------------------------
        class(DimensionsWrapper6D_DLCA_t), intent(IN)  :: this
        integer(I4P), allocatable                      :: ValueShape(:)
    !-----------------------------------------------------------------
        allocate(ValueShape(this%GetDimensions()))
        ValueShape = shape(this%Value)
    end function


    function DimensionsWrapper6D_DLCA_GetPointer(this) result(Value) 
    !-----------------------------------------------------------------
    !< Get Unlimited Polymorphic pointer to Wrapper Value
    !-----------------------------------------------------------------
        class(DimensionsWrapper6D_DLCA_t), target, intent(IN)  :: this
        class(*), pointer                                      :: Value(:,:,:,:,:,:)
    !-----------------------------------------------------------------
        Value => this%Value
    end function


    subroutine DimensionsWrapper6D_DLCA_GetPolymorphic(this, Value) 
    !-----------------------------------------------------------------
    !< Get Unlimited Polymorphic Wrapper Value
    !-----------------------------------------------------------------
        class(DimensionsWrapper6D_DLCA_t), intent(IN)  :: this
        class(*), allocatable,             intent(OUT) :: Value(:,:,:,:,:,:)
    !-----------------------------------------------------------------
!        allocate(Value(size(this%Value,dim=1),  &
!                       size(this%Value,dim=2),  &
!                       size(this%Value,dim=3),  &
!                       size(this%Value,dim=4),  &
!                       size(this%Value,dim=5),  &
!                       size(this%Value,dim=6)), &
!                       source=this%Value)
    end subroutine


    subroutine DimensionsWrapper6D_DLCA_Free(this) 
    !-----------------------------------------------------------------
    !< Free a DimensionsWrapper6D
    !-----------------------------------------------------------------
        class(DimensionsWrapper6D_DLCA_t), intent(INOUT) :: this
        integer                                         :: err
    !-----------------------------------------------------------------
        if(allocated(this%Value)) then
            deallocate(this%Value, stat=err)
            if(err/=0) call msg%Error(txt='Freeing Value: Deallocation error ('// &
                                      str(no_sign=.true.,n=err)//')',             &
                                      file=__FILE__, line=__LINE__ )
        endif
    end subroutine


    function DimensionsWrapper6D_DLCA_isOfDataType(this, Mold) result(isOfDataType)
    !-----------------------------------------------------------------
    !< Check if Mold and Value are of the same datatype 
    !-----------------------------------------------------------------
        class(DimensionsWrapper6D_DLCA_t), intent(IN) :: this         !< Dimensions wrapper 6D
        class(*),                          intent(IN) :: Mold         !< Mold for data type comparison
        logical                                  :: isOfDataType      !< Boolean flag to check if Value is of the same data type as Mold
    !-----------------------------------------------------------------
        isOfDataType = .false.
        select type (Mold)
            type is (character(len=*))
                isOfDataType = .true.
        end select
    end function DimensionsWrapper6D_DLCA_isOfDataType


    subroutine DimensionsWrapper6D_DLCA_Print(this, unit, prefix, iostat, iomsg)
    !-----------------------------------------------------------------
    !< Print Wrapper
    !-----------------------------------------------------------------
        class(DimensionsWrapper6D_DLCA_t),intent(IN)  :: this         !< DimensionsWrapper
        integer(I4P),                     intent(IN)  :: unit         !< Logic unit.
        character(*), optional,           intent(IN)  :: prefix       !< Prefixing string.
        integer(I4P), optional,           intent(OUT) :: iostat       !< IO error.
        character(*), optional,           intent(OUT) :: iomsg        !< IO error message.
        character(len=:), allocatable                 :: prefd        !< Prefixing string.
        integer(I4P)                                  :: iostatd      !< IO error.
        character(500)                                :: iomsgd       !< Temporary variable for IO error message.
    !-----------------------------------------------------------------
        prefd = '' ; if (present(prefix)) prefd = prefix
        write(unit=unit,fmt='(A,$)',iostat=iostatd,iomsg=iomsgd) prefd//' Data Type = DLCA'//&
                        ', Dimensions = '//trim(str(no_sign=.true., n=this%GetDimensions()))//&
                        ', Value = '
        write(unit=unit,fmt=*,iostat=iostatd,iomsg=iomsgd) this%Value
        if (present(iostat)) iostat = iostatd
        if (present(iomsg))  iomsg  = iomsgd
    end subroutine DimensionsWrapper6D_DLCA_Print

end module DimensionsWrapper6D_DLCA
