# ReadFY4A
Read FY4A satellite image

## conxy2ll.c:
  convert (x,y from Netcdf file) -> (lon,lat)

## rNC.F90:
  read Z_SATE_C_BAWX_20230326030646_P_FY4A-_AGRI--_N_DISK_1047E_L2-_SSI-_MULT_NOM_20230326024500_20230326025959_4000M_V0001.NC
  
## for check:
  > FY4A-_AGRI--_N_DISK_1047E_L2-_SSI-_MULT_NOM_20230326024500_20230326025959_4000M_V0001.NC.jpg : 
  > http://img.nsmc.org.cn/IMG_LIB/FY4A/FY4A-_AGRI--_N_DISK_1047E_L2-_SSI-_MULT_NOM_YYYYMMDDhhmmss_YYYYMMDDhhmmss_4000M_V0001.NC/20230326/FY4A-_AGRI--_N_DISK_1047E_L2-_SSI-_MULT_NOM_20230326024500_20230326025959_4000M_V0001.NC.jpg
  
  > FY4A-Orbit-detail.png : FY4A orbit information
  > NcViewer-SSI.png & NcViewer-Setting.png : Image fro NcView.
 
## Data Accessing and ref:
Data Availability : 
  >https://satellite.nsmc.org.cn/PortalSite/Data/DataView.aspx?SatelliteType=1&SatelliteCode=FY4A&currentculture=en-US#
  
Satellite orbit : 
  >Mobile-satellites-in-various-earth-orbits-LEO-MEO-and-GEO.png
  
reference & modified from: 
  another transfer from git: 
  > vensing/FY4A_Enhance.git : FY4A_Enhance.java

Reference of math:
  > cgms-lrit-hrit-global-specification-(v2-8-of-30-oct-2013).pdf
  > FY4A成像仪标称上行列号和经纬度的互相转换方法.pdf
  
## the time tag seems is UTC, not BJ time.
