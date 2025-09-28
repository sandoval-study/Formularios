CREATE DATABASE proyeccion_social;
USE proyeccion_social;

-- Usuarios del sistema (docentes, coordinadores, directores)
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    rol ENUM('docente', 'coordinador', 'director') NOT NULL,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Proyectos de proyección social
CREATE TABLE proyectos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT,
    docente_id INT,
    estado ENUM('en_proceso', 'aprobado', 'rechazado') DEFAULT 'en_proceso',
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (docente_id) REFERENCES usuarios(id)
);

-- Formularios (cada proyecto tiene hasta 5 formularios)
CREATE TABLE formularios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    proyecto_id INT,
    numero_formulario INT CHECK(numero_formulario BETWEEN 1 AND 5),
    archivo VARCHAR(255) NOT NULL, -- ruta del archivo subido
    estado ENUM('pendiente', 'aprobado', 'rechazado', 'en_revision') DEFAULT 'pendiente',
    comentarios TEXT,
    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (proyecto_id) REFERENCES proyectos(id)
);

-- Historial de acciones (trazabilidad)
CREATE TABLE historial (
    id INT AUTO_INCREMENT PRIMARY KEY,
    formulario_id INT,
    usuario_id INT,
    accion ENUM('subido', 'revisado', 'aprobado', 'rechazado'),
    comentario TEXT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (formulario_id) REFERENCES formularios(id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);
