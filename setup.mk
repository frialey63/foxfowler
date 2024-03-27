FFLAGS=-c
LDFLAGS=
SOURCES=setup.f usercheck.f fourcheck.f yearcheck.f datecheck.f float.f day.f FTRAP.f FRESET.f COMP.f
OBJECTS=$(SOURCES:.f=.o)
EXECUTABLE=setup

all: $(SOURCES) $(EXECUTABLE)

clean:
	rm -f $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(FC) $(LDFLAGS) $(OBJECTS) -o $@.exe

.f.o:
	$(FC) $(FFLAGS) $< -o $@
