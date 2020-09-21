TARGET = PPSSPP

.PHONY: all clean

all:
	sh make-all.sh

ipa:
	sh make-ipa.sh

deb:
	sh make-deb.sh

clean:
	rm -rf ppsspp/build-ios *.ipa *.deb
