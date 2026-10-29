-- ====================================================================
-- SUPABASE STORAGE BUCKETS AND STORAGE POLICIES
-- Strict Isolation and Explicit School Logo Permissions
-- ====================================================================

-- 1. CREATE STORAGE BUCKETS
INSERT INTO storage.buckets (id, name, public)
VALUES 
    ('school-logos', 'school-logos', true),
    ('student-photos', 'student-photos', true),
    ('teacher-photos', 'teacher-photos', true),
    ('attachments', 'attachments', false)
ON CONFLICT (id) DO UPDATE SET public = EXCLUDED.public;

-- NOTE: In Supabase, RLS is ALREADY enabled on storage.objects by default.
-- 'ALTER TABLE storage.objects' is omitted because the table is owned by supabase_storage_admin.

-- 2. DROP EXISTING POLICIES IF THEY EXIST (To ensure repeatable execution)
DROP POLICY IF EXISTS "Public or Authenticated can view school logos" ON storage.objects;
DROP POLICY IF EXISTS "Only School Admin can upload school logo" ON storage.objects;
DROP POLICY IF EXISTS "Only School Admin can update school logo" ON storage.objects;
DROP POLICY IF EXISTS "Only School Admin can delete school logo" ON storage.objects;

DROP POLICY IF EXISTS "School members can view student photos" ON storage.objects;
DROP POLICY IF EXISTS "Admin and authorized staff can upload student photos" ON storage.objects;
DROP POLICY IF EXISTS "Admin and authorized staff can update student photos" ON storage.objects;
DROP POLICY IF EXISTS "Admin can delete student photos" ON storage.objects;

DROP POLICY IF EXISTS "School members can view teacher photos" ON storage.objects;
DROP POLICY IF EXISTS "Admin can upload teacher photos" ON storage.objects;
DROP POLICY IF EXISTS "Admin can update teacher photos" ON storage.objects;
DROP POLICY IF EXISTS "Admin can delete teacher photos" ON storage.objects;

-- 3. POLICIES: SCHOOL LOGOS (STRICT: ONLY SCHOOL ADMIN CAN UPLOAD/MODIFY/DELETE)
CREATE POLICY "Public or Authenticated can view school logos"
ON storage.objects FOR SELECT
USING (bucket_id = 'school-logos');

CREATE POLICY "Only School Admin can upload school logo"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
    bucket_id = 'school-logos' 
    AND public.is_admin()
    AND (storage.foldername(name))[1] = public.auth_school_id()::text
);

CREATE POLICY "Only School Admin can update school logo"
ON storage.objects FOR UPDATE
TO authenticated
USING (
    bucket_id = 'school-logos' 
    AND public.is_admin()
    AND (storage.foldername(name))[1] = public.auth_school_id()::text
)
WITH CHECK (
    bucket_id = 'school-logos' 
    AND public.is_admin()
    AND (storage.foldername(name))[1] = public.auth_school_id()::text
);

CREATE POLICY "Only School Admin can delete school logo"
ON storage.objects FOR DELETE
TO authenticated
USING (
    bucket_id = 'school-logos' 
    AND public.is_admin()
    AND (storage.foldername(name))[1] = public.auth_school_id()::text
);

-- 4. POLICIES: STUDENT PHOTOS
CREATE POLICY "School members can view student photos"
ON storage.objects FOR SELECT
TO authenticated
USING (
    bucket_id = 'student-photos'
    AND (storage.foldername(name))[1] = public.auth_school_id()::text
);

CREATE POLICY "Admin and authorized staff can upload student photos"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
    bucket_id = 'student-photos'
    AND public.is_admin_or_principal()
    AND (storage.foldername(name))[1] = public.auth_school_id()::text
);

CREATE POLICY "Admin and authorized staff can update student photos"
ON storage.objects FOR UPDATE
TO authenticated
USING (
    bucket_id = 'student-photos'
    AND public.is_admin_or_principal()
    AND (storage.foldername(name))[1] = public.auth_school_id()::text
);

CREATE POLICY "Admin can delete student photos"
ON storage.objects FOR DELETE
TO authenticated
USING (
    bucket_id = 'student-photos'
    AND public.is_admin()
    AND (storage.foldername(name))[1] = public.auth_school_id()::text
);

-- 5. POLICIES: TEACHER PHOTOS
CREATE POLICY "School members can view teacher photos"
ON storage.objects FOR SELECT
TO authenticated
USING (
    bucket_id = 'teacher-photos'
    AND (storage.foldername(name))[1] = public.auth_school_id()::text
);

CREATE POLICY "Admin can upload teacher photos"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
    bucket_id = 'teacher-photos'
    AND public.is_admin()
    AND (storage.foldername(name))[1] = public.auth_school_id()::text
);

CREATE POLICY "Admin can update teacher photos"
ON storage.objects FOR UPDATE
TO authenticated
USING (
    bucket_id = 'teacher-photos'
    AND public.is_admin()
    AND (storage.foldername(name))[1] = public.auth_school_id()::text
);

CREATE POLICY "Admin can delete teacher photos"
ON storage.objects FOR DELETE
TO authenticated
USING (
    bucket_id = 'teacher-photos'
    AND public.is_admin()
    AND (storage.foldername(name))[1] = public.auth_school_id()::text
);
