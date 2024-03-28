FFLAGS=-c -w
LDFLAGS=
SOURCES=origin.f usercheck.f fourcheck.f COMP.f
OBJECTS=$(SOURCES:.f=.o)
EXECUTABLE=origin

.PHONY: all clean

all: $(SOURCES) $(EXECUTABLE)

clean:
	rm -f $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(FC) $(LDFLAGS) $(OBJECTS) -o $@.exe

.f.o:
	$(FC) $(FFLAGS) $< -o $@
