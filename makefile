# Makefile for building executable client file 

echo	= /bin/echo

executable: specFiles linking 

specFiles:
	c++ -c delim.cpp
	c++ -c iobuffer.cpp
	c++ -c varlen.cpp
	c++ -c dbase.cpp
	c++ -c cd.cpp

linking: 
	c++ -o inventory inventory.cpp delim.o iobuffer.o varlen.o cd.o dbase.o
