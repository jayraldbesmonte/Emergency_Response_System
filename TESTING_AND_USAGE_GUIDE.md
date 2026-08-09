# Testing & Usage Guide — Emergency Response Platform

Use this guide to test all main features with the seed accounts already created.

**App URL (local):** http://localhost:3000  
**Shared password for all seed accounts:** `Emergency@2026`

> Change passwords after testing if this system will be used for real operations.

---

## 1. Seed accounts (ready to use)

| Role | Email | Municipality / area | What this account is for |
|------|-------|---------------------|--------------------------|
| Super Admin | `emergencyresponse488@gmail.com` | System-wide | Full setup, accounts, sound alerts, verification |
| Municipal Admin | `admin.sanisidro@emergency.local` | San Isidro | Manage municipality users & residents |
| Municipal Admin | `admin.victoria@emergency.local` | Victoria | Same, for Victoria |
| Municipal Admin | `admin.allen@emergency.local` | Allen | Same, for Allen |
| Municipal Admin | `admin.lavezares@emergency.local` | Lavezares | Same, for Lavezares |
| Municipal Admin | `admin.rosario@emergency.local` | Rosario | Same, for Rosario |
| MDRRMO | `mdrrmo.sanisidro@emergency.local` | San Isidro | Monitor incidents, handle escalations |
| MDRRMO | `mdrrmo.victoria@emergency.local` | Victoria | Same |
| MDRRMO | `mdrrmo.allen@emergency.local` | Allen | Same |
| MDRRMO | `mdrrmo.lavezares@emergency.local` | Lavezares | Same |
| MDRRMO | `mdrrmo.rosario@emergency.local` | Rosario | Same |
| Barangay Official | `bo.sanisidro@emergency.local` | San Isidro · Alegria | First response + escalate |
| Barangay Official | `bo.victoria@emergency.local` | Victoria · Acedillo | Same |
| Barangay Official | `bo.allen@emergency.local` | Allen (first barangay) | Same |
| Barangay Official | `bo.lavezares@emergency.local` | Lavezares (first barangay) | Same |
| Barangay Official | `bo.rosario@emergency.local` | Rosario (first barangay) | Same |
| Resident | `resident.sanisidro@emergency.local` | San Isidro · Alegria | Report emergencies |
| Resident | `resident.victoria@emergency.local` | Victoria · Acedillo | Same |
| Resident | `resident.allen@emergency.local` | Allen | Same |
| Resident | `resident.lavezares@emergency.local` | Lavezares | Same |
| Resident | `resident.rosario@emergency.local` | Rosario | Same |

**Recommended test set (San Isidro):**
1. Super Admin — `emergencyresponse488@gmail.com`
2. Municipal Admin — `admin.sanisidro@emergency.local`
3. MDRRMO — `mdrrmo.sanisidro@emergency.local`
4. Barangay Official — `bo.sanisidro@emergency.local`
5. Resident — `resident.sanisidro@emergency.local`

Tip: use **two browsers** (or one normal + one Incognito) so you can stay logged in as two roles at once (example: Resident + Barangay Official).

---

## 2. How to start the app

```bash
cd frontend
npm install
npm start
```

Open http://localhost:3000 and log in with any account above.

---

## 3. Quick role overview (how to use)

### Super Admin
- Create / manage accounts
- Verify residents
- Configure sound alerts
- View map and system-wide data

### Municipal Admin
- Create users in their municipality (MDRRMO, barangay, residents)
- Verify residents in their municipality
- View / manage accounts in their area

### MDRRMO
- Monitor incidents for their municipality
- Receive **escalation** alerts when barangay requests help
- Mark successful / resolved operations
- Use map view

### Barangay Official
- Receive alerts for **new incidents** in their barangay
- Open incident details and respond
- Click **Request Municipal Assistance** to escalate

### Resident
- Report emergencies (only if verified)
- Track own reported incidents
- Seed residents are already **verified**

---

## 4. End-to-end test (most important)

This tests the full alert flow.

### A. New incident → Barangay only

1. Browser A: log in as **Barangay Official**  
   `bo.sanisidro@emergency.local` / `Emergency@2026`  
   Keep dashboard open (sound alerts need the page open).
2. Browser B (Incognito): log in as **Resident**  
   `resident.sanisidro@emergency.local` / `Emergency@2026`
3. As Resident: open **Report Incident** (or dashboard report action).
4. Fill:
   - Type: Fire / Medical / Accident (not “Other” if you want auto-notify)
   - Street / landmark
   - Description
   - Location (use current location or map pin if available)
5. Submit.

**Expected**
- Resident sees the new incident in their list.
- Barangay Official gets notification + sound alert.
- Incident details may auto-open for barangay.
- MDRRMO / Municipal Admin should **not** get the new-incident alert yet.

### B. Escalate → Municipal / MDRRMO

1. Stay logged in as Barangay Official.
2. Open the incident from step A.
3. Use **Request Municipal Assistance** and enter a short reason (example: “Need ambulance support”).
4. Submit.

**Expected**
- MDRRMO (`mdrrmo.sanisidro@emergency.local`) gets escalation notification + sound.
- Municipal Admin (`admin.sanisidro@emergency.local`) also gets notified.
- Escalation sound may differ from the emergency sound.

### C. Resolve

1. Log in as MDRRMO.
2. Open the escalated incident.
3. Mark as resolved / **Successful Operation** (button available for MDRRMO).

**Expected**
- Incident status becomes resolved.
- It no longer appears as active in main lists (archived from active views).

---

## 5. Feature checklist by role

### Super Admin checklist

Login: `emergencyresponse488@gmail.com`

| # | Test | How | Pass if |
|---|------|-----|---------|
| 1 | Login | Sign in with seed password | Dashboard opens |
| 2 | Account Creation | Sidebar → Account Creation / Create User | Can create municipal admin / other roles |
| 3 | Account Management | Sidebar → Account Management | Sees all ~21 users, roles, verification labels |
| 4 | Verify Residents | Sidebar → Verify Residents | Page loads (may be empty if no pending) |
| 5 | Sound Alerts | Sidebar → Sound Alerts | Sees Emergency / Assignment / Escalation configs |
| 6 | Map | Sidebar → Map | Map loads; incidents appear if any exist |
| 7 | Notifications | Sidebar → Notifications | Page opens |

### Municipal Admin checklist (San Isidro)

Login: `admin.sanisidro@emergency.local`

| # | Test | How | Pass if |
|---|------|-----|---------|
| 1 | Scoped access | Open Account Management | Mostly San Isidro users |
| 2 | Create user | Create a resident or barangay official in San Isidro | Account created successfully |
| 3 | Verify residents | Open Verify Residents | Can verify/reject pending residents in municipality |
| 4 | View incidents | Open Incidents | Can see municipality incidents |

### MDRRMO checklist

Login: `mdrrmo.sanisidro@emergency.local`

| # | Test | How | Pass if |
|---|------|-----|---------|
| 1 | Incident list | Open Incidents / Dashboard | Sees San Isidro incidents |
| 2 | Escalation alert | Have barangay escalate an incident (Section 4B) | Sound + notification appear |
| 3 | Resolve | Open incident → Successful Operation | Status becomes resolved |
| 4 | Map | Open Map | Incidents plot correctly |

### Barangay Official checklist

Login: `bo.sanisidro@emergency.local`

| # | Test | How | Pass if |
|---|------|-----|---------|
| 1 | New incident alert | Resident in Alegria reports (Section 4A) | Sound + notification |
| 2 | Open details | Click notification / auto-modal | Sees reporter info, location, type |
| 3 | Escalate | Request Municipal Assistance | Success message; municipal notified |
| 4 | Own barangay only | Check incidents | Mostly Alegria / assigned barangay incidents |

### Resident checklist

Login: `resident.sanisidro@emergency.local`

| # | Test | How | Pass if |
|---|------|-----|---------|
| 1 | Can report | Open report form | Form available (verified) |
| 2 | Submit incident | Report fire/medical with location | Success; appears in own list |
| 3 | Track status | Open own incident | Status updates visible over time |

---

## 6. How to use day-to-day (simple workflow)

1. **Resident reports** an emergency with type, description, and location.
2. **Barangay Official** is alerted first and responds locally.
3. If barangay needs help, they click **Request Municipal Assistance**.
4. **MDRRMO / Municipal Admin** are alerted and coordinate municipal response.
5. When done, MDRRMO marks the incident **resolved / successful**.

That is the intended chain of command in this system.

---

## 7. Creating more accounts (optional)

### From Super Admin
1. Log in as Super Admin.
2. Open **Account Creation**.
3. Choose role (Municipal Admin, MDRRMO, Barangay Official, Resident).
4. Fill email, password, name, municipality / barangay.
5. Create.

### From Municipal Admin
1. Log in as Municipal Admin.
2. Create users **only inside their municipality**.
3. Residents created by admin are typically ready to report (verified by admin creation flow).

### New self-registered residents
1. Register from the public register page (if enabled).
2. Complete **Account Setup** (phone, address, documents).
3. Status becomes **pending**.
4. Admin / MDRRMO verifies them in **Verify Residents**.
5. After **verified**, they can report incidents.

---

## 8. Sound alerts tips

- Sounds play for **Barangay Officials** and **MDRRMO / Municipal Admins**, not residents.
- Keep the dashboard tab open and unmuted.
- First browser visit may require a click anywhere on the page to unlock audio.
- Super Admin can upload custom sounds under **Sound Alerts**:
  - Emergency (new barangay incident)
  - Escalation (request municipal assistance)
  - Assignment (if used)

---

## 9. Troubleshooting

| Problem | What to try |
|---------|-------------|
| Cannot log in | Confirm email exactly, password `Emergency@2026`, and app is on http://localhost:3000 |
| No sound | Click once on the page, unmute tab, confirm you are barangay/MDRRMO/admin |
| Resident cannot report | Check verification status in Account Management; must be `verified` |
| Barangay got no alert | Resident barangay must match official barangay (San Isidro resident ↔ Alegria BO) |
| Municipal got alert on new report | Should not happen; municipal alert only after escalation |
| Blank page / API errors | Check `frontend/.env` has correct Supabase URL + anon key, then restart `npm start` |
| Verify Residents error about columns | Run `supabase/add_resident_verification.sql` in Supabase SQL Editor |

---

## 10. Suggested 15-minute demo script

1. Login Super Admin → show Account Management + Sound Alerts (2 min)
2. Login Resident + Barangay Official (two browsers) → report incident → show barangay alert (5 min)
3. Barangay escalates → show MDRRMO alert (3 min)
4. MDRRMO resolves incident (2 min)
5. Super Admin / Municipal Admin show Verify Residents + Create User (3 min)

---

## Security note

These are **test accounts** with a shared password. Before real deployment:
- Change all passwords
- Remove unused seed accounts if not needed
- Keep `SUPABASE_SERVICE_ROLE_KEY` private (never put it in the frontend)
