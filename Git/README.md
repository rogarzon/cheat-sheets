# Configuración de Git

### Asignar nombre de usuario y correo para los mensajes de los commits:

1. > git config --global user.name "John Doe"
2. > git config --global user.email johndoe@example.com

### Listar la configuración:

> git config --list

# Submódulos

https://git-scm.com/book/en/v2/Git-Tools-Submodules

## Starting with Submodules

To add a new submodule you use the git submodule add command with the absolute or relative URL of the project you would like to start tracking

> git submodule add https://github.com/chaconinc/DbConnector

## Cloning a Project with Submodules

Here we’ll clone a project with a submodule in it. When you clone such a project, by default you get the directories that contain submodules, but none
of the files within them yet:

> git clone https://github.com/chaconinc/MainProject

The **DbConnector** directory is there, but empty. You must run two commands: **`git submodule init`** to initialize your local configuration file,
and
**`git submodule update`** to fetch all the data from that project and check out the appropriate commit listed in your super project:

1. > git submodule init
2. > git submodule update

Now your **DbConnector** subdirectory is at the exact state it was in when you committed earlier.

There is another way to do this which is a little simpler, however. If you pass **`--recurse-submodules`** to the **`git clone`** command, it will
automatically initialize and update each submodule in the repository, including nested submodules if any of the submodules in the repository have
submodules themselves.

> git clone --recurse-submodules https://github.com/chaconinc/MainProject

If you already cloned the project and forgot **--recurse-submodules**, you can combine the **`git submodule init`** and **`git submodule update`**
steps by running **`git submodule update --init`**. To also initialize, fetch and checkout any nested submodules, you can use the foolproof
**`git submodule update --init --recursive`**.

## Working on a Project with Submodules

Pulling in Upstream Changes from the Submodule Remote
The simplest model of using submodules in a project would be if you were simply consuming a subproject and wanted to get updates from it from time to
time but were not actually modifying anything in your checkout. Let’s walk through a simple example there.

If you want to check for new work in a submodule, you can go into the directory and run **`git fetch`** and **`git merge`** the upstream branch to
update the local code.

1. > git fetch
2. > git merge origin/master

There is an easier way to do this as well, if you prefer to not manually fetch and merge in the subdirectory. If you run
**`git submodule update --remote`**, Git will go into your submodules and fetch and update for you

> git submodule update --remote DbConnector

This command will by default assume that you want to update the checkout to the **master** branch of the submodule repository. You can, however, set
this to something different if you want. For example, if you want to have the DbConnector submodule track that repository’s “stable” branch, you can
set it in either your **.gitmodules** file (so everyone else also tracks it), or just in your local **.git/config** file. Let’s set it in the
**.gitmodules** file:

> git config -f .gitmodules submodule.DbConnector.branch stable

> git submodule update --remote

If you leave off the **-f .gitmodules** it will only make the change for you, but it probably makes more sense to track that information with the
repository so everyone else does as well.

# Ignorar el cambio de modo

Para cuando te dice que no hay cambios en los ficheros, pero aún detecta cambios.

1. > git config --global core.fileMode false
2. > git config core.fileMode false
3. > git stash

# Administrar repositorios remotos

Aprende a trabajar con tus repositorios locales en tu computadora y repositorios remotos alojados en GitHub.
Agregar un repositorio remoto
Para agregar un remoto nuevo, utiliza el comando **git remote add** en la terminal, en el directorio en el cual está almacenado tu repositorio.

El comando **git remote add** toma dos argumentos:

* Un nombre remoto, por ejemplo, **origin**
* Una URL remota, por ejemplo, https://github.com/user/repo.git

> git remote add origin https://github.com/user/repo.git


> _Verificar la nueva URL remota_
>
>> git remote -v

## Solución de problemas: El origen remoto ya existe

Este error significa que trataste de agregar un remoto con un nombre que ya existe en tu repositorio local.

> git remote add origin https://github.com/octocat/Spoon-Knife.git
>> _fatal: remote origin already exists._

Para arreglar esto, puedes:

* Usar un nombre diferente para el nuevo remoto.
* Renombra el repositorio remoto existente antes de que agregues el remoto nuevo. Para obtener más información, consulta la sección "Renombrar un
  repositorio remoto" a continuación.
* Borra el repositorio remoto existente antes de que agregues el remoto nuevo. Para obtener más información, consulta la sección "Eliminar un
  repositorio remoto" a continuación.

## Cambiar la URL del repositorio remoto

El comando **`git remote set-url`** cambia una URL existente de repositorio remoto.
El comando **`git remote set-url`** toma dos argumentos:

* Un nombre de remoto existente. Por ejemplo, origin o upstream son dos de las opciones comunes.
* Una nueva URL para el remoto. Por ejemplo:

> Si estás actualizando para usar HTTPS, tu URL puede verse como:
https://github.com/USERNAME/REPOSITORY.git

> Si estás actualizando para usar SSH, tu URL puede verse como:
> git@github.com:USERNAME/REPOSITORY.git

### Cambiar direcciones URL remotas de SSH a HTTPS

1. Abre la Terminal.
2. Cambiar el directorio de trabajo actual en tu proyecto local.
3. Enumerar tus remotos existentes a fin de obtener el nombre de los remotos que deseas cambiar.

> git remote -v
>> origin git@github.com:USERNAME/REPOSITORY.git (fetch)
>>
>> origin git@github.com:USERNAME/REPOSITORY.git (push)

4. Cambiar tu URL remota de SSH a HTTPS con el comando **`git remote set-url`**.

> git remote set-url origin https://github.com/USERNAME/REPOSITORY.git

5. Verificar que la URL remota ha cambiado.

> git remote -v
>> origin  https://github.com/USERNAME/REPOSITORY.git (fetch)
>>
>> origin  https://github.com/USERNAME/REPOSITORY.git (push)

## Solución de problemas: No existe tal remoto '_[name]_'

Este error significa que el remoto que trataste de cambiar no existe:

> git remote set-url sofake https://github.com/octocat/Spoon-Knife
>> fatal: No such remote 'sofake'

Comprueba que escribiste correctamente el nombre del remoto.

## Renombrar un repositorio remoto

Utiliza el comando **`git remote rename`** para renombrar un remoto existente.

El comando **`git remote rename`** toma dos argumentos:

1. Un nombre de remoto existente, por ejemplo, **origen**
2. Un nombre nuevo para el remoto, por ejemplo, **destino**

Estos ejemplos asumen que estás clonando con HTTPS, lo cual se recomienda.

> git remote -v
>> origin  https://github.com/OWNER/REPOSITORY.git (fetch)
>>
>> origin  https://github.com/OWNER/REPOSITORY.git (push)

> git remote rename _origin_ _destination_
>> Cambia el nombre del remoto de 'origen' a 'destino'

> git remote -v
>> Verifica el nombre nuevo del remoto
>>
>> destination  https://github.com/OWNER/REPOSITORY.git (fetch)
>>
>> destination  https://github.com/OWNER/REPOSITORY.git (push)

## Solución de problemas: No se pudo renombrar la sección de configuración 'remote._[old name]_' a 'remote._[new name]_'

Este error significa que el nombre remoto antiguo que tecleaste ya no existe.

* Puedes verificar los remotos que existen actualmente con el comando **git remote -v**:

> git remote -v
>> Ver remotos existentes
>>
>> origin  https://github.com/OWNER/REPOSITORY.git (fetch)
>>
>> origin  https://github.com/OWNER/REPOSITORY.git (push)

## Solución de problemas: Ya existe el Remoto _[new name]_

Este error significa que el nombre del remoto que quieres utilizar ya existe. Para resolver esto, puedes ya sea utilizar un nombre diferente para el
remoto o renombrar el remoto original.

## Eliminar un repositorio remoto

Utiliza el comando **`git remote rm`** para eliminar una URL remota de tu repositorio.

El comando **`git remote rm`** toma un argumento:

* El nombre de un remoto, por ejemplo destination (destino)

> Nota:
>> **El eliminar la URL remota de tu repositorio únicamente desenlazará los repositorios remoto y local. Esto no borra el repositorio remoto.**

> git remote -v
>
>> Ver los remotos actuales
>>
>> origin  https://github.com/OWNER/REPOSITORY.git (fetch)
>>
>> origin  https://github.com/OWNER/REPOSITORY.git (push)
>>
>> destination  https://github.com/FORKER/REPOSITORY.git (fetch)
>>
>> destination  https://github.com/FORKER/REPOSITORY.git (push)

> git remote rm _destination_

> git remote -v
>
>> Verificar que se haya ido
>>
>> origin  https://github.com/OWNER/REPOSITORY.git (fetch)
>>
>> origin  https://github.com/OWNER/REPOSITORY.git (push)

# Connect with SSH

## Checking for existing SSH keys

1. Abra Git Bash
2. Enter **`ls -al ~/.ssh`** to see if existing SSH keys are present.
3. Check the directory listing to see if you already have a public SSH key. By default, the filenames of supported public keys for GitHub are one of
   the following.

* id_rsa.pub
* id_ecdsa.pub
* id_ed25519.pub

## Generating a new SSH key and adding it to the ssh-agent

1. Abra Git Bash.
2. > `ssh-keygen -t ed25519 -C "your_email@example.com"`
   >> Note: If you are using a legacy system that doesn't support the Ed25519 algorithm, use:
   >>
   >> `ssh-keygen -t rsa -b 4096 -C "your_email@example.com"`

>
> Esto crea una nueva clave SSH, utilizando el correo electrónico proporcionado como etiqueta.

## Agregar su clave SSH al ssh-agent

1. Asegúrese de que el agente ssh se esté ejecutando.

   > `eval "$(ssh-agent -s)"`
   >> _start the ssh-agent in the background_
   >>
   >> Agent pid 59566

2. Agregue su clave privada SSH al ssh-agent.
   > `ssh-add ~/.ssh/id_ed25519`

3. Agregue la clave SSH a su cuenta en GitHub

## Adding a new SSH key to your GitHub account

1. Copy the SSH public key to your clipboard.
   > `clip < ~/.ssh/id_ed25519.pub`
   >
   >> _Copies the contents of the id_ed25519.pub file to your clipboard_
   >>
   >>Tip: If clip isn't working, you can locate the hidden .ssh folder, open the file in your favorite text editor, and copy it to your clipboard.

2. En la esquina superior derecha de cualquier página, haga clic en la foto del perfil y, luego, en Settings (Configuración).
3. In the "Access" section of the sidebar, click SSH and GPG keys.
4. Click New SSH key or Add SSH key.
5. In the "Title" field, add a descriptive label for the new key. For example, if you're using a personal laptop, you might call this key "Personal
   laptop".
6. Select the type of key, either authentication or signing. For more information about commit signing, see "About commit signature verification."
7. Paste your key into the "Key" field.
8. Click Add SSH key.

## Testing your SSH connection

1. Abra Git Bash.
2. Enter the following:
   > `ssh -T git@github.com`
   >>
   >> Attempts to ssh to GitHub
   >>
   >>You may see a warning like this:
   >>> The authenticity of host 'github.com (IP ADDRESS)' can't be established.
   >>>
   >>> RSA key fingerprint is SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.
   >>>
   >>> Are you sure you want to continue connecting (yes/no)?

3. Verify that the fingerprint in the message you see matches GitHub's public key fingerprint. If it does, then type yes:
   > Hi USERNAME! You've successfully authenticated, but GitHub does not provide shell access.

4. Verify that the resulting message contains your username. If you receive a "permission denied" message, see "Error: Permission denied (publickey)".

## Trabajar con contraseñas de clave SSH

Puedes cambiar la contraseña por una llave privada existente sin volver a generar el par de claves al escribir el siguiente comando:

> `ssh-keygen -p -f ~/.ssh/id_ed25519`
>>
>> Enter old passphrase: _[Type old passphrase]_
>>
>> Key has comment 'your_email@example.com'
>> 
>> Enter new passphrase (empty for no passphrase): _[Type new passphrase]_
>>
>> Enter same passphrase again: _[Repeat the new passphrase]_
>>
>> Your identification has been saved with the new passphrase.

Si tu clave ya tiene una contraseña, se te pedirá que la ingreses antes de que puedas cambiar a una nueva contraseña.