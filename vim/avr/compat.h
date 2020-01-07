#pragma once

#ifndef __AVR_ARCH__

#include <unistd.h>

#define _BV(bit) (1<<(bit))

inline void _delay_ms(int ms) { usleep(ms*1000); }
inline void _delay_us(int us) { usleep(us); }

extern unsigned char UCSR0B;
extern unsigned char DDRB;
extern unsigned char DDRD;
extern unsigned char PINB;
extern unsigned char PIND;
extern unsigned char PORTB;
extern unsigned char PORTD;

#endif
