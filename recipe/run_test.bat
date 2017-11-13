cd data

ncgen -o in.nc in.cdl

ncks -H --trd -v one in.nc
if errorlevel 1 exit 1
