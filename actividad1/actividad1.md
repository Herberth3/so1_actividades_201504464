## Tipos de Kernel y sus Diferencias.
> Kernel Monolitico:
Es el responsable de la gestión de la memoria y de los procesos, de la comunicacion entre procesos y proporciona funciones de soporte de drivers y hardware. Los sistemas Operativos que usan este tipo de kernel son Linux, OS X y Windows. Tambien cabe mencionar que el kernel Monolítico solo define una interfaz de alto nivel sobre el hardware del ordenador. 

>Microkernel o Micronúcleo:
Se basa en ofrecer las funciones básicas de cada dispositivo, administrando todos los componentes que tengan CPU, memoria e IPC. Esto supone un mayor control de dispositivos. Son mas compactos que otro tipo de núcleo, por lo que brinda un conjunto reducido de abstracciones básicas del hardware, lo cual brinda beneficios en cuanto a portabilidad, seguridad y su capacidad para adaptarse.Sin embargo, el rendimiento de la máquina puede verse afectado, especialmente, en lo que respecta a la velocidad de las reacciones del hardware, y los tiempos de espera de los procesos para obtener información o tener acceso a otros. Como ejemplo solo existe el componente Mach de OS X, ya que hasta ahora no hay ningún sistema operativo con microkernel.

>Kernel Híbrido:
El kernel híbrido es una combinación de microkernel y kernel monolítico, este enfoque de núcleo combina la velocidad y el diseño más simple del núcleo monolítico con la modularidad y seguridad de ejecución del microkernel, cabe mencionar que ejecuta algunos servicios en el espacio del núcleo para reducir la sobrecarga de rendimiento de un microkernel tradicional, mientras sigue ejecutando el código del núcleo como servidores en el espacio del usuario. Por ejemplo, un diseño de núcleo híbrido puede mantener el sistema de archivos virtuales y los controladores de bus dentro del núcleo y los controladores del sistema de archivos y los controladores de almacenamiento como programas de modo de usuario fuera del núcleo. El kernel de Microsoft NT es un ejemplo bien conocido de un kernel híbrido que alimenta Windows NT, Windows 2000, Windows XP, Windows Server 2003, Windows Vista, Windows Server 2008 y Windows 7.


## User vs Kernel Mode.
>User Mode:
Al iniciar una aplicación en modo de usuario, Windows crea un proceso para la aplicación. El proceso proporciona a la aplicación un espacio de direcciones virtuales privado y una tabla de identificadores privados. Dado que el espacio de direcciones virtuales de una aplicación es privado, una aplicación no puede modificar los datos que pertenecen a otra aplicación.
Además de ser privado, el espacio de direcciones virtuales de una aplicación en modo de usuario es limitado. Un proceso que se ejecuta en modo de usuario no puede acceder a direcciones virtuales reservadas para el sistema operativo. Limitar el espacio de direcciones virtuales de una aplicación en modo de usuario impide que la aplicación modifique los datos críticos del sistema operativo, y posiblemente perjudiciales.

>Kernel Mode:
Todo el código que se ejecuta en modo kernel comparte un único espacio de direcciones virtuales. Por lo tanto, un controlador en modo kernel no está aislado de otros controladores y del propio sistema operativo. Si un controlador en modo kernel escribe accidentalmente en la dirección virtual incorrecta, los datos que pertenecen al sistema operativo u otro controlador podrían verse comprometidos. Si se bloquea un controlador en modo kernel, todo el sistema operativo se bloquea.

## Interruptions vs Traps
| Atributo | Interrupcion | Trampa |
| -------- | ------------ | ------ |
| Definición | Evento que suspende temporalmente la ejecución de un programa y transfiere el control a un controlador de interrupciones específico. | Una excepción o una interrupción generada por software que se desencadena intencionadamente para ejecutar una rutina específica o controlar una condición de error. |
| Detonante | Generado externamente por dispositivos de hardware o señales. | Generado internamente por instrucciones de software o condiciones excepcionales. |
| Manipulación | Gestionado por rutinas de servicio de interrupción (ISR) o controladores de interrupciones. | Controlado por controladores de capturas o controladores de excepciones. |
| Propósito | Permite que la CPU responda a eventos externos o solicitudes de dispositivos. | Permite la ejecución de rutinas específicas o maneja condiciones excepcionales dentro de un programa. |
| Prioridad | Puede tener diferentes niveles de prioridad asignados a diferentes interrupciones. | No tiene niveles de prioridad, ya que las trampas suelen ser sincrónicas y se producen durante la ejecución del programa. |
| Enmascaramiento | Las interrupciones se pueden enmascarar o desactivar para evitar que se produzcan. | Las trampas no se pueden enmascarar ni desactivar, ya que son activadas intencionadamente por el software. |
| Devolución | Las interrupciones devuelven el control al programa interrumpido después de que el controlador de interrupciones complete su ejecución. | Las trampas devuelven el control a la siguiente instrucción después de que el controlador de capturas complete su ejecución. |
