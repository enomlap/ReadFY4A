!=============================================================================
! by ncgenall.clj,Nov 15, 2014,rev:Jun 20, 2017;rev:zuo,Nov 09, 2017
! PURPERSE:

!Makefile : FC=gfortran -g
!Makefile : all:rNC.exe
!Makefile : %.exe:%.o
!Makefile : 	$(FC) -L/usr/lib/ -L/usr/lib64/ -lnetcdff -lnetcdf $< -o $@
!Makefile : 
!Makefile : 
!Makefile : %.o:%.F90
!Makefile : 	$(FC) -ffree-line-length-0 -I/usr/lib64/gfortran/modules -I/usr/include -c $<
!Makefile : 
!Makefile : .PHONY:clean
!Makefile : clean:
!Makefile : 	rm -f rNC.o rNC.exe

!=============================================================================
PROGRAM MYRDNC
  USE NETCDF
  IMPLICIT NONE
  integer :: ndims=3
  integer :: o_dimid,y_dimid,x_dimid
  integer :: nominal_satellite_height_varid,DirSSI_varid,y_varid,x_varid,OBIType_varid,DQF_varid,geospatial_lat_lon_extent_varid,SSI_varid,DifSSI_varid,algorithm_product_version_container_varid,nominal_satellite_subpoint_lat_varid,nominal_satellite_subpoint_lon_varid,processing_parm_version_container_varid
  integer,parameter::o_dim=1
  integer,parameter::y_dim=2748
  integer,parameter::x_dim=2748
  character(len=*),parameter::o_dim_NAME="o",y_dim_NAME="y",x_dim_NAME="x"
  byte::DQF(2748,2748)
  real::DifSSI(2748,2748)
  real::DirSSI(2748,2748)
  integer::OBIType(1)
  real::SSI(2748,2748)
  integer::algorithm_product_version_container(1)
  real::geospatial_lat_lon_extent(1)
  real::nominal_satellite_height(1)
  real::nominal_satellite_subpoint_lat(1)
  real::nominal_satellite_subpoint_lon(1)
  integer::processing_parm_version_container(1)
  real::x(2748)
  real::y(2748)
  integer :: ncid
  !--------------------------------------------------------------------------------
  integer,parameter::YC_ix=1409,YC_iy=428
  integer:: IERR
  character(len=256) :: FLNM ! INPUT FILE NAME
  !--------------------------------------------------------------------------------
  IERR=IARGC()
  IF(IERR.NE.1)THEN
    PRINT*,'ARGUMENT NUMBER NOT EQUAL TO 2'
    PRINT*,'USAGE:'
    PRINT*,'    $0 INPUT.TXT'
    CALL EXIT(0)
  ENDIF
  CALL GETARG(1,FLNM)
  OPEN(UNIT=101,FILE=TRIM(FLNM),STATUS="OLD",FORM="FORMATTED",ACTION="READ")
  !CALL CHECK(NF90_OPEN(TRIM("./Z_SATE_C_BAWX_20211031052101_P_FY4A-_AGRI--_N_DISK_1047E_L2-_SSI-_MULT_NOM_20211031050000_20211031051459_4000M_V0001.NC"),NF90_NOWRITE,NCID))
  CALL CHECK(NF90_OPEN(TRIM(FLNM),NF90_NOWRITE,NCID))
  CALL CHECK(NF90_INQ_DIMID(NCID,o_dim_NAME,o_DIMID))
  CALL CHECK(NF90_INQ_DIMID(NCID,y_dim_NAME,y_DIMID))
  CALL CHECK(NF90_INQ_DIMID(NCID,x_dim_NAME,x_DIMID))
  CALL CHECK(NF90_INQ_VARID(NCID,"nominal_satellite_height",nominal_satellite_height_VARID))
  CALL CHECK(NF90_INQ_VARID(NCID,"DirSSI",DirSSI_VARID))
  CALL CHECK(NF90_INQ_VARID(NCID,"y",y_VARID))
  CALL CHECK(NF90_INQ_VARID(NCID,"x",x_VARID))
  CALL CHECK(NF90_INQ_VARID(NCID,"OBIType",OBIType_VARID))
  CALL CHECK(NF90_INQ_VARID(NCID,"DQF",DQF_VARID))
  CALL CHECK(NF90_INQ_VARID(NCID,"geospatial_lat_lon_extent",geospatial_lat_lon_extent_VARID))
  CALL CHECK(NF90_INQ_VARID(NCID,"SSI",SSI_VARID))
  CALL CHECK(NF90_INQ_VARID(NCID,"DifSSI",DifSSI_VARID))
  CALL CHECK(NF90_INQ_VARID(NCID,"algorithm_product_version_container",algorithm_product_version_container_VARID))
  CALL CHECK(NF90_INQ_VARID(NCID,"nominal_satellite_subpoint_lat",nominal_satellite_subpoint_lat_VARID))
  CALL CHECK(NF90_INQ_VARID(NCID,"nominal_satellite_subpoint_lon",nominal_satellite_subpoint_lon_VARID))
  CALL CHECK(NF90_INQ_VARID(NCID,"processing_parm_version_container",processing_parm_version_container_VARID))
  CALL CHECK(NF90_GET_VAR(NCID,nominal_satellite_height_VARID,nominal_satellite_height))
  CALL CHECK(NF90_GET_VAR(NCID,DirSSI_VARID,DirSSI))
  CALL CHECK(NF90_GET_VAR(NCID,y_VARID,y))
  CALL CHECK(NF90_GET_VAR(NCID,x_VARID,x))
  CALL CHECK(NF90_GET_VAR(NCID,OBIType_VARID,OBIType))
  CALL CHECK(NF90_GET_VAR(NCID,DQF_VARID,DQF))
  CALL CHECK(NF90_GET_VAR(NCID,geospatial_lat_lon_extent_VARID,geospatial_lat_lon_extent))
  CALL CHECK(NF90_GET_VAR(NCID,SSI_VARID,SSI))
  ! XY[l= 1479,c= 1660]=[lon= 115.0377,lat=  -3.7610]
  ! XY[l= 1478,c= 1660]=[lon= 115.0372,lat=  -3.7246]
  ! XY[l=   57,c= 1550]=[lon= 124.9828,lat=  69.3709]
  ! XY[l= 1330,c= 1550]=[lon= 110.9935,lat=   1.6484]
  ! XY[l= 1489,c= 2060]=[lon= 130.7570,lat=  -4.1981]
  ! LL[lon= 130.7570,lat=  -4.1981]=[l=1489.00000,c=2060.00000]
  ! YC:
  ! LL[ 106.3000,  38.5000]=[428.51138,1409.09115=]
  ! XY[l=  428,c= 1409]=[lon= 106.2963,lat=  38.5270]


  PRINT*,TRIM(FLNM),"SSI,YC[lon= 106.2963,lat=  38.5270]=[ix=1409,iy=428]",SSI(YC_ix,YC_iy)
  CALL CHECK(NF90_GET_VAR(NCID,DifSSI_VARID,DifSSI))
  CALL CHECK(NF90_GET_VAR(NCID,algorithm_product_version_container_VARID,algorithm_product_version_container))
  CALL CHECK(NF90_GET_VAR(NCID,nominal_satellite_subpoint_lat_VARID,nominal_satellite_subpoint_lat))
  CALL CHECK(NF90_GET_VAR(NCID,nominal_satellite_subpoint_lon_VARID,nominal_satellite_subpoint_lon))
  CALL CHECK(NF90_GET_VAR(NCID,processing_parm_version_container_VARID,processing_parm_version_container))
  CALL CHECK(NF90_CLOSE(NCID))
  !print*,"999"
  CONTAINS
  SUBROUTINE CHECK(STATUS)
    INTEGER,INTENT(IN)::STATUS
    IF(STATUS/=NF90_NOERR)THEN
      PRINT*,TRIM(NF90_STRERROR(STATUS))
      STOP 2
    END IF
  END SUBROUTINE CHECK
end program
