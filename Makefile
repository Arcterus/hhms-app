all: hhms-lib

BASE := "$(shell pwd)"
CXXFLAGS += -I$(BASE)/include/hhms-lib

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
	xcodebuild -sdk iphoneos

ios-simulator-run:
	"`locate Contents/MacOS/iPhone\ Simulator | sed -n 1p`" -SimulateApplication \
		build/Release-iphonesimulator/"Harker Homework Management System".app/"Harker Homework Management System"

ios-device-install:
	fruitstrap build/Release-iphoneos/"Harker Homework Management System".app

ios-device-run:
	fruitstrap -d build/Release-iphoneos/"Harker Homework Management System".app

android: hhms-lib android-hhms-lib

clean:
	rm -r src/hhms-lib/*.{o,a} build
