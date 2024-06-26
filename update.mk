FFLAGS=-c -w
LDFLAGS=
SOURCES=update.f usercheck.f fourcheck.f digits.f float.f datecheck.f day.f FTRAP.f FRESET.f COMP.f
OBJECTS=$(SOURCES:.f=.o)
EXECUTABLE=update

.PHONY: all clean

all: $(SOURCES) $(EXECUTABLE)

clean:
	rm -f $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(FC) $(LDFLAGS) $(OBJECTS) -o $@.exe

.f.o:
	$(FC) $(FFLAGS) $< -o $@
