'use strict';

require('dotenv').config();

const express  = require('express');
const path     = require('path');
const handlers = require('./src/handlers');

const app = express();
app.use(express.json({ limit: '10mb' }));
app.use(express.static(path.join(__dirname, 'public')));

// ── RPC endpoint (mirrors all google.script.run calls) ──────────────────────
const EXPOSED = [
  'authLogin',
  'listClients', 'addClient', 'updateClient', 'deleteClient',
  'listTasks', 'listAllTasks', 'upsertTask', 'deleteTask',
  'listTemplates', 'upsertTemplate', 'deleteTemplate',
  'listClientMonths', 'generateNextMonthForClient',
  'generateSpecificMonthForClient', 'closeClientMonth', 'reopenClientMonth',
  'listComments', 'addComment',
  'callClaudeServerSide', 'generateTextAI'
];

app.post('/api/rpc', async (req, res) => {
  const { method, args = [] } = req.body;
  if (!EXPOSED.includes(method)) {
    return res.status(404).json({ error: 'Método no encontrado: ' + method });
  }
  try {
    const result = await handlers[method](...args);
    res.json(result);
  } catch (e) {
    console.error('[RPC]', method, e.message);
    res.status(400).json({ error: e.message });
  }
});

app.post('/api/setup', async (_req, res) => {
  try {
    res.json(await handlers.setup());
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

app.post('/api/init-password', async (req, res) => {
  const { password } = req.body || {};
  if (!password) return res.status(400).json({ error: 'Se requiere contraseña.' });
  try {
    res.json(await handlers.setPassword(password));
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

app.get('*', (_req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Ligrow Tasks → http://localhost:${PORT}`);
  console.log(`  Setup     → http://localhost:${PORT}/setup.html`);
});
