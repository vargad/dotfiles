#pragma once

#ifndef __AVR_ARCH__

#include <unistd.h>

#define _BV(bit) (1<<(bit))

inline void _delay_ms(int ms) { usleep(ms*1000); }
inline void _delay_us(int us) { usleep(us); }

extern unsigned char UCSR0A;
extern unsigned char UCSR0B;
extern unsigned char UCSR0C;
extern unsigned char UBRR0H;
extern unsigned char UBRR0L;
extern unsigned char DDRB;
extern unsigned char DDRD;
extern unsigned char PINB;
extern unsigned char PIND;
extern unsigned char PORTB;
extern unsigned char PORTD;
extern unsigned char UDR0;

#define U2X0 1
#define RXEN0 4
#define TXEN0 3

#endif
