# Completely Fair Scheduler (CFS)
Es un algoritmo de programación de procesos utilizado en el kernel de Linux para administrar la asignación de recursos de CPU entre múltiples tareas.

## Historia y Desarrollo
Antes de la versión 2.5 del kernel de Linux, se utilizaba una variación del algoritmo de programación de UNIX tradicional.
Sin embargo, esta variación no estaba optimizada para sistemas multiprocesador (SMP) ni para sistemas con un gran número de procesos en ejecución.
La versión 2.5 introdujo el algoritmo de programación O(1), diseñado para ejecutarse en tiempo constante independientemente del número de tareas en el sistema. Este algoritmo mejoró el soporte para sistemas SMP y el rendimiento general.
En la versión 2.6 del kernel, se desarrolló el Completely Fair Scheduler (CFS), que se convirtió en el algoritmo de programación predeterminado a partir de la versión 2.6.23.

## Clases de Programacion
Linux utiliza clases de programación para asignar prioridades a las tareas.
El CFS implementa una clase de programación predeterminada que utiliza el algoritmo CFS y una clase de programación de tiempo real para tareas de tiempo real.

### Real-Time Scheduling with POSIX API

Linux also implements real-time scheduling using the POSIX standard as described in Section 5.6.6. Any task scheduled using either the SCHED_FIFO or the SCHED_RR real-time policy runs at a higher priority than normal (non-realtime) tasks. Linux uses two separate priority ranges, one for real-time tasks and a second for normal tasks. Real-time tasks are assigned static priorities within the range of 0 to 99, and normal tasks are assigned priorities from 100 to 139. These two ranges map into a global priority scheme wherein numerically lower values indicate higher relative priorities. Normal tasks are assigned a priority based on their nice values, where a value of −20 maps to priority 100 and a nice value of +19 maps to 139. This scheme is shown in Figure 5.26.

### Code Example: POSIX Real-Time Scheduling API

Here's an example code snippet demonstrating the use of POSIX real-time scheduling API to create and manage threads with specific scheduling policies:

```c
#include <pthread.h>
#include <stdio.h>

#define NUM_THREADS 5

int main(int argc, char *argv[]) {
    int i, policy;
    pthread_t tid[NUM_THREADS];
    pthread_attr_t attr;

    /* get the default attributes */
    pthread_attr_init(&attr);

    /* get the current scheduling policy */
    if (pthread_attr_getschedpolicy(&attr, &policy) != 0) {
        fprintf(stderr, "Unable to get policy.\n");
    } else {
        if (policy == SCHED_OTHER)
            printf("SCHED_OTHER\n");
        else if (policy == SCHED_RR)
            printf("SCHED_RR\n");
        else if (policy == SCHED_FIFO)
            printf("SCHED_FIFO\n");
    }

    /* set the scheduling policy - FIFO, RR, or OTHER */
    if (pthread_attr_setschedpolicy(&attr, SCHED_FIFO) != 0)
        fprintf(stderr, "Unable to set policy.\n");

    /* create the threads */
    for (i = 0; i < NUM_THREADS; i++)
        pthread_create(&tid[i], &attr, runner, NULL);

    /* now join on each thread */
    for (i = 0; i < NUM_THREADS; i++)
        pthread_join(tid[i], NULL);

    return 0;
}

/* Each thread will begin control in this function */
void *runner(void *param) {
    /* do some work ... */
    pthread_exit(0);
}
```

## Asigancion de Recursos
El CFS asigna proporciones de tiempo de CPU a las tareas en función del valor "nice" asignado a cada tarea.
Los valores "nice" van de -20 a +19, donde valores más bajos indican prioridad más alta.
En lugar de usar valores de tiempo de ejecución discretos, el CFS identifica una latencia objetivo, donde cada tarea debe ejecutarse al menos una vez durante ese período.

## Registro de Tiempo Virtual
El CFS mantiene el tiempo de ejecución virtual (vruntime) de cada tarea para registrar cuánto tiempo ha estado en ejecución.
Las tareas de prioridad más baja tienen tasas de desgaste más altas para el tiempo virtual que las tareas de mayor prioridad.
El CFS selecciona la próxima tarea a ejecutar según la vruntime más baja.

## Equilibrio de Carga
El CFS admite el equilibrio de carga entre los núcleos de procesamiento, minimizando la migración de hilos y siendo consciente de la arquitectura NUMA.
Utiliza una métrica de carga que combina la prioridad de la tarea y su tasa de utilización de CPU promedio.
Las tareas se agrupan en dominios de programación para optimizar el equilibrio de carga dentro del sistema.

## Funcionamiento del Completely Fair Scheduler (CFS) de Linux
El CFS utiliza un árbol de búsqueda binario balanceado (red-black tree) para organizar las tareas en función de su vruntime.
Cada tarea se agrega al árbol cuando se vuelve ejecutable y se elimina cuando está bloqueada.
La tarea con la vruntime más baja (es decir, la de mayor prioridad) se encuentra en el nodo más a la izquierda del árbol.

<image src="https://slideplayer.com/slide/14370821/89/images/58/Figure+illustrates+a+Red+Black+Tree.jpg" alt="Red Black Tree CFS">

En este árbol:

Cada tarea se representa como un nodo.
Las tareas se organizan en función de su vruntime, con las tareas con menor vruntime (mayor prioridad) hacia la izquierda y las tareas con mayor vruntime hacia la derecha.
El nodo más a la izquierda del árbol contiene la tarea con la vruntime más baja, lo que indica la tarea de mayor prioridad.

### Proceso de Programación de Tareas:

#### Inserción de Tareas:
Cuando una tarea se vuelve ejecutable, se inserta en el árbol de búsqueda binario.
Se coloca en la posición adecuada según su vruntime.
La inserción en un árbol de búsqueda binario balanceado tiene una complejidad de tiempo de O(log N), donde N es el número de nodos en el árbol.

#### Selección de la Próxima Tarea:
La tarea con la vruntime más baja (es decir, la más a la izquierda en el árbol) se selecciona como la próxima tarea a ejecutar.
Esta tarea tiene la mayor prioridad en el sistema en ese momento.

#### Eliminación de Tareas:
Cuando una tarea deja de ser ejecutable (por ejemplo, está bloqueada esperando E/S), se elimina del árbol de búsqueda binario.
Esto asegura que solo las tareas ejecutables estén presentes en el árbol en cualquier momento dado.

#### Ventajas del CFS:
- Justicia: Asigna equitativamente el tiempo de CPU entre todas las tareas ejecutables.
- Eficiencia: Utiliza una estructura de datos eficiente (árbol de búsqueda binario balanceado) para la selección de tareas.
- Priorización: Prioriza las tareas según su vruntime, asegurando que las tareas de mayor prioridad se ejecuten primero.

El CFS garantiza una asignación justa y eficiente de recursos de CPU en sistemas Linux, lo que contribuye a un rendimiento óptimo del sistema en entornos multiprocesador y multitarea.
