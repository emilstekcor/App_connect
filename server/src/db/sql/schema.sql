-- users
CREATE TABLE IF NOT EXISTS users (
  id TEXT PRIMARY KEY,
  handle TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  created_at TEXT DEFAULT (datetime('now'))
);

-- sessions
CREATE TABLE IF NOT EXISTS sessions (
  id TEXT PRIMARY KEY,
  user_id TEXT REFERENCES users(id),
  refresh_token_hash TEXT NOT NULL,
  ua_fingerprint TEXT,
  expires_at TEXT,
  FOREIGN KEY(user_id) REFERENCES users(id)
);

-- invites
CREATE TABLE IF NOT EXISTS invites (
  id TEXT PRIMARY KEY,
  code_hash TEXT NOT NULL,
  issued_to TEXT,
  uses_remaining INTEGER,
  expires_at TEXT,
  created_at TEXT DEFAULT (datetime('now'))
);

-- rooms
CREATE TABLE IF NOT EXISTS rooms (
  id TEXT PRIMARY KEY,
  owner_id TEXT REFERENCES users(id),
  name TEXT,
  created_at TEXT DEFAULT (datetime('now'))
);

-- room_members
CREATE TABLE IF NOT EXISTS room_members (
  room_id TEXT REFERENCES rooms(id),
  user_id TEXT REFERENCES users(id),
  role TEXT CHECK(role IN ('owner','mod','member')),
  UNIQUE(room_id, user_id)
);

-- events
CREATE TABLE IF NOT EXISTS events (
  id TEXT PRIMARY KEY,
  room_id TEXT REFERENCES rooms(id),
  type TEXT CHECK(type IN ('message','post','media','system')),
  author_id TEXT REFERENCES users(id),
  body_md TEXT,
  body_text TEXT,
  meta_json TEXT,
  version INTEGER DEFAULT 1,
  created_at TEXT DEFAULT (datetime('now')),
  deleted_at TEXT
);

-- approvals
CREATE TABLE IF NOT EXISTS approvals (
  event_id TEXT PRIMARY KEY REFERENCES events(id),
  state TEXT CHECK(state IN ('pending','approved','rejected')),
  decided_by TEXT REFERENCES users(id),
  decided_at TEXT,
  reason TEXT,
  version INTEGER DEFAULT 1
);

-- user_timelines
CREATE TABLE IF NOT EXISTS user_timelines (
  user_id TEXT REFERENCES users(id),
  event_id TEXT REFERENCES events(id),
  room_id TEXT REFERENCES rooms(id),
  visibility TEXT DEFAULT 'visible',
  flagged_mine_only INTEGER DEFAULT 0,
  PRIMARY KEY(user_id, event_id)
);

-- media
CREATE TABLE IF NOT EXISTS media (
  id TEXT PRIMARY KEY,
  path TEXT NOT NULL,
  sha256 TEXT,
  mime TEXT,
  size INTEGER,
  uploaded_by TEXT REFERENCES users(id),
  created_at TEXT DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS idx_events_room_created ON events(room_id, created_at);
CREATE INDEX IF NOT EXISTS idx_approvals_state ON approvals(state);
CREATE INDEX IF NOT EXISTS idx_timelines_user_room ON user_timelines(user_id, room_id);
