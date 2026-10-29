# Bright Future School — School Management System

> **A professional, secure, and responsive School Management Application built with Flutter, Dart, and Supabase.**  
> Designed Android-first with built-in architecture ready for future Flutter Web deployment.

---

## 1. Project Overview & Visual Foundation

The **Bright Future School App** was crafted to replicate the design language and screen composition of the master UI reference specification (**`Bright Future School App UI Showcase.png`**), featuring:
- **School Branding & Aesthetics**: Deep blue header waves, clean modern sans-serif typography, rounded card surfaces, and color-coded status badges.
- **Role-Based Workflows**: Tailored views and backend authorization for **School Admin**, **Principal**, **Accountant**, and **Teacher**.
- **Interactive Multi-Module Operations**: Complete workflows for Students, Teachers, Classes & Sections, Attendance, Fee Receipts, Examinations, Timetable, Homework, Leave Requests, Announcements, and Reports.
- **Offline / Demo Resilience**: Works immediately out-of-the-box with high-fidelity sample data matching the showcase image, while seamlessly connecting to live Supabase PostgreSQL and Storage when credentials are provided.

---

## 2. Technology Stack

- **Framework**: Flutter 3.47+ (Channel stable)
- **Programming Language**: Dart 3.13+
- **Backend & Database**: Supabase (PostgreSQL with Row Level Security)
- **Authentication**: Supabase Auth (Email & Password, secure persistent sessions)
- **Storage**: Supabase Storage (`school-logos`, `student-photos`, `teacher-photos`, `attachments`)
- **State Management**: Provider (`ChangeNotifierProvider`, `MultiProvider`)
- **Typography & Icons**: Google Fonts (`Poppins`), Cupertino & Material Icons
- **Document Exporting**: `pdf` & `printing` (for official receipts and report cards), `csv` (for data exports)
- **Image Handling**: `image_picker` (validated image picking and preview)

---

## 3. Project Directory Structure

```text
basic_school_mgmt/
├── android/                             # Android native configuration & Gradle scripts
├── assets/                              # App assets and icons
├── lib/
│   ├── app.dart                         # MultiProvider setup and MaterialApp theme builder
│   ├── main.dart                        # Flutter entrypoint with Supabase initialization
│   ├── core/
│   │   ├── config/                      # Supabase & environment configuration
│   │   ├── constants/                   # Colors, strings, dimensions
│   │   ├── routing/                     # Route definitions (AppRoutes) and route generator
│   │   ├── theme/                       # Light and Dark theme palettes (matching showcase)
│   │   ├── utils/                       # Date/currency formatters, validators, grade calculator
│   │   └── widgets/                     # Reusable UI components (MetricCard, SideDrawer, StatusBadge, etc.)
│   ├── features/
│   │   ├── announcements/               # Notice board and institutional updates
│   │   ├── attendance/                  # Student and staff daily attendance recording
│   │   ├── auth/                        # Login, Forgot Password, and session handling
│   │   ├── classes/                     # Class and section management
│   │   ├── dashboard/                   # Main dashboard with 2x2 metric grid & financial summaries
│   │   ├── exams/                       # Examination results and report card generator
│   │   ├── expenses/                    # School expense tracking and categorization
│   │   ├── fees/                        # Fee structure, student fees, payments, and receipt generation
│   │   ├── homework/                    # Assignments with recent/overdue filtering
│   │   ├── leave/                       # Leave request submission and approval workflows
│   │   ├── reports/                     # Institutional reporting with PDF and CSV export
│   │   ├── salary/                      # Staff payroll management with role protection
│   │   ├── school_profile/              # School details & strict logo upload management
│   │   ├── settings/                    # Dark mode toggle, role switcher, and backend status
│   │   ├── splash/                      # Deep blue splash screen matching reference design
│   │   ├── students/                    # Student list, profile tabs (Details, Guardian, Academic), add/edit
│   │   ├── teachers/                    # Teacher list, faculty profile tabs, add/edit
│   │   └── timetable/                   # Daily timeline schedule (periods, breaks, faculty)
│   ├── models/                          # Strongly-typed data models with JSON serialization
│   ├── providers/                       # State management providers for each operational domain
│   └── services/
│       ├── export/                      # PDF printing and CSV export implementations
│       ├── mock/                        # In-memory mock data service mirroring the UI showcase
│       ├── storage/                     # Image picker and Supabase storage upload service
│       └── supabase/                    # Supabase client singleton & auth service
├── supabase/
│   └── migrations/                      # PostgreSQL migrations, RLS policies, and seed data
│       ├── 20261028_01_initial_schema.sql
│       ├── 20261028_02_rls_and_policies.sql
│       ├── 20261028_03_storage_buckets.sql
│       └── 20261028_04_seed_data.sql
├── test/
│   └── widget_test.dart                 # Automated test suite (calculations, security, smoke tests)
├── .env.example                         # Environment configuration template
├── pubspec.yaml                         # Project dependencies and asset declarations
└── README.md                            # Comprehensive developer and administrator manual
```

---

## 4. Prerequisites (Windows 11)

To run or build the application on Windows 11, verify you have the following installed:
1. **Flutter SDK**: Version 3.47.x or later ([Flutter Install Guide](https://docs.flutter.dev/get-started/install/windows)).
2. **Dart SDK**: Bundled automatically with Flutter (Dart 3.13.x+).
3. **Java Development Kit (JDK)**: OpenJDK 17 LTS or later.
4. **Android SDK & Build Tools**: Android SDK Platform 34 or 36 with Build-Tools installed.
5. **Git**: Installed and added to system `PATH`.

---

## 5. Getting Started & Running the Application

### Step 1: Clone or Navigate to the Workspace
```powershell
cd "R:\basic school mgmt"
```

### Step 2: Install Flutter Dependencies
```powershell
flutter pub get
```

### Step 3: Run the Application
You can launch the application on any connected Android device, emulator, Windows desktop, or Chrome:

```powershell
# Run on an Android device or emulator
flutter run

# Run on Chrome for instant web preview
flutter run -d chrome

# Run as native Windows application
flutter run -d windows
```

---

## 6. Supabase Backend Setup & Database Migrations

When connecting the application to your live Supabase cloud project:

### Step 1: Create a Supabase Project
1. Go to [https://supabase.com](https://supabase.com) and create an account.
2. Click **New Project**, choose an organization, name your project (e.g., `bright-future-school`), and set a secure database password.
3. Select a region close to your primary school location.

### Step 2: Apply Database Migrations
In your Supabase project dashboard, navigate to the **SQL Editor** tab and execute the SQL migration files located in `supabase/migrations/` in order:

1. **`20261028_01_initial_schema.sql`**: Creates tables (`schools`, `user_profiles`, `academic_sessions`, `classes`, `sections`, `subjects`, `teachers`, `students`, `student_attendance`, `fee_types`, `student_fees`, `fee_payments`, `expenses`, `salaries`, `examinations`, `exam_results`, `timetables`, `homework`, `leave_requests`, `announcements`, `audit_logs`).
2. **`20261028_02_rls_and_policies.sql`**: Enables Row Level Security (RLS) across all tables with helper functions (`auth_school_id()`, `is_admin()`, `can_manage_financials()`) to enforce multi-school isolation and role permissions.
3. **`20261028_03_storage_buckets.sql`**: Provisions storage buckets (`school-logos`, `student-photos`, `teacher-photos`, `attachments`) and enforces that **only School Admin can upload, update, or remove the school logo**.
4. **`20261028_04_seed_data.sql`**: Populates the database with initial demo records matching the UI reference showcase.

### Step 3: Configure Storage Buckets (if done manually)
Ensure the following buckets are created in **Storage**:
- `school-logos` (Public read, Admin-only write)
- `student-photos` (Public read, Staff-only write)
- `teacher-photos` (Public read, Admin-only write)
- `attachments` (Private read/write scoped to school members)

### Step 4: Configure Flutter Client Credentials
Pass your Supabase URL and publishable/anon key when running the app using `--dart-define`, or set them in `lib/core/config/supabase_config.dart`:

```powershell
flutter run --dart-define=SUPABASE_URL="https://your-project.supabase.co" --dart-define=SUPABASE_ANON_KEY="your-anon-key"
```

> **CRITICAL SECURITY WARNING:**  
> **NEVER paste your Supabase `service_role` key into Flutter client source code!** The `service_role` key bypasses all Row Level Security. Only use the public/anon key on client applications.

---

## 7. Role-Based Permissions & Security Architecture

The application strictly implements access control both in the **Flutter UI** and on the **Supabase PostgreSQL backend (RLS)**:

| Role | Students & Classes | Attendance | Fees & Payments | Salaries | Logo Management | Leave Review |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **School Admin** | Full CRUD | Full Access | Full Access | Full Access | **Allowed** | Full Access |
| **Principal** | Full CRUD | Full Access | View Only | View / Approve | **Blocked** | Full Access |
| **Accountant** | View Only | View Only | Full Access | Full Access | **Blocked** | View Only |
| **Teacher** | Assigned Only | Mark / Edit | **Blocked** | **Blocked** | **Blocked** | Submit Only |

### Strict School Logo Protection
- **Flutter UI**: Logo management controls are conditionally hidden or locked with a clear indicator for non-admin users.
- **Backend RLS**: The database policy `Only admin can update school profile and logo` and storage policy `Only School Admin can upload school logo` prevent API-level manipulation even if client code is modified.

---

## 8. Automated Testing

The project includes unit and widget tests covering calculations, financial logic, role security, and widget smoke tests.

Run the automated test suite:
```powershell
flutter test
```

**Test Coverage Highlights:**
- **Grade Calculations**: Verifies correct letter grade assignment (A+, A, B+, B, C, D, F) and passing thresholds.
- **Financial Balance Arithmetic**: Tests partial payment subtraction, discount handling, and outstanding balance accuracy.
- **Input Validation**: Verifies email formatting, required fields, and password length checks.
- **Role Permission Enforcement**: Confirms that non-admin roles (Teachers, Accountants) are strictly rejected from managing the school logo.
- **UI Smoke Test**: Verifies the splash screen and primary school branding load without crashes.

---

## 9. Building the Android APK

### Debug APK Build
The debug APK compiles without code-signing requirements:
```powershell
flutter build apk --debug
```
- **Output Artifact**: `build\app\outputs\flutter-apk\app-debug.apk`

### Release APK Build
To build an optimized release APK:
```powershell
flutter build apk --release
```
- **Output Artifact**: `build\app\outputs\flutter-apk\app-release.apk`

---

## 10. Troubleshooting Common Issues

### Issue 1: Multi-Drive Kotlin Compilation on Windows (`different roots: C:\... and R:\...`)
- **Cause**: Windows Gradle Kotlin daemon bug when project is on drive `R:` and Pub cache is on drive `C:`.
- **Solution**: The fix is already applied in `android/gradle.properties`:
  ```properties
  kotlin.incremental=false
  kotlin.incremental.useClasspathSnapshot=false
  ```

### Issue 2: Offline / Demo Mode Notice
- **Cause**: Supabase credentials not yet supplied in `lib/core/config/supabase_config.dart`.
- **Solution**: The app intentionally runs smoothly in demo mode using `MockDataService`. Provide your credentials when ready to connect to your live database.

---

## 11. Future Flutter Web Support

The codebase is engineered to support Flutter Web with zero backend changes:
- All database operations use cross-platform Supabase SDK APIs.
- Responsive layout wrappers prevent fixed-width overflow on desktop viewports.
- File exports use browser-compatible download mechanisms in `printing` and `csv`.
- To preview on Web: `flutter run -d chrome`.
