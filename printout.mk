FFLAGS=-c
LDFLAGS=
SOURCES=printout.f usercheck.f fourcheck.f COMP.f
OBJECTS=$(SOURCES:.f=.o)
EXECUTABLE=printout

all: $(SOURCES) $(EXECUTABLE)

clean:
	rm -f $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(FC) $(LDFLAGS) $(OBJECTS) -o $@.exe

.f.o:
	$(FC) $(FFLAGS) $< -o $@
