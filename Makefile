NOOP=/bin/sh -c true

.PHONY: all clean backup progress reset balance delete origin printout setup statement update

all:
	make -f balance.mk
	make -f delete.mk
	make -f origin.mk
	make -f printout.mk
	make -f setup.mk
	make -f statement.mk
	make -f update.mk

clean:
	rm -f *.exe

backup:
	cp fort.4 "fort.4_`date +%H:%M_%d-%m-%y`"

progress:
	if [ -f "fort.2" ]; then mv fort.2 fort.4; fi
	sed -i 's/^ //' fort.4

reset:
	rm -f fort.*

balance:
	balance.exe

run_delete:
	delete.exe

run_origin:
	origin.exe

printout:
	printout.exe

run_setup:
	setup.exe

run_update:
	update.exe

statement:
	statement.exe

delete: run_delete backup progress
	$(NOOP)

origin: run_origin progress
	$(NOOP)

setup: run_setup backup progress
	$(NOOP)

update: run_update backup progress
	$(NOOP)
