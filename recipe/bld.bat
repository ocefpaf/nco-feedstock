mkdir %SRC_DIR%\build
cd %SRC_DIR%\build

cmake -G "NMake Makefiles" ^
      -D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -D CMAKE_BUILD_TYPE=Release ^
      -D NCO_MSVC_USE_MT=yes ^
      -D CMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      -D NETCDF_INCLUDE=%LIBRARY_INC% ^
      -D NETCDF_LIBRARY=%LIBRARY_LIB%\netcdf.lib ^
      -D HDF5_LIBRARY=%LIBRARY_LIB%\libhdf5.lib ^
      -D HDF5_HL_LIBRARY=%LIBRARY_LIB%\libhdf5_hl.lib ^
      -D UDUNITS2_INCLUDE=%LIBRARY_LIB% ^
      -D UDUNITS2_LIBRARY=%LIBRARY_LIB%\udunits2.lib ^
      -D EXPAT_LIBRARY=%LIBRARY_LIB%\expat.lib ^
      -D CURL_LIBRARY=%LIBRARY_LIB%\libcurl.lib ^
      -D ANTLR_INCLUDE:PATH=%LIBRARY_INC%\antlr ^
      %SRC_DIR%
if errorlevel 1 exit 1


nmake
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1

move %LIBRARY_PREFIX%\*.exe %LIBRARY_BIN% || exit 1
