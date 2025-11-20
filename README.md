# Sistema Experto para Predicción de Rendimiento Académico

Luego de realizar el modelado en RapidMiner, se obtuvo un Árbol de Decisión capaz de predecir si un estudiante aprobará (“Y”) o no (“N”) en función de tres variables relevantes:

- **Horas estudiadas (hours_studied)**
- **Asistencia (%) (attendance_percent)**
- **Puntaje previo (previous_scores)**

Estas reglas surgen directamente del Árbol de Decisión generado en la fase de modelado y fueron traducidas a Prolog para su utilización dentro de un programa web.

---

## 🚀 Tecnologías utilizadas

- **Prolog (SWI-Prolog)** – Motor del sistema experto  
- **HTML / CSS** – Interfaz de usuario  
- **JavaScript** – Comunicación con el backend Prolog  

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
