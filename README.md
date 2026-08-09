# Emergency Response Platform

## Project summary

This is a web-based **Emergency Response System** for municipalities in the **1st District of Northern Samar**.

It lets verified residents report emergencies (fire, medical, accident, and more), then routes those reports to the right responders:

1. **Barangay Official** gets the first alert  
2. If needed, barangay **escalates** to municipal level  
3. **MDRRMO / Municipal Admin** coordinates the response  
4. Incidents are tracked until resolved  

The system supports real-time updates, sound alerts, map view, account management, and resident verification.

The cloud database and seed accounts are already prepared. You only need to install dependencies and run the frontend.

> **Note:** The mobile thesis app (**Towards Safety**) is a **separate** product under `Disaster_Response_Mobile`. It uses its **own** Supabase project. Web SQL lives in `supabase/` here; mobile setup is documented in the mobile repo.

---

## Tech stack

| Layer | Technology |
|-------|------------|
| Frontend | React 18, React Router |
| UI / charts | Custom CSS, Recharts |
| Maps | Leaflet, React-Leaflet |
| Backend / Auth / Database | Supabase (PostgreSQL, Auth, Storage, Realtime) |
| Runtime | Node.js + npm |

### Main frontend packages

Installed automatically by `npm install` inside `frontend/`:

- `react`, `react-dom`
- `react-router-dom`
- `@supabase/supabase-js`
- `leaflet`, `react-leaflet`
- `recharts`
- `react-scripts`

---

## Requirements

Before running, install:

1. **Node.js v18 or newer (LTS recommended)** — [https://nodejs.org/](https://nodejs.org/)  
2. **npm** (included with Node.js)

Check versions:

```bash
node -v
npm -v
```

You also need an internet connection (the app connects to Supabase).

---

## Project structure

```
Emergency_Response/
├── setup.bat                    # Windows one-click install (recommended)
├── package.json                 # Root helpers: npm run setup / npm start
├── frontend/                    # React app
│   ├── public/
│   ├── src/
│   ├── .env.example             # Template for environment variables
│   ├── .npmrc                   # Retry settings for flaky networks
│   └── package.json
├── README.md                    # This guide
├── TESTING_AND_USAGE_GUIDE.md   # Accounts, testing steps, how to use
└── Thesis.docx                  # Thesis document
```

---

## How to install and run

### Windows (recommended)

1. Install **Node.js LTS** from [https://nodejs.org/](https://nodejs.org/) and reopen the terminal.
2. Clone the repo, then double-click **`setup.bat`** in the project root  
   (or run `setup.bat` from Command Prompt / PowerShell).
3. Edit `frontend/.env` with your Supabase URL and anon key (created automatically from `.env.example` if missing).
4. Start the app:

```bash
npm start
```

`setup.bat` installs into `frontend/`, retries on flaky networks, and checks that `react-scripts` was installed.

### Manual setup (any OS)

From the **project root**:

```bash
npm run setup
npm start
```

Or from `frontend/`:

```bash
cd frontend
npm install
npm start
```

### Configure environment variables

1. Copy the example env file (if `setup.bat` did not already create it):

```bash
# Windows
copy frontend\.env.example frontend\.env

# Mac / Linux
cp frontend/.env.example frontend/.env
```

2. Open `frontend/.env` and set:

```env
REACT_APP_SUPABASE_URL=https://your-project-ref.supabase.co
REACT_APP_SUPABASE_ANON_KEY=your-anon-key-here
```

Get these from **Supabase Dashboard → Project Settings → API**:

- Project URL → `REACT_APP_SUPABASE_URL`
- anon / public key → `REACT_APP_SUPABASE_ANON_KEY`

> If this handover already includes a working `.env`, you can skip creating a new one.

### Open in browser

Go to: [http://localhost:3000](http://localhost:3000)

The terminal should show that the app compiled successfully.

### Log in

Use the seed accounts in **[TESTING_AND_USAGE_GUIDE.md](TESTING_AND_USAGE_GUIDE.md)**.

Shared password for seed accounts: `Emergency@2026`

Example:

- Super Admin: `emergencyresponse488@gmail.com`
- Resident (San Isidro): `resident.sanisidro@emergency.local`
- Barangay Official: `bo.sanisidro@emergency.local`
- MDRRMO: `mdrrmo.sanisidro@emergency.local`

---

## Useful commands

From the **project root**:

| Command | What it does |
|---------|----------------|
| `setup.bat` | Windows: clean/retry install into `frontend/` |
| `npm run setup` | Install frontend dependencies |
| `npm start` | Run development server |
| `npm run build` | Create production build |

From `frontend/` you can also use `npm install` / `npm start` / `npm run build`.

Stop the server with `Ctrl + C`.

---

## Main features

- Resident incident reporting (after verification)
- Real-time notifications and sound alerts
- Role-based access: Super Admin, Municipal Admin, MDRRMO, Barangay Official, Resident
- Escalation from barangay to municipal / MDRRMO
- Incident tracking until resolved
- Map view for coordinators
- Account creation, account management, resident verification
- Custom alert sounds (Super Admin)

---

## How the system works (simple)

```
Resident reports incident
        ↓
Barangay Official is alerted first
        ↓
Barangay can Request Municipal Assistance
        ↓
MDRRMO / Municipal Admin are alerted
        ↓
Incident is handled and marked resolved
```

For full testing steps, see **[TESTING_AND_USAGE_GUIDE.md](TESTING_AND_USAGE_GUIDE.md)**.

---

## Troubleshooting

| Problem | What to do |
|---------|------------|
| `node` / `npm` not recognized | Install Node.js LTS, then reopen the terminal |
| `'react-scripts' is not recognized` | Install did not finish — run `setup.bat` (Windows) or `npm run setup` from the project root on a stable network |
| `ECONNRESET` during `npm install` | Unstable internet — use a hotspot, then run `setup.bat` / `npm run setup` again (retries are built in) |
| `EPERM` / failed to remove `node_modules` | Close Cursor/VS Code terminals for this folder, end Node.js in Task Manager, delete `frontend\node_modules`, then rerun `setup.bat` |
| Blank page or connection errors | Check `frontend/.env`, then restart with `npm start` |
| Login fails | Use accounts from `TESTING_AND_USAGE_GUIDE.md` |
| Port 3000 already in use | Close the other running app, or use the port React suggests |
| No sound alert | Use Barangay/MDRRMO/Admin account, unmute the tab, and click once on the page |

---

## License

This project is for the use of the client organization as agreed.
