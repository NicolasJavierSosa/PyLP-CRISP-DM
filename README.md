# Sistema Experto para Pronóstico de Rendimiento Académico

Luego de realizar el modelado en RapidMiner, se obtuvo un Árbol de Decisión capaz de predecir si un estudiante aprobará (“Y”) o no (“N”) en función de tres variables relevantes:

- **Horas estudiadas (hours_studied)**
- **Asistencia (%) (attendance_percent)**
- **Puntaje previo (previous_scores)**

Estas reglas surgen directamente del Árbol de Decisión generado en la fase de modelado y fueron traducidas a Prolog para su utilización dentro de un programa web.

---

## 🚀 Tecnologías utilizadas

- **Prolog (SWI-Prolog)** – Motor logico
- **HTML / CSS** – Interfaz de usuario

### 🌐 Librerías utilizadas en Prolog para el servidor web

Para permitir que el sistema experto funcione desde una interfaz web, se incorporaron tres librerías oficiales de **SWI-Prolog** pertenecientes al framework HTTP. Cada una cumple un rol específico dentro del servidor:

---

##### **1. `library(http/thread_httpd)` – Servidor HTTP**
Esta librería permite **crear y ejecutar un servidor web** directamente desde Prolog.  
Gracias a ella, el sistema puede atender solicitudes provenientes del navegador (como peticiones GET o POST) y responderlas dinámicamente.

- Habilita el uso de múltiples threads para manejar varias solicitudes a la vez.
- Permite iniciar el servidor con `http_server/2`.

👉 *En pocas palabras:* **enciende el servidor que hace posible acceder al sistema experto desde la web.**

---

##### **2. `library(http/http_dispatch)` – Enrutamiento de URLs**
Esta librería se utiliza para **definir rutas o endpoints** del servidor.  
Permite indicar qué predicado Prolog debe ejecutarse cuando un usuario accede a una URL específica.

- Define handlers mediante `http_handler/3`.
- Organiza las funciones del servidor igual que un framework web clásico.

👉 *En pocas palabras:* **asocia URLs con funciones del sistema experto.**

---

##### **3. `library(http/http_json)` – Manejo de JSON**
Esta librería permite **enviar y recibir datos en formato JSON**, lo que es fundamental para que el frontend se comunique con el motor lógico.

- Facilita la construcción de respuestas JSON con `reply_json/1`.
- Permite leer datos desde el body de una petición mediante `json_read_dict/2`.

👉 *En pocas palabras:* **permite que el servidor responda al navegador con datos estructurados (JSON).**

---

#### 🔎 Resumen general

| Librería | Función principal |
|---------|-------------------|
| `thread_httpd` | Crear el servidor web en Prolog |
| `http_dispatch` | Definir endpoints y manejar URLs |
| `http_json` | Enviar/recibir datos JSON entre frontend y backend |

Estas tres librerías trabajan juntas para integrar el **motor lógico en Prolog** con una **interfaz web**, permitiendo que el árbol de decisión generado en RapidMiner pueda consultarse desde un navegador.

---

## 📘 Descripción del funcionamiento

El árbol de decisión original fue generado a partir de un dataset académico y posteriormente traducido a reglas lógicas.  
El sistema recibe como entrada tres parámetros numéricos y devuelve:

- **"Y"** → rendimiento satisfactorio  
- **"N"** → rendimiento no satisfactorio  

---

## 👥 Integrantes del grupo

- **Amarilla, Aldo Wilfredo**
- **Eitner, Bianca Michelle**
- **Sosa, Nicolás Javier**
