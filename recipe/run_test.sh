#!/bin/bash

ncgen -o data/in.nc data/in.cdl
fin=data/in.nc

ncks -H --trd -v one $fin

ncks -O --rgr skl=skl_t42.nc \
        --rgr grid=grd_t42.nc \
        --rgr latlon=64,128 \
        --rgr lat_typ=gss \
        --rgr lon_typ=Grn_ctr \
        $fin \
        foo.nc

ncks -O --rgr grid=grd_2x2.nc \
        --rgr latlon=90,180 \
        --rgr lat_typ=eqa \
        --rgr lon_typ=Grn_wst \
        $fin \
        foo.nc


ncap2 -O -s 'tst[lat,lon]=1.0f' skl_t42.nc dat_t42.nc
if [[ $(uname) == Darwin ]]; then
  ncremap -a conserve -s grd_t42.nc -g grd_2x2.nc -m map_t42_to_2x2.nc  # FIXME: This call for reason prevent CircleCI from uploading the package!
  ncremap -i dat_t42.nc -m map_t42_to_2x2.nc -o dat_2x2.nc
  ncwa -O dat_2x2.nc dat_avg.nc
  ncks -C -H -v tst dat_avg.nc
fi
