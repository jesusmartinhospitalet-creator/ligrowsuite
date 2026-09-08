-- ============================================================
-- Ligrow Tasks — Schema MySQL
-- Ejecuta este archivo una sola vez para inicializar la BD.
-- Alternativa: usa /setup.html en la app para el setup guiado.
-- ============================================================

CREATE DATABASE IF NOT EXISTS ligrowsuite
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE ligrowsuite;

CREATE TABLE IF NOT EXISTS app_config (
  `key`   VARCHAR(100) PRIMARY KEY,
  `value` TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS clients (
  clientId     VARCHAR(36)  NOT NULL PRIMARY KEY,
  clientName   VARCHAR(255) NOT NULL,
  clientCode   VARCHAR(10),
  bannerTitle  TEXT, bannerInfo TEXT,
  kickoffDate  DATE, concept VARCHAR(255), summary TEXT,
  keyLinksJson MEDIUMTEXT, extJson MEDIUMTEXT,
  updatedAt DATETIME, createdAt DATETIME,
  INDEX idx_clientName (clientName)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS tasks (
  taskId          VARCHAR(36)  NOT NULL PRIMARY KEY,
  taskCode        VARCHAR(30), clientId VARCHAR(36),
  taskName        VARCHAR(500), owner VARCHAR(100),
  status          VARCHAR(50), priority VARCHAR(50),
  taskType        VARCHAR(50), taskMonth VARCHAR(7),
  monthStatus     VARCHAR(50), templateId VARCHAR(36),
  dueDate DATE, startDate DATE, endDate DATE,
  `group` VARCHAR(100), description MEDIUMTEXT,
  attachmentsJson MEDIUMTEXT, updatedAt DATETIME, createdAt DATETIME,
  INDEX idx_clientId(clientId), INDEX idx_taskMonth(taskMonth), INDEX idx_status(status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS comments (
  commentId VARCHAR(36) NOT NULL PRIMARY KEY,
  taskId VARCHAR(36), author VARCHAR(100),
  `text` MEDIUMTEXT, createdAt DATETIME,
  INDEX idx_taskId(taskId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS templates (
  templateId    VARCHAR(36) NOT NULL PRIMARY KEY,
  clientId      VARCHAR(36), templateName VARCHAR(255),
  owner         VARCHAR(100), priority VARCHAR(50),
  statusDefault VARCHAR(50), taskType VARCHAR(50),
  description   MEDIUMTEXT, dueDay TINYINT,
  isActive      TINYINT(1) DEFAULT 1,
  updatedAt DATETIME, createdAt DATETIME,
  INDEX idx_clientId(clientId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS client_months (
  monthId     VARCHAR(36) NOT NULL PRIMARY KEY,
  clientId    VARCHAR(36), taskMonth VARCHAR(7),
  monthStatus VARCHAR(50), generatedAt DATETIME,
  closedAt    DATETIME, updatedAt DATETIME, createdAt DATETIME,
  INDEX idx_clientId(clientId),
  UNIQUE KEY idx_client_month(clientId, taskMonth)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
