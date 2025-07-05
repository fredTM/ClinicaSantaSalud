CREATE DATABASE IF NOT EXISTS clinica_santa_salud;
USE clinica_santa_salud;

CREATE TABLE pacientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(15) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    direccion TEXT,
    telefono VARCHAR(15),
    correo VARCHAR(100) UNIQUE
);

CREATE TABLE especialidades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE medicos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    especialidad_id INT,
    correo VARCHAR(100),
    telefono VARCHAR(15),
    FOREIGN KEY (especialidad_id) REFERENCES especialidades(id)
);

CREATE TABLE consultorios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_consultorio VARCHAR(10) NOT NULL UNIQUE,
    piso INT NOT NULL
);

CREATE TABLE citas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id INT NOT NULL,
    medico_id INT NOT NULL,
    consultorio_id INT,
    fecha DATETIME NOT NULL,
    motivo TEXT,
    estado ENUM('pendiente', 'completada', 'cancelada') DEFAULT 'pendiente',
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id),
    FOREIGN KEY (medico_id) REFERENCES medicos(id),
    FOREIGN KEY (consultorio_id) REFERENCES consultorios(id)
);

CREATE TABLE historial_medico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id INT NOT NULL,
    cita_id INT,
    diagnostico TEXT NOT NULL,
    tratamiento TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id),
    FOREIGN KEY (cita_id) REFERENCES citas(id)
);

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    rol ENUM('admin', 'medico', 'recepcionista') NOT NULL
);

INSERT INTO especialidades (nombre) VALUES 
('Pediatría'), ('Cardiología'), ('Dermatología'), ('Medicina General');

INSERT INTO medicos (nombre, apellido, especialidad_id, correo, telefono) VALUES
('Ana', 'Soto', 1, 'ana.soto@clinica.com', '987654321'),
('Luis', 'Ramirez', 2, 'luis.ramirez@clinica.com', '911223344'),
('Carmen', 'Torres', 3, 'carmen.torres@clinica.com', '955667788');

INSERT INTO consultorios (numero_consultorio, piso) VALUES
('101', 1), ('202', 2), ('303', 3);

INSERT INTO pacientes (nombre, apellido, dni, fecha_nacimiento, direccion, telefono, correo) VALUES
('Juan', 'Pérez', '12345678', '1980-03-15', 'Av. Siempre Viva 123', '123456789', 'juan.perez@email.com'),
('Laura', 'Torres', '87654321', '1986-01-30', 'Calle Falsa 456', '999999999', 'laura.torres@email.com');

INSERT INTO citas (paciente_id, medico_id, consultorio_id, fecha, motivo, estado) VALUES
(1, 1, 1, '2025-06-18 10:00:00', 'Control pediátrico', 'pendiente'),
(2, 2, 2, '2025-06-19 09:30:00', 'Chequeo cardíaco', 'pendiente');

INSERT INTO historial_medico (paciente_id, cita_id, diagnostico, tratamiento) VALUES
(1, 1, 'Buen estado general', 'Ningún tratamiento necesario'),
(2, 2, 'Hipertensión leve', 'Dieta baja en sodio y monitoreo diario');
