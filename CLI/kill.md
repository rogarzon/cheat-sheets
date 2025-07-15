# KILL Command

<!-- TOC -->
* [KILL Command](#kill-command)
  * [Descripción](#descripción)
  * [Opciones](#opciones)
  * [Señales más comunes](#señales-más-comunes)
<!-- TOC -->

## Descripción

Envía a los procesos nombrados por **PID** (o **IDTRABAJO**) la señal **ID_SEÑAL** o **NUM_SEÑAL**. Si no están presentes ni **ID_SEÑAL** o **NUM_SEÑAL**, se asume `SIGTERM`.

## Opciones

- `-l`: lista los nombres de señales; si hay argumentos a continuación de `-l', se asume que son números de señal para las cuales se debe mostrar el nombre.
- `-n sig`: **SIG** es un número de señal
- `-s sig`: **SIG** es un nombre de señal

| Nº | Señal       | Nº | Señal       | Nº | Señal       | Nº | Señal       | Nº | Señal       |
|----|-------------|----|-------------|----|-------------|----|-------------|----|-------------|
| 1  | SIGHUP      | 2  | SIGINT      | 3  | SIGQUIT     | 4  | SIGILL      | 5  | SIGTRAP     |
| 6  | SIGABRT     | 7  | SIGBUS      | 8  | SIGFPE      | 9  | SIGKILL     | 10 | SIGUSR1     |
| 11 | SIGSEGV     | 12 | SIGUSR2     | 13 | SIGPIPE     | 14 | SIGALRM     | 15 | SIGTERM     |
| 16 | SIGSTKFLT   | 17 | SIGCHLD     | 18 | SIGCONT     | 19 | SIGSTOP     | 20 | SIGTSTP     |
| 21 | SIGTTIN     | 22 | SIGTTOU     | 23 | SIGURG      | 24 | SIGXCPU     | 25 | SIGXFSZ     |
| 26 | SIGVTALRM   | 27 | SIGPROF     | 28 | SIGWINCH    | 29 | SIGIO       | 30 | SIGPWR      |
| 31 | SIGSYS      | 34 | SIGRTMIN    | 35 | SIGRTMIN+1  | 36 | SIGRTMIN+2  | 37 | SIGRTMIN+3  |
| 38 | SIGRTMIN+4  | 39 | SIGRTMIN+5  | 40 | SIGRTMIN+6  | 41 | SIGRTMIN+7  | 42 | SIGRTMIN+8  |
| 43 | SIGRTMIN+9  | 44 | SIGRTMIN+10 | 45 | SIGRTMIN+11 | 46 | SIGRTMIN+12 | 47 | SIGRTMIN+13 |
| 48 | SIGRTMIN+14 | 49 | SIGRTMIN+15 | 50 | SIGRTMAX-14 | 51 | SIGRTMAX-13 | 52 | SIGRTMAX-12 |
| 53 | SIGRTMAX-11 | 54 | SIGRTMAX-10 | 55 | SIGRTMAX-9  | 56 | SIGRTMAX-8  | 57 | SIGRTMAX-7  |
| 58 | SIGRTMAX-6  | 59 | SIGRTMAX-5  | 60 | SIGRTMAX-4  | 61 | SIGRTMAX-3  | 62 | SIGRTMAX-2  |
| 63 | SIGRTMAX-1  | 64 | SIGRTMAX    |    |             |    |             |    |             |

## Señales más comunes

Las señales más utilizadas con el comando `kill` son:

- `SIGTERM` (15): Solicita la terminación ordenada de un proceso. Es la señal predeterminada y permite que el proceso realice tareas de limpieza antes de finalizar.
- `SIGKILL` (9): Fuerza la terminación inmediata del proceso. No puede ser ignorada ni manejada por el proceso.
- `SIGINT` (2): Interrumpe un proceso desde el terminal, equivalente a presionar `Ctrl+C`.
- `SIGHUP` (1): Indica que la terminal asociada se ha cerrado. A menudo se usa para recargar la configuración de un proceso.
- `SIGSTOP` (19): Detiene (pausa) un proceso, no puede ser ignorada ni manejada.
- `SIGCONT` (18): Reanuda un proceso detenido por `SIGSTOP` o `SIGTSTP`.