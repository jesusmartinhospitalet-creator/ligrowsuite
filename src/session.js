'use strict';

const { randomUUID } = require('crypto');

const sessions = new Map();
const TTL = 8 * 60 * 60 * 1000; // 8 horas

function create() {
  const id = randomUUID();
  sessions.set(id, { expiresAt: Date.now() + TTL });
  return id;
}

function validate(id) {
  if (!id) return false;
  const s = sessions.get(id);
  if (!s) return false;
  if (Date.now() > s.expiresAt) {
    sessions.delete(id);
    return false;
  }
  return true;
}

// Limpiar sesiones expiradas cada hora
setInterval(() => {
  const now = Date.now();
  for (const [id, s] of sessions) {
    if (now > s.expiresAt) sessions.delete(id);
  }
}, 60 * 60 * 1000).unref();

module.exports = { create, validate };
