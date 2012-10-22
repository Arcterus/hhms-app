all: hhms-lib

BASE := "$(shell pwd)"
CXXFLAGS += -I$(BASE)/include/hhms-lib

ifndef APPNAME
	APPNAME = *
else
	APPNAME = "$(APPNAME)"
endif 

PLATFORM_HEADERS = -I$(BASE)/include/ios
ifeq ($(MAKECMDGOALS), android)
	PLATFORM_HEADERS = -I$(BASE)/include/android
endif
CXXFLAGS += $(PLATFORM_HEADERS)

hhms-lib:
	cd src/hhms-lib && \
		$(CXX) $(CXXFLAGS) -c pugixml/*.cpp *.cpp && \
		ar rcs hhms-lib.a *.o

ios-simulator: hhms-lib
	xcodebuild -sdk iphonesimulator

ios-device: hhms-lib
	xcodebuild -sdk iphone

ios-run:
	open "`locate Contents/MacOS/iPhone\ Simulator | sed -n 1p`" --args -SimulateApplication build/Release-iphonesimulator/$(APPNAME).app

android: hhms-lib android-hhms-lib

clean:
	@echo "\nDo not worry about errors.\n"
	rm -r src/{ios,android,hhms-lib}/*.{o,a} build
