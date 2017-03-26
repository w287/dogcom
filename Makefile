CC     = gcc
TARGET = dogcom
INSTALL_DIR = /usr/bin/

ifeq ($(debug), y)
	CFLAGS += -DDEBUG -g
endif

ifeq ($(win32), y)
	CFLAGS += -lws2_32
	# TARGET = dogcom-MinGW
endif

ifeq ($(force_encrypt), y)
	CFLAGS += -DFORCE_ENCRYPT
endif

ifeq ($(test), y)
	CFLAGS += -std=gnu99 -Werror -DTEST
else
	CFLAGS += -std=gnu99 -Werror
endif

SOURCES = $(wildcard *.c) $(wildcard libs/*.c)
OBJS    = $(patsubst %.c, %.o, $(SOURCES))

$(TARGET):	$(OBJS)
	$(CC) $(DEBUG) $(TEST) $(OBJS) $(CFLAGS) -o $(TARGET)

all:	$(TARGET)

install:	$(TARGET)
	cp $(TARGET) $(INSTALL_DIR)

clean:
	rm -f $(OBJS)
	rm -f $(TARGET)

distclean:  clean

.PHONY: all clean distclean install
