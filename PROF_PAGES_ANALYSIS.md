# Professor Module Frontend Analysis

## Overview
The professor (prof) module contains 6 pages for managing courses, students, grades, tickets, and announcements. The module uses Vue 3 Composition API with custom composables for API interactions.

---

## 1. Pages in prof/pages

### Pages List (6 total)
1. **AnnoncesPage.vue** - Announcement publishing interface
2. **CoursesList.vue** - Course management and chapter tracking
3. **Dashboard.vue** - Overview dashboard with stats and recent tickets
4. **GradeManagement.vue** - Student grade entry and management (TD/TP + Exams)
5. **StudentsList.vue** - Student list with search, filtering, and management
6. **Tickets.vue** - Support ticket system for professor-student communication

---

## 2. Composables Used by Prof Pages

### 2.1 useModules.js
**Location:** `src/composables/useModules.js`

**Functions Used by Prof Pages:**
- `professeurModulesProgress()` - Fetches professor's courses and progress
- `updateCourseProgress(module_id, payload)` - Updates course chapter progress

**Used by:**
- CoursesList.vue (onMounted hook)
- Dashboard.vue (onMounted hook)

---

### 2.2 useTickets.js
**Location:** `src/composables/useTickets.js`

**Functions Used by Prof Pages:**
- `listTicketsForProf()` - Gets all tickets for professor's courses
- `getTicket(id)` - Fetches full ticket details
- `addTicketComment(id, payload)` - Adds response/comment to ticket
- `updateTicket(id, payload)` - Updates ticket status
- `ticketsStats()` - Gets ticket statistics

**Used by:**
- Dashboard.vue (onMounted hook)
- Tickets.vue (onMounted hook + interactions)

---

### 2.3 useStudents.js
**Location:** `src/composables/useStudents.js`

**Functions Used by Prof Pages:**
- `useStudents()` - Returns reactive students list and CRUD operations
  - `students` - Reactive ref with student data
  - `addStudent(newStudent)` - Adds new student locally
  - `deleteStudent(id)` - Removes student locally
  - `fetchStudents()` - Fetches students from API (optional)

**Used by:**
- GradeManagement.vue (student dropdown options)
- StudentsList.vue (main display and management)

---

## 3. Data Currently Displayed by Prof Pages

### AnnoncesPage.vue
- **Component Used:** `Annonce` component
- **Props:** `allowReactions=false`, `canPublish=true`
- **Data Type:** Announcement/announcement publishing interface

### CoursesList.vue
- **Courses List:**
  - Course name, code, schedule
  - Number of enrolled students
  - Chapter progress tracking (% complete)
  - Individual chapters with completion status
  - Course color coding
  - Add/delete course functionality

- **Form Fields:**
  - Course name, code, schedule
  - Chapters (title, date, completion flag)

### Dashboard.vue
- **Statistics Cards (4):**
  - Total tickets
  - Tickets "en attente" (pending)
  - Tickets "en cours" (in progress)
  - Tickets "acceptée" (resolved)

- **Recent Tickets Section:**
  - Ticket ID, student name, course
  - Subject, priority level, status
  - Time posted

- **Course Statistics (Right Sidebar):**
  - Total enrolled students (105)
  - Multi-ring progress chart showing enrollment metrics
  - Per-course stats: name, student count, trend (up/down)

### GradeManagement.vue
- **Statistics Cards (4):**
  - Total grades entered
  - Grades validating (≥ 10)
  - Overall average grade
  - Total count

- **Grades Table:**
  - Student name
  - Course name
  - TD/TP grade (out of 20)
  - Exam grade (out of 20)
  - Date recorded

- **Add Grade Form:**
  - Student selector
  - Course selector
  - TD/TP grade input
  - Exam grade input

### StudentsList.vue
- **Student Table:**
  - Student name with avatar
  - Email address
  - Phone number
  - Enrolled course
  - Average grade (out of 20) with color coding
  - Active status
  - Delete action button

- **Add Student Form:**
  - Full name
  - Email
  - Phone number
  - Course assignment

- **Filters:**
  - Search by name or email
  - Filter by course (All/Mathématiques/Physique/Informatique)

### Tickets.vue
- **Statistics Row (4 cards):**
  - Total tickets count
  - Pending count
  - In-progress count
  - Resolved count

- **Ticket Cards Grid:**
  - Ticket ID
  - Title
  - Status (Ouvert/En cours/Résolu)
  - Sender name + role
  - Course
  - Response count
  - Creation date
  - Resolve button

- **Ticket Detail Modal:**
  - Full ticket title
  - Sender, course, opened date, status
  - Complete message thread
  - Response history with timestamps
  - Response composition textarea
  - Send/close buttons

---

## 4. API Calls by Prof Pages

### API Base URL
- **Base:** `http://localhost:4000` (via `VITE_API_URL` environment variable)
- **Auth:** Bearer token in `Authorization` header
- **Content-Type:** `application/json`

### 4.1 CoursesList.vue

#### On Mount
```
GET /api/auth/professeur/modules/progress
Purpose: Load professor's courses, chapters, and progress
Expected Response: Array of course objects with:
  - module (intitule_cours, code_cours, id)
  - students_count
  - avancement_pourcentage
  - date_debut_enseigner, date_fin_enseigner
  - assignment_id
  - chapters array
```

#### On Chapter Toggle
```
PUT /api/auth/professeur/modules/{module_id}/progress
Purpose: Update course chapter completion status
Payload: { progress: number (0-100) }
```

---

### 4.2 Dashboard.vue

#### On Mount (3 API calls)

**1. Get Professor's Module Progress**
```
GET /api/auth/professeur/modules/progress
Purpose: Load courses for course statistics display
```

**2. Get Tickets for Professor**
```
GET /api/auth/professeur/tickets/modules
Purpose: Get recent tickets related to professor's courses
Expected Response: Array of ticket objects with:
  - id, titre, expediteur, cours, date
  - status, priority, subject
  - time, student
```

**3. Get Ticket Statistics**
```
GET /api/auth/tickets/stats
Purpose: Get aggregated ticket stats
Expected Response: Object with:
  - total (total tickets)
  - en_attente (pending count)
  - en_cours (in-progress count)
  - acceptee (resolved count)
```

---

### 4.3 GradeManagement.vue

**Current Implementation:** Local state only
- Uses hardcoded sample grades array
- `useStudents()` composable for student options
- No API calls implemented yet
- Add/update grade operations are local only

---

### 4.4 StudentsList.vue

**Current Implementation:** Hybrid approach
- Uses `useStudents()` composable
- Local CRUD operations: add, delete
- `fetchStudents()` optional - calls API if needed:

```
GET /api/auth/admin/utilisateurs
Purpose: Fetch all users/students
Response mapping: Maps user objects to student shape:
  - id, name, email, phone, course
  - average (initially 0)
  - status: 'actif'
```

---

### 4.5 Tickets.vue

#### On Mount
```
GET /api/auth/professeur/tickets/modules
Purpose: Load all tickets for professor
```

#### On Ticket Open
```
GET /api/auth/tickets/{id}
Purpose: Fetch full ticket details including complete message history
```

#### On Response Submit
**Step 1:** Add comment
```
POST /api/auth/tickets/{id}/comments
Payload: { commentaire: { contenu_commentaires: string, interne_commentaires: boolean } }
Purpose: Add professor's response to ticket
```

**Step 2:** Reload ticket
```
GET /api/auth/tickets/{id}
Purpose: Get updated ticket with new comment
```

**Step 3:** Update ticket status (if changing from "En cours")
```
PUT /api/auth/tickets/{id}
Payload: { ticket: { statut_ticket: 'en_attente' } }
Purpose: Change ticket status back to pending
```

#### On Resolve
**Current:** Local state update only (no API call)
```
ticket.status = 'Résolu'
Note: Should call updateTicket API but currently doesn't
```

---

### 4.6 AnnoncesPage.vue

**Current Implementation:** No direct API calls
- Uses `Annonce` component which likely handles announcements
- Component receives `allowReactions=false` and `canPublish=true`

---

## 5. API Integration Summary

### Authentication
- All API calls include Bearer token from localStorage
- Token key: `'token'`
- Header: `Authorization: Bearer {token}`

### Endpoints Used

| Endpoint | Method | Page | Purpose |
|----------|--------|------|---------|
| `/api/auth/professeur/modules/progress` | GET | CoursesList, Dashboard | Load courses |
| `/api/auth/professeur/modules/{id}/progress` | PUT | CoursesList | Update course progress |
| `/api/auth/professeur/tickets/modules` | GET | Dashboard, Tickets | List tickets |
| `/api/auth/tickets/{id}` | GET | Tickets | Get full ticket |
| `/api/auth/tickets/{id}` | PUT | Tickets | Update ticket status |
| `/api/auth/tickets/{id}/comments` | POST | Tickets | Add comment |
| `/api/auth/tickets/stats` | GET | Dashboard | Get stats |
| `/api/auth/admin/utilisateurs` | GET | StudentsList | List users |

### Missing/Stub Implementations
- **GradeManagement:** No backend integration (local state only)
- **StudentsList:** Add/delete operations are local only
- **Tickets resolve:** Status update not persisted to backend
- **AnnoncesPage:** Uses component-level implementation

---

## 6. Data Flow Architecture

```
Prof Page Component
    ↓
Uses Composable (useModules, useTickets, useStudents)
    ↓
Composable calls api.request()
    ↓
api.request() wraps fetch() with auth headers
    ↓
Backend API Response → Error handling → Store in reactive ref
```

### Caching
- **useTickets:** Implements cache for `listTickets()` (can force refresh)
- **useModules:** No caching (fresh load each time)
- **useStudents:** Static array + optional API fetch

---

## 7. Error Handling Pattern

All API calls use try-catch with console.debug logging:
```javascript
try {
  const res = await apiFunction()
  if (res && res.data) {
    // Process successful response
  }
} catch (e) {
  console.debug('Function failed', e)
  // Use fallback data or show error message
}
```

---

## Key Observations

1. **Inconsistent State Management:** Some pages use local state, others fetch from API
2. **Partial Implementation:** Grade management and student CRUD are local-only
3. **Ticket System:** Most complete with full API integration
4. **Caching:** Minimal caching strategy except for tickets
5. **Error Recovery:** Graceful fallbacks with console debugging
6. **Component Reusability:** Heavy use of CustomSelect component for dropdowns
7. **Responsive Design:** All pages use Tailwind CSS grid/flex utilities
8. **French Language:** All UI labels and placeholders in French
