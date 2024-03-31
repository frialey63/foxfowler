NOOP=/bin/sh -c true
SHELL := /bin/bash

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
	if [ -f "fort.2" ] && [ "`grep -c ZZZZZZZZ fort.2`" == "1" ]; then mv fort.2 fort.4; fi
	sed -i 's/^ //' fort.4

reset:
	rm -f fort.*

run_delete:
	delete.exe

run_origin:
	origin.exe

run_setup:
	setup.exe

run_statement:
	statement.exe

run_update:
	update.exe

balance:
	balance.exe

delete: run_delete backup progress
	$(NOOP)

origin: run_origin progress
	$(NOOP)

printout:
	printout.exe

setup: run_setup backup progress
	$(NOOP)

statement: run_statement backup progress
	$(NOOP)

update: run_update backup progress
	$(NOOP)
