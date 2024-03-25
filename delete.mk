FFLAGS=-c
LDFLAGS=
SOURCES=delete.f usercheck.f fourcheck.f digits.f FTRAP.f FRESET.f COMP.f
OBJECTS=$(SOURCES:.f=.o)
EXECUTABLE=delete

all: $(SOURCES) $(EXECUTABLE)

clean:
	rm -f $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(FC) $(LDFLAGS) $(OBJECTS) -o $@

.f.o:
	$(FC) $(FFLAGS) $< -o $@
