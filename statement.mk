FFLAGS=-c -w
LDFLAGS=
SOURCES=statement.f usercheck.f fourcheck.f digits.f FTRAP.f FRESET.f COMP.f COPY.f
OBJECTS=$(SOURCES:.f=.o)
EXECUTABLE=statement

.PHONY: all clean

all: $(SOURCES) $(EXECUTABLE)

clean:
	rm -f $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(FC) $(LDFLAGS) $(OBJECTS) -o $@.exe

.f.o:
	$(FC) $(FFLAGS) $< -o $@
