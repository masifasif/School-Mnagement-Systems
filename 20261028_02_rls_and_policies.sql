-- ====================================================================
-- ROW LEVEL SECURITY (RLS) & ACCESS CONTROL POLICIES
-- Multi-School Data Isolation & Role-Based Permissions
-- ====================================================================

-- 1. SECURITY DEFINER HELPER FUNCTIONS
CREATE OR REPLACE FUNCTION public.auth_school_id()
RETURNS UUID
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
    SELECT school_id FROM public.user_profiles WHERE id = auth.uid();
$$;

CREATE OR REPLACE FUNCTION public.auth_role()
RETURNS TEXT
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
    SELECT role FROM public.user_profiles WHERE id = auth.uid();
$$;

CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
    SELECT EXISTS (
        SELECT 1 FROM public.user_profiles
        WHERE id = auth.uid() AND role = 'admin'
    );
$$;

CREATE OR REPLACE FUNCTION public.is_admin_or_principal()
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
    SELECT EXISTS (
        SELECT 1 FROM public.user_profiles
        WHERE id = auth.uid() AND role IN ('admin', 'principal')
    );
$$;

CREATE OR REPLACE FUNCTION public.can_manage_financials()
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
    SELECT EXISTS (
        SELECT 1 FROM public.user_profiles
        WHERE id = auth.uid() AND role IN ('admin', 'accountant')
    );
$$;

-- 2. ENABLE RLS ON ALL TABLES
ALTER TABLE public.schools ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.academic_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.classes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sections ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.subjects ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.teachers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.class_subjects ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.students ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.student_attendance ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.staff_attendance ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.fee_types ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.student_fees ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.fee_payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.expenses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.salaries ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.examinations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.exam_subjects ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.exam_results ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.timetables ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.homework ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.leave_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.announcements ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;

-- 3. POLICIES: SCHOOLS
CREATE POLICY "Users can view their own school"
ON public.schools FOR SELECT
TO authenticated
USING (id = public.auth_school_id());

CREATE POLICY "Only admin can update school profile and logo"
ON public.schools FOR UPDATE
TO authenticated
USING (id = public.auth_school_id() AND public.is_admin())
WITH CHECK (id = public.auth_school_id() AND public.is_admin());

-- 4. POLICIES: USER PROFILES
CREATE POLICY "Users can view profiles in their school"
ON public.user_profiles FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id());

CREATE POLICY "Users can update their own profile"
ON public.user_profiles FOR UPDATE
TO authenticated
USING (id = auth.uid())
WITH CHECK (id = auth.uid());

CREATE POLICY "Admin can insert and manage user profiles in their school"
ON public.user_profiles FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND public.is_admin())
WITH CHECK (school_id = public.auth_school_id() AND public.is_admin());

-- 5. POLICIES: CORE ACADEMIC TABLES (Sessions, Classes, Sections, Subjects)
CREATE POLICY "School members can read academic sessions"
ON public.academic_sessions FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id());

CREATE POLICY "Admin/Principal can manage academic sessions"
ON public.academic_sessions FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND public.is_admin_or_principal())
WITH CHECK (school_id = public.auth_school_id() AND public.is_admin_or_principal());

CREATE POLICY "School members can read classes"
ON public.classes FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id());

CREATE POLICY "Admin/Principal can manage classes"
ON public.classes FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND public.is_admin_or_principal())
WITH CHECK (school_id = public.auth_school_id() AND public.is_admin_or_principal());

CREATE POLICY "School members can read sections"
ON public.sections FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id());

CREATE POLICY "Admin/Principal can manage sections"
ON public.sections FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND public.is_admin_or_principal())
WITH CHECK (school_id = public.auth_school_id() AND public.is_admin_or_principal());

CREATE POLICY "School members can read subjects"
ON public.subjects FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id());

CREATE POLICY "Admin/Principal can manage subjects"
ON public.subjects FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND public.is_admin_or_principal())
WITH CHECK (school_id = public.auth_school_id() AND public.is_admin_or_principal());

CREATE POLICY "School members can view class subjects"
ON public.class_subjects FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id());

CREATE POLICY "Admin/Principal can manage class subjects"
ON public.class_subjects FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND public.is_admin_or_principal())
WITH CHECK (school_id = public.auth_school_id() AND public.is_admin_or_principal());

-- 6. POLICIES: TEACHERS & STAFF
CREATE POLICY "School members can view teachers list"
ON public.teachers FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id());

CREATE POLICY "Admin/Principal can manage teachers"
ON public.teachers FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND public.is_admin_or_principal())
WITH CHECK (school_id = public.auth_school_id() AND public.is_admin_or_principal());

-- 7. POLICIES: STUDENTS
CREATE POLICY "School members can view students"
ON public.students FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id());

CREATE POLICY "Admin/Principal can manage students"
ON public.students FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND public.is_admin_or_principal())
WITH CHECK (school_id = public.auth_school_id() AND public.is_admin_or_principal());

-- 8. POLICIES: ATTENDANCE
CREATE POLICY "School members can read student attendance"
ON public.student_attendance FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id());

CREATE POLICY "Authorized staff can insert/update student attendance"
ON public.student_attendance FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND (public.is_admin_or_principal() OR public.auth_role() = 'teacher'))
WITH CHECK (school_id = public.auth_school_id() AND (public.is_admin_or_principal() OR public.auth_role() = 'teacher'));

CREATE POLICY "School members can read staff attendance"
ON public.staff_attendance FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id());

CREATE POLICY "Admin/Principal can manage staff attendance"
ON public.staff_attendance FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND public.is_admin_or_principal())
WITH CHECK (school_id = public.auth_school_id() AND public.is_admin_or_principal());

-- 9. POLICIES: FINANCIALS (Fees, Payments, Expenses, Salaries)
CREATE POLICY "Staff can view fee types"
ON public.fee_types FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id());

CREATE POLICY "Financial roles can manage fee types"
ON public.fee_types FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND public.can_manage_financials())
WITH CHECK (school_id = public.auth_school_id() AND public.can_manage_financials());

CREATE POLICY "Authorized roles can view student fees"
ON public.student_fees FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id() AND (public.can_manage_financials() OR public.is_admin_or_principal()));

CREATE POLICY "Financial roles can manage student fees"
ON public.student_fees FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND public.can_manage_financials())
WITH CHECK (school_id = public.auth_school_id() AND public.can_manage_financials());

CREATE POLICY "Authorized roles can view fee payments"
ON public.fee_payments FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id() AND (public.can_manage_financials() OR public.is_admin_or_principal()));

CREATE POLICY "Financial roles can record fee payments"
ON public.fee_payments FOR INSERT
TO authenticated
WITH CHECK (school_id = public.auth_school_id() AND public.can_manage_financials());

CREATE POLICY "Admin can mark reversals on fee payments"
ON public.fee_payments FOR UPDATE
TO authenticated
USING (school_id = public.auth_school_id() AND public.is_admin())
WITH CHECK (school_id = public.auth_school_id() AND public.is_admin());

CREATE POLICY "Financial roles can view and manage expenses"
ON public.expenses FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND public.can_manage_financials())
WITH CHECK (school_id = public.auth_school_id() AND public.can_manage_financials());

CREATE POLICY "Admin and Accountant can view and manage salaries"
ON public.salaries FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND public.can_manage_financials())
WITH CHECK (school_id = public.auth_school_id() AND public.can_manage_financials());

-- 10. POLICIES: EXAMINATIONS & RESULTS
CREATE POLICY "School members can view exams"
ON public.examinations FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id());

CREATE POLICY "Admin/Principal can manage exams"
ON public.examinations FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND public.is_admin_or_principal())
WITH CHECK (school_id = public.auth_school_id() AND public.is_admin_or_principal());

CREATE POLICY "School members can view exam subjects"
ON public.exam_subjects FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id());

CREATE POLICY "Admin/Principal can manage exam subjects"
ON public.exam_subjects FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND public.is_admin_or_principal())
WITH CHECK (school_id = public.auth_school_id() AND public.is_admin_or_principal());

CREATE POLICY "School members can view exam results"
ON public.exam_results FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id());

CREATE POLICY "Teachers and Admin can manage exam marks"
ON public.exam_results FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND (public.is_admin_or_principal() OR public.auth_role() = 'teacher'))
WITH CHECK (school_id = public.auth_school_id() AND (public.is_admin_or_principal() OR public.auth_role() = 'teacher'));

-- 11. POLICIES: TIMETABLE, HOMEWORK, LEAVE, ANNOUNCEMENTS
CREATE POLICY "School members can view timetables"
ON public.timetables FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id());

CREATE POLICY "Admin/Principal can manage timetables"
ON public.timetables FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND public.is_admin_or_principal())
WITH CHECK (school_id = public.auth_school_id() AND public.is_admin_or_principal());

CREATE POLICY "School members can view homework"
ON public.homework FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id());

CREATE POLICY "Teachers and Admin can manage homework"
ON public.homework FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND (public.is_admin_or_principal() OR public.auth_role() = 'teacher'))
WITH CHECK (school_id = public.auth_school_id() AND (public.is_admin_or_principal() OR public.auth_role() = 'teacher'));

CREATE POLICY "Users can view relevant leave requests"
ON public.leave_requests FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id());

CREATE POLICY "Users can submit leave requests"
ON public.leave_requests FOR INSERT
TO authenticated
WITH CHECK (school_id = public.auth_school_id());

CREATE POLICY "Admin/Principal can review leave requests"
ON public.leave_requests FOR UPDATE
TO authenticated
USING (school_id = public.auth_school_id() AND public.is_admin_or_principal())
WITH CHECK (school_id = public.auth_school_id() AND public.is_admin_or_principal());

CREATE POLICY "School members can view announcements"
ON public.announcements FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id() AND is_active = true);

CREATE POLICY "Admin can manage announcements"
ON public.announcements FOR ALL
TO authenticated
USING (school_id = public.auth_school_id() AND public.is_admin())
WITH CHECK (school_id = public.auth_school_id() AND public.is_admin());

CREATE POLICY "Admin can view audit logs"
ON public.audit_logs FOR SELECT
TO authenticated
USING (school_id = public.auth_school_id() AND public.is_admin());
