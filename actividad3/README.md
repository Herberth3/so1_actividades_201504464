### Gestion de usuarios

1. Creación de Usuarios: Crea tres usuarios llamados `usuario1`, `usuario2` y `usuario3`.
  
   ```bash
   :~$ sudo adduser usuario1
   [sudo] password for herberth: 
   Adding user `usuario1' ...
   Adding new group `usuario1' (1001) ...
   Adding new user `usuario1' (1001) with group `usuario1' ...
   Creating home directory `/home/usuario1' ...
   Copying files from `/etc/skel' ...
   New password: 
   Retype new password: 
   passwd: password updated successfully
   Changing the user information for usuario1
   Enter the new value, or press ENTER for the default
	 Full Name []: usuario1
	 Room Number []: 1
	 Work Phone []: 1234
	 Home Phone []: 1234
	 Other []: 1234
   Is the information correct? [Y/n] y

   :~$ sudo adduser usuario2
   Adding user `usuario2' ...
   Adding new group `usuario2' (1002) ...
   Adding new user `usuario2' (1002) with group `usuario2' ...
   Creating home directory `/home/usuario2' ...
   Copying files from `/etc/skel' ...
   New password: 
   Retype new password: 
   passwd: password updated successfully
   Changing the user information for usuario2
   Enter the new value, or press ENTER for the default
   Full Name []: usuario2
	 Room Number []: 1
	 Work Phone []: 1234
	 Home Phone []: 1234
	 Other []: 1234
   Is the information correct? [Y/n] y

   :~$ sudo adduser usuario3
   Adding user `usuario3' ...
   Adding new group `usuario3' (1003) ...
   Adding new user `usuario3' (1003) with group `usuario3' ...
   Creating home directory `/home/usuario3' ...
   Copying files from `/etc/skel' ...
   New password: 
   Retype new password: 
   passwd: password updated successfully
   Changing the user information for usuario3
   Enter the new value, or press ENTER for the default
	 Full Name []: usuario3
	 Room Number []: 1   
	 Work Phone []: 1234
	 Home Phone []: 1234
	 Other []: 1234
   Is the information correct? [Y/n] y


2. Asignación de Contraseñas: Establece una nueva contraseñas para cada usuario creado.

    ```bash
    :~$ sudo passwd usuario1
    New password: 
    Retype new password: 
    passwd: password updated successfully
    
    :~$ sudo passwd usuario2
    New password: 
    Retype new password: 
    passwd: password updated successfully
    
    :~$ sudo passwd usuario3
    New password: 
    Retype new password: 
    passwd: password updated successfully


3. Información de Usuarios: Muestra la información de `usuario1` usando el comando `id`.
  
    ```bash
    :~$ id usuario1
    uid=1001(usuario1) gid=1001(usuario1) groups=1001(usuario1)

4. Eliminación de Usuarios: Elimina `usuario3`, pero conserva su directorio principal.

   ```bash
   :~$ sudo userdel usuario3


### Gestión de Grupos

1. Creación de Grupos: Crea dos grupos llamados `grupo1` y `grupo2`.

   ```bash
   :~$ sudo addgroup grupo1
   Adding group `grupo1' (GID 1003) ...
   Done.
   
   :~$ sudo addgroup grupo2
   Adding group `grupo2' (GID 1004) ...
   Done.


2. Agregar Usuarios a Grupos: Agrega `usuario1` a `grupo1` y `usuario2` a `grupo2`.

   ```bash
   :~$ sudo adduser usuario1 grupo1
   Adding user `usuario1' to group `grupo1' ...
   Adding user usuario1 to group grupo1
   Done.

   :~$ sudo adduser usuario2 grupo2
   Adding user `usuario2' to group `grupo2' ...
   Adding user usuario2 to group grupo2
   Done.

3. Verificar Membresía: Verifica que los usuarios han sido agregados a los grupos utilizando el comando `groups`.

   ```bash
   :~$ groups usuario1
   usuario1 : usuario1 grupo1
   
   :~$ groups usuario2
   usuario2 : usuario2 grupo2

4. Eliminar Grupo: Elimina `grupo2`.

   ```bash
   :~$ sudo delgroup grupo2
   Removing group `grupo2' ...
   Done.

### Gestión de Permisos

1. Creación de Archivos y Directorios:

   - Cambiar de usuario root a usuario1
     ```bash
     :~$ su - usuario1
     Password:

     usuario1@herberth:~$
   
   - Como `usuario1`, crea un archivo llamado `archivo1.txt` en su directorio principal y escribe algo en él.
     ```bash
     usuario1@herberth:~$ pwd
     /home/usuario1

     usuario1@herberth:~$ echo "Este es el contenido del primer archivo del usuario1" > ~/archivo1.txt

     usuario1@herberth:~$ ls
     archivo1.txt

     usuario1@herberth:~$ cat archivo1.txt
     Este es el contenido del primer archivo del usuario1

  - Crea un directorio llamado `directorio1` y dentro de ese directorio, un archivo llamado `archivo2.txt`.
    ```bash
    usuario1@herberth:~$ mkdir ~/directorio1
    
    usuario1@herberth:~$ ls
    archivo1.txt  directorio1
    
    usuario1@herberth:~$ echo "Contenido del archivo2" > ~/directorio1/archivo2.txt
    
    usuario1@herberth:~$ cd directorio1
    usuario1@herberth:~/directorio1$ ls
    archivo2.txt
    
    usuario1@herberth:~/directorio1$ cat archivo2.txt
    Contenido del archivo2

2. Verificar Permisos: Verifica los permisos del archivo y directorio usando el comando `ls -l` y `ls -ld` respectivamente.
   ```bash
   usuario1@herberth:~$ ls -l ~/archivo1.txt
   -rw-rw-r-- 1 usuario1 usuario1 53 ago  9 19:37 /home/usuario1/archivo1.txt
   
   usuario1@herberth:~$ ls -ld ~/directorio1
   drwxrwxr-x 2 usuario1 usuario1 4096 ago  9 19:48 /home/usuario1/directorio1

3. Modificar Permisos usando `chmod` con Modo Numérico: Cambia los permisos del `archivo1.txt` para que sólo `usuario1` pueda leer y escribir (permisos `rw-`), el grupo pueda leer (permisos `r--`) y nadie más pueda hacer nada.
   ```bash
   usuario1@herberth:~$ chmod 640 /home/usuario1/archivo1.txt
   
   usuario1@herberth:~$ ls -l ~/archivo1.txt
   -rw-r----- 1 usuario1 usuario1 53 ago  9 19:37 /home/usuario1/archivo1.txt

4. Modificar Permisos usando `chmod` con Modo Simbólico: Agrega permiso de ejecución al propietario del `archivo2.txt`.
   ```bash
   usuario1@herberth:~$ ls -l ~/directorio1/archivo2.txt
   -rw-rw-r-- 1 usuario1 usuario1 23 ago  9 19:48 /home/usuario1/directorio1/archivo2.txt

   usuario1@herberth:~$ chmod u+x /home/usuario1/directorio1/archivo2.txt
   
   usuario1@herberth:~$ ls -l ~/directorio1/archivo2.txt
   -rwxrw-r-- 1 usuario1 usuario1 23 ago  9 19:48 /home/usuario1/directorio1/archivo2.txt

5. Cambiar el Grupo Propietario: Cambia el grupo propietario de `archivo2.txt` a `grupo1`.
   ```bash
   usuario1@herberth:~$ groups usuario1
   usuario1 : usuario1 grupo1
   
   usuario1@herberth:~$ chown :grupo1 /home/usuario1/directorio1/archivo2.txt
   
   usuario1@herberth:~$ ls -l ~/directorio1/archivo2.txt
   -rwxrw-r-- 1 usuario1 grupo1 23 ago  9 19:48 /home/usuario1/directorio1/archivo2.txt

6. Configurar Permisos de Directorio: Cambia los permisos del `directorio1` para que sólo el propietario pueda entrar (permisos `rwx`), el grupo pueda listar contenidos pero no entrar (permisos `r--`), y otros no puedan hacer nada.
   ```bash
   usuario1@herberth:~$ ls -ld ~/directorio1
   drwxrwxr-x 2 usuario1 usuario1 4096 ago  9 19:48 /home/usuario1/directorio1
   
   usuario1@herberth:~$ chmod 740 /home/usuario1/directorio1
   
   usuario1@herberth:~$ ls -ld ~/directorio1
   drwxr----- 2 usuario1 usuario1 4096 ago  9 19:48 /home/usuario1/directorio1

7. Comprobación de Acceso: Intenta acceder al `archivo1.txt` y `directorio1/archivo2.txt` como `usuario2`. Nota cómo el permiso de directorio afecta el acceso a los archivos dentro de él.
   ```bash
   usuario1@herberth:~$ exit
   logout
   
   :~$ su - usuario2
   Password:
   
   usuario2@herberth:~$ pwd
   /home/usuario2
   
   usuario2@herberth:~$ cd ..
   usuario2@herberth:/home$ ls
   herberth  usuario1  usuario2  usuario3
   
   usuario2@herberth:/home$ cd usuario1
   
   usuario2@herberth:/home/usuario1$ ls
   archivo1.txt  directorio1
   
   usuario2@herberth:/home/usuario1$ cat archivo1.txt
   cat: archivo1.txt: Permission denied

   usuario2@herberth:/home/usuario1$ cd directorio1
   -bash: cd: directorio1: Permission denied

   usuario2@herberth:/home/usuario1$ cat directorio1/archivo2.txt
   cat: directorio1/archivo2.txt: Permission denied

8. Verificación Final: Verifica los permisos y propietario de los archivos y directorio nuevamente con `ls -l` y `ls -ld`.
   ```bash
   usuario2@herberth:/home/usuario1$ ls
   archivo1.txt  directorio1
   
   usuario2@herberth:/home/usuario1$ ls -l archivo1.txt
   -rw-r----- 1 usuario1 usuario1 53 ago  9 19:37 archivo1.txt
   
   usuario2@herberth:/home/usuario1$ ls -ld directorio1
   drwxr----- 2 usuario1 usuario1 4096 ago  9 19:48 directorio1
   
   usuario2@herberth:/home/usuario1$ ls -l directorio1/archivo2.txt
   ls: cannot access 'directorio1/archivo2.txt': Permission denied

### Reflexión
1. ¿Por qué es importante gestionar correctamente los usuarios y permisos en un sistema operativo?
   
   Gestionar correctamente los usuarios y permisos en un sistema operativo, especialmente en sistemas multiusuario, es fundamental por varias razones clave:

   -  Seguridad: Reduciendo el riesgo de filtraciones de datos y ataques maliciosos.
   -  Privacidad: La gestión de usuarios y permisos permite respetar la privacidad de los datos personales.
   -  Separación de Responsabilidades: En entornos de trabajo colaborativo, diferentes usuarios pueden tener diferentes responsabilidades y roles.
   -  Prevención de Errores: Se disminuye la posibilidad de que los usuarios realicen cambios accidentales que podrían causar daños irreparables.
   -  Cumplimiento Legal: Existen regulaciones que requieren el manejo adecuado de datos y la restricción del acceso a información confidencial.
   -  Respaldo y Recuperación

3. ¿Qué otros comandos o técnicas conocen para gestionar permisos en Linux?
   -  chown (Change Owner): Este comando se usa para cambiar el propietario de un archivo o directorio. Por ejemplo:
      ```bash
      sudo chown nuevo_propietario archivo.txt

   -  chgrp (Change Group): Cambia el grupo propietario de un archivo o directorio. Por ejemplo:
      ```bash
      sudo chgrp nuevo_grupo archivo.txt

   -  umask: Define los permisos por defecto que se aplican a los nuevos archivos y directorios creados por un usuario. Puede establecerse en el archivo de inicio (como .bashrc o .profile).

   -  sudo visudo: Abre el archivo sudoers para editar los permisos de sudo. Es importante configurar quiénes pueden ejecutar comandos con sudo y qué comandos específicos pueden ejecutar.

   -  ACL (Access Control Lists): Las listas de control de acceso amplían los permisos tradicionales de Unix. Te permiten establecer permisos más granulares en archivos y directorios. Los comandos para trabajar con ACL incluyen getfacl y setfacl.

   -  chmod en Modo Simbólico Extendido: Además de los modos numéricos (chmod 755, etc.), también puedes usar el modo simbólico extendido para establecer permisos específicos. Por ejemplo:
      ```bash
      chmod u=rwx,g=rx,o= archivo.txt

   -  chmod con Operadores: Puedes usar operadores +, - y = para agregar, quitar o establecer permisos. Por ejemplo:
      ```bash
      chmod g+w archivo.txt

   -  Herramientas de Administración de Usuarios: Además de adduser, hay otros comandos como usermod para modificar usuarios y userdel para eliminarlos.

   -  Herramientas de Administración de Grupos: Además de addgroup, hay otros comandos como groupmod para modificar grupos y groupdel para eliminarlos.

   -  Herramientas Gráficas: Algunos entornos de escritorio como GNOME y KDE ofrecen herramientas gráficas para gestionar usuarios, grupos y permisos.




   


   
