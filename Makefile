all: hhms-lib

BASE := "$(shell pwd)"

ifndef APPNAME
	APPNAME = *
else
	APPNAME = "$(APPNAME)"
endif 

hhms-lib:
	cd src/hhms-lib && \
		$(CXX) $(CXXFLAGS) -I$(BASE)/include/hhms-lib -c pugixml/*.cpp *.cpp && \
		ar rcs hhms-lib.a *.o

ios-simulator: hhms-lib
	xcodebuild -sdk iphonesimulator

ios-device: hhms-lib
	xcodebuild -sdk iphone

ios-run:
	open "`locate Contents/MacOS/iPhone\ Simulator | sed -n 1p`" --args -SimulateApplication build/Release-iphonesimulator/$(APPNAME).app

android: hhms-lib android-hhms-lib

clean:
	rm -r src/{ios,android,hhms-lib}/*.{o,a} build
