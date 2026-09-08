# Ligrow Tasks

Aplicación de gestión de proyectos y tareas para agencias, migrada de Google Apps Script a **Node.js + MySQL**, lista para desplegar en Hostinger.

---

## Stack

| Capa | Tecnología |
|------|----------|
| Backend | Node.js 18+ · Express |
| Base de datos | MySQL 8 |
| Frontend | HTML/CSS/JS vanilla (sin frameworks) |
| IA | Anthropic Claude API |
| Hosting | Hostinger (Node.js app) |

---

## Estructura de archivos

```
ligrowsuite/
├── server.js              # Punto de entrada Express
├── package.json
├── .env.example           # Variables de entorno (copiar a .env)
├── setup.sql              # Schema SQL (alternativa a /setup.html)
├── src/
│   ├── db.js              # Pool de conexiones MySQL
│   ├── session.js         # Gestión de sesiones en memoria
│   └── handlers.js        # Toda la lógica de negocio
└── public/
    ├── index.html         # App principal (SPA)
    └── setup.html         # Asistente de configuración inicial
```

---

## Instalación local

```bash
# 1. Clonar e instalar dependencias
git clone https://github.com/jesusmartinhospitalet-creator/ligrowsuite.git
cd ligrowsuite
npm install

# 2. Configurar variables de entorno
cp .env.example .env
# Editar .env con tus credenciales de MySQL y la API key de Anthropic

# 3. Arrancar en desarrollo
npm run dev

# 4. Primera vez: abrir http://localhost:3000/setup.html
#    → Paso 1: Crear tablas en BD
#    → Paso 2: Configurar contraseña de acceso
```

---

## Despliegue en Hostinger

1. Crear una base de datos MySQL desde el panel de Hostinger.
2. Subir los archivos al servidor (Git o FTP).
3. En el panel Node.js de Hostinger, establecer el archivo de entrada como `server.js`.
4. Configurar las variables de entorno en el panel:
   - `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`
   - `ANTHROPIC_API_KEY`
   - `PORT` (Hostinger lo asigna automáticamente)
5. Ejecutar `npm install` desde la terminal SSH.
6. Iniciar la aplicación y abrir `tudominio.com/setup.html` para el setup inicial.

---

## Funcionalidades

- **Clientes** — CRUD completo con código, concepto, presupuesto y links clave
- **Tareas** — puntuales y mensuales, con prioridad, responsable, estado y fechas
- **Plantillas mensuales** — generación automática de tareas recurrentes por cliente
- **Gestión de meses** — apertura, cierre y reapertura de períodos mensuales
- **Vistas** — Lista · Tablero Kanban (drag & drop) · Diagrama de Gantt
- **Comentarios** — hilo de comentarios por tarea
- **Asistente IA (LIGA)** — chat con Claude para crear/actualizar tareas por lenguaje natural

---

## Variables de entorno

| Variable | Descripción |
|----------|------------|
| `DB_HOST` | Host MySQL (ej: `localhost`) |
| `DB_PORT` | Puerto MySQL (por defecto `3306`) |
| `DB_USER` | Usuario de la base de datos |
| `DB_PASSWORD` | Contraseña de la base de datos |
| `DB_NAME` | Nombre de la base de datos (ej: `ligrowsuite`) |
| `ANTHROPIC_API_KEY` | API key de Anthropic para el asistente IA |
| `PORT` | Puerto del servidor (por defecto `3000`) |
