# No, no se llama

#### Tecnologias

El proyecto es desarrollado utilizando Ruby on Rails, con una base de datos de MySQL. Ademas se utilizo JSON-Server para simular el funcionamiento de LAUDUS

#### Ejecucion de aplicacion web

Para ejecutar correctamente la aplicacion web, se deben ejecutar los siguientes comandos dentro de la carpeta "Proyecto Ingenieria":

1. bundle install
2. rake db:create
3. rake db:migrate
4. rails s

Ademas, para poder simular LAUDUS, se debe ejecutar el siguiente comando en una linea de comandos adicional dentro de la carpeta "Proyecto Ingenieria/JSON Server", al mismo tiempo que se tiene el servidor del proyecto funcionando:

1. json-server --watch db.json --port 3004

#### Sign-up (localhost:3000/signup)

* El correo debe ser unico
* La contrasena debe tener como minimo 6 caracteres
* El correo debe tener el formato 'correo@dominio.com'

Al realizar el sign-up se ingresa automaticamente a la platafroma con el usuario recien creado y se muestra el perfil del usuario, donde puede modificar su nombre, apellido, como tambien puede ver su cargo.

#### Login (localhost:3000/login)

Ingresar con los datos de un usuario creado. NOTA: Ninguna otra vista creada hasta el momento es accesible si no se encuentra logueado.

#### Materiales nuevos (localhost:3000/new_material)

Se pueden ingresar nuevos materiales ingresando todos los datos solicitados.

#### Lista de materiales (localhost:3000/list_materials)

Se pueden ver todos los materiales que se encuentran registrados en la base de datos.

#### Home (localhost:3000/home)

Muestra las opciones creadas hasta el momento, dependiendo del cargo que tenga el usuario.
