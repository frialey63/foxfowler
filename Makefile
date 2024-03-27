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
