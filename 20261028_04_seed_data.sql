-- ====================================================================
-- SEED DATA MATCHING UI SHOWCASE SPECIFICATION
-- ====================================================================

DO $$
DECLARE
    v_school_id UUID := '11111111-1111-1111-1111-111111111111';
    v_admin_id UUID := '22222222-2222-2222-2222-222222222222';
    v_session_id UUID := '33333333-3333-3333-3333-333333333333';
    v_class6_id UUID := '44444444-4444-4444-4444-444444444446';
    v_class7_id UUID := '44444444-4444-4444-4444-444444444447';
    v_class8_id UUID := '44444444-4444-4444-4444-444444444448';
    v_sec_a_id UUID := '55555555-5555-5555-5555-555555555551';
    v_sec_b_id UUID := '55555555-5555-5555-5555-555555555552';
    v_math_id UUID := '66666666-6666-6666-6666-666666666661';
    v_sci_id UUID := '66666666-6666-6666-6666-666666666662';
    v_eng_id UUID := '66666666-6666-6666-6666-666666666663';
    v_urdu_id UUID := '66666666-6666-6666-6666-666666666664';
    v_ss_id UUID := '66666666-6666-6666-6666-666666666665';
    v_tea_ahmed_id UUID := '77777777-7777-7777-7777-777777777771';
    v_tea_sarah_id UUID := '77777777-7777-7777-7777-777777777772';
    v_stu_ayesha_id UUID := '88888888-8888-8888-8888-888888888881';
    v_stu_ali_id UUID := '88888888-8888-8888-8888-888888888882';
    v_stu_sara_id UUID := '88888888-8888-8888-8888-888888888883';
    v_stu_usman_id UUID := '88888888-8888-8888-8888-888888888884';
    v_stu_hira_id UUID := '88888888-8888-8888-8888-888888888885';
    v_fee_tuition_id UUID := '99999999-9999-9999-9999-999999999991';
    v_fee_admission_id UUID := '99999999-9999-9999-9999-999999999992';
    v_fee_monthly_id UUID := '99999999-9999-9999-9999-999999999993';
    v_fee_exam_id UUID := '99999999-9999-9999-9999-999999999994';
    v_fee_lib_id UUID := '99999999-9999-9999-9999-999999999995';
    v_exam_id UUID := 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';
BEGIN
    -- 1. Insert School
    INSERT INTO public.schools (id, name, code, address, phone, email, currency_symbol)
    VALUES (v_school_id, 'Bright Future School', 'BFS01', 'Main Campus, Canal Road, Lahore', '+92 42 111 222 333', 'info@brightfuture.edu.pk', 'Rs.')
    ON CONFLICT (id) DO NOTHING;

    -- 2. Insert Session
    INSERT INTO public.academic_sessions (id, school_id, name, start_date, end_date, is_active)
    VALUES (v_session_id, v_school_id, '2024-25', '2024-04-01', '2025-03-31', true)
    ON CONFLICT DO NOTHING;

    -- 3. Insert Classes
    INSERT INTO public.classes (id, school_id, name, numeric_order, badge_color) VALUES
    ('44444444-4444-4444-4444-444444444441', v_school_id, 'Class 1', 1, 'orange'),
    ('44444444-4444-4444-4444-444444444442', v_school_id, 'Class 2', 2, 'green'),
    ('44444444-4444-4444-4444-444444444443', v_school_id, 'Class 3', 3, 'red'),
    ('44444444-4444-4444-4444-444444444444', v_school_id, 'Class 4', 4, 'blue'),
    ('44444444-4444-4444-4444-444444444445', v_school_id, 'Class 5', 5, 'cyan'),
    (v_class6_id, v_school_id, 'Class 6', 6, 'purple'),
    (v_class7_id, v_school_id, 'Class 7', 7, 'indigo'),
    (v_class8_id, v_school_id, 'Class 8', 8, 'teal')
    ON CONFLICT DO NOTHING;

    -- 4. Insert Sections
    INSERT INTO public.sections (id, school_id, class_id, name, room_number) VALUES
    (v_sec_a_id, v_school_id, v_class8_id, 'A', 'Room 101'),
    (v_sec_b_id, v_school_id, v_class8_id, 'B', 'Room 102'),
    ('55555555-5555-5555-5555-555555555553', v_school_id, v_class6_id, 'A', 'Room 201')
    ON CONFLICT DO NOTHING;

    -- 5. Insert Subjects
    INSERT INTO public.subjects (id, school_id, name, code) VALUES
    (v_math_id, v_school_id, 'Mathematics', 'MATH101'),
    (v_sci_id, v_school_id, 'Science', 'SCI101'),
    (v_eng_id, v_school_id, 'English', 'ENG101'),
    (v_urdu_id, v_school_id, 'Urdu', 'URD101'),
    (v_ss_id, v_school_id, 'Social Studies', 'SS101')
    ON CONFLICT DO NOTHING;

    -- 6. Insert Teachers
    INSERT INTO public.teachers (id, school_id, employee_id, full_name, gender, phone, email, qualification, joining_date, primary_subject, salary_amount) VALUES
    (v_tea_ahmed_id, v_school_id, 'EMP002', 'Ahmed Raza', 'Male', '0300 9876543', 'ahmed.raza@school.com', 'M.Sc. (Science)', '2020-01-15', 'Science', 65000.00),
    (v_tea_sarah_id, v_school_id, 'EMP001', 'Sarah Malik', 'Female', '0301 2345678', 'sarah.malik@school.com', 'M.Sc. (Math)', '2019-08-20', 'Mathematics', 70000.00),
    ('77777777-7777-7777-7777-777777777773', v_school_id, 'EMP003', 'Fatima Noor', 'Female', '0302 3456789', 'fatima.noor@school.com', 'M.A. (English)', '2021-03-10', 'English', 60000.00),
    ('77777777-7777-7777-7777-777777777774', v_school_id, 'EMP004', 'Zeeshan Ali', 'Male', '0303 4567890', 'zeeshan.ali@school.com', 'M.A. (Urdu)', '2022-01-05', 'Urdu', 58000.00),
    ('77777777-7777-7777-7777-777777777775', v_school_id, 'EMP005', 'Ayesha Siddiqui', 'Female', '0304 5678901', 'ayesha.sid@school.com', 'M.A. (History)', '2022-06-12', 'Social Studies', 55000.00)
    ON CONFLICT DO NOTHING;

    -- 7. Insert Students
    INSERT INTO public.students (id, school_id, admission_no, first_name, last_name, gender, date_of_birth, class_id, section_id, session_id, father_name, guardian_phone, address, status) VALUES
    (v_stu_ayesha_id, v_school_id, 'ADM001', 'Ayesha', 'Khan', 'Female', '2010-03-12', v_class8_id, v_sec_a_id, v_session_id, 'Imran Khan', '0300 1234567', 'House No 123, St1, Lahore', 'Active'),
    (v_stu_ali_id, v_school_id, 'ADM002', 'Muhammad', 'Ali', 'Male', '2010-05-18', v_class8_id, v_sec_a_id, v_session_id, 'Tariq Ali', '0300 2345678', 'House 45, Model Town, Lahore', 'Active'),
    (v_stu_sara_id, v_school_id, 'ADM003', 'Sara', 'Ahmed', 'Female', '2009-11-22', v_class8_id, v_sec_a_id, v_session_id, 'Ahmed Bilal', '0300 3456789', 'Gulberg III, Lahore', 'Active'),
    (v_stu_usman_id, v_school_id, 'ADM004', 'Usman', 'Tariq', 'Male', '2010-01-08', v_class8_id, v_sec_a_id, v_session_id, 'Tariq Mehmood', '0300 4567890', 'DHA Phase 5, Lahore', 'Active'),
    (v_stu_hira_id, v_school_id, 'ADM005', 'Hira', 'Fatima', 'Female', '2010-07-30', v_class8_id, v_sec_a_id, v_session_id, 'Rashid Minhas', '0300 5678901', 'Johar Town, Lahore', 'Active')
    ON CONFLICT DO NOTHING;

    -- 8. Insert Fee Types
    INSERT INTO public.fee_types (id, school_id, name, default_amount, description) VALUES
    (v_fee_tuition_id, v_school_id, 'Tuition Fee', 5000.00, 'Monthly tuition fee'),
    (v_fee_admission_id, v_school_id, 'Admission Fee', 2000.00, 'One-time admission fee'),
    (v_fee_monthly_id, v_school_id, 'Monthly Fee', 1500.00, 'General monthly maintenance fee'),
    (v_fee_exam_id, v_school_id, 'Exam Fee', 1000.00, 'Term examination fee'),
    (v_fee_lib_id, v_school_id, 'Library Fee', 500.00, 'Library and book access fee')
    ON CONFLICT DO NOTHING;

    -- 9. Insert Student Fees
    INSERT INTO public.student_fees (school_id, student_id, fee_type_id, session_id, month_year, amount, discount, paid_amount, due_date, status) VALUES
    (v_school_id, v_stu_ayesha_id, v_fee_tuition_id, v_session_id, 'Apr 2025', 5000.00, 0.00, 5000.00, '2025-04-10', 'Paid'),
    (v_school_id, v_stu_ali_id, v_fee_tuition_id, v_session_id, 'Apr 2025', 5000.00, 500.00, 4500.00, '2025-04-10', 'Paid'),
    (v_school_id, v_stu_sara_id, v_fee_tuition_id, v_session_id, 'Apr 2025', 5000.00, 0.00, 0.00, '2025-04-10', 'Unpaid')
    ON CONFLICT DO NOTHING;

    -- 10. Insert Announcements
    INSERT INTO public.announcements (school_id, title, message, audience, published_date) VALUES
    (v_school_id, 'School Reopening', 'New academic session starts from 1st 2025.', 'All', '2025-03-25'),
    (v_school_id, 'Parent Teacher Meeting', 'Scheduled on 10th April 2025 at 10:00 AM.', 'Parents', '2025-04-05'),
    (v_school_id, 'Holiday Notice', 'School will remain closed on 14th April 2025.', 'All', '2025-04-02')
    ON CONFLICT DO NOTHING;

    -- 11. Insert Homework
    INSERT INTO public.homework (school_id, class_id, section_id, subject_id, title, description, assigned_date, due_date) VALUES
    (v_school_id, v_class8_id, v_sec_a_id, v_math_id, 'Mathematics', 'Chapter 5 - Exercises', '2025-04-12', '2025-04-18'),
    (v_school_id, v_class8_id, v_sec_a_id, v_sci_id, 'Science', 'Project on Solar System', '2025-04-14', '2025-04-20'),
    (v_school_id, v_class8_id, v_sec_b_id, v_eng_id, 'English', 'Essay Writing', '2025-04-15', '2025-04-22'),
    (v_school_id, v_class7_id, v_sec_a_id, v_ss_id, 'Social Studies', 'Read Chapter 3', '2025-04-18', '2025-04-25')
    ON CONFLICT DO NOTHING;

    -- 12. Insert Leave Requests
    INSERT INTO public.leave_requests (school_id, student_id, applicant_type, applicant_name, start_date, end_date, reason, status) VALUES
    (v_school_id, v_stu_ayesha_id, 'Student', 'Ayesha Khan', '2025-04-15', '2025-04-16', 'Family event', 'Pending'),
    (v_school_id, v_stu_usman_id, 'Student', 'Usman Tariq', '2025-04-28', '2025-04-29', 'Sickness', 'Rejected')
    ON CONFLICT DO NOTHING;

    INSERT INTO public.leave_requests (school_id, teacher_id, applicant_type, applicant_name, start_date, end_date, reason, status) VALUES
    (v_school_id, v_tea_ahmed_id, 'Teacher', 'Ahmed Raza', '2025-04-20', '2025-04-22', 'Medical checkup', 'Pending'),
    (v_school_id, '77777777-7777-7777-7777-777777777773', 'Teacher', 'Fatima Noor', '2025-04-25', '2025-04-25', 'Personal urgent work', 'Approved')
    ON CONFLICT DO NOTHING;

    -- 13. Insert Timetable
    INSERT INTO public.timetables (school_id, class_id, section_id, subject_id, teacher_id, day_of_week, start_time, end_time, title, is_break) VALUES
    (v_school_id, v_class8_id, v_sec_a_id, v_math_id, v_tea_sarah_id, 'Monday', '08:00', '08:45', 'Mathematics (Ms. Sarah)', false),
    (v_school_id, v_class8_id, v_sec_a_id, v_eng_id, '77777777-7777-7777-7777-777777777773', 'Monday', '08:45', '09:30', 'English (Ms. Fatima)', false),
    (v_school_id, v_class8_id, v_sec_a_id, v_sci_id, v_tea_ahmed_id, 'Monday', '09:30', '10:15', 'Science (Mr. Raza)', false),
    (v_school_id, v_class8_id, v_sec_a_id, NULL, NULL, 'Monday', '10:15', '10:30', 'Break', true),
    (v_school_id, v_class8_id, v_sec_a_id, v_urdu_id, '77777777-7777-7777-7777-777777777774', 'Monday', '10:30', '11:15', 'Urdu (Ms. Ayesha)', false),
    (v_school_id, v_class8_id, v_sec_a_id, v_ss_id, '77777777-7777-7777-7777-777777777775', 'Monday', '11:15', '12:00', 'Social Studies (Mr. Zeeshan)', false)
    ON CONFLICT DO NOTHING;

    -- 14. Insert Exam & Marks
    INSERT INTO public.examinations (id, school_id, session_id, name, start_date, end_date)
    VALUES (v_exam_id, v_school_id, v_session_id, 'Mid Term Exam (2024-25)', '2025-05-01', '2025-05-15')
    ON CONFLICT DO NOTHING;

    INSERT INTO public.exam_subjects (id, school_id, exam_id, class_id, subject_id, max_marks, passing_marks) VALUES
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeee1', v_school_id, v_exam_id, v_class8_id, v_math_id, 100.00, 40.00),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeee2', v_school_id, v_exam_id, v_class8_id, v_sci_id, 100.00, 40.00),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeee3', v_school_id, v_exam_id, v_class8_id, v_eng_id, 100.00, 40.00),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeee4', v_school_id, v_exam_id, v_class8_id, v_urdu_id, 100.00, 40.00),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeee5', v_school_id, v_exam_id, v_class8_id, v_ss_id, 100.00, 40.00)
    ON CONFLICT DO NOTHING;

    INSERT INTO public.exam_results (school_id, exam_subject_id, student_id, obtained_marks, grade) VALUES
    (v_school_id, 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeee1', v_stu_ayesha_id, 85.00, 'A'),
    (v_school_id, 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeee2', v_stu_ayesha_id, 78.00, 'B+'),
    (v_school_id, 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeee3', v_stu_ayesha_id, 92.00, 'A+'),
    (v_school_id, 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeee4', v_stu_ayesha_id, 88.00, 'A'),
    (v_school_id, 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeee5', v_stu_ayesha_id, 76.00, 'B+')
    ON CONFLICT DO NOTHING;

    -- 15. Expenses
    INSERT INTO public.expenses (school_id, category, title, amount, payment_method, reference_no) VALUES
    (v_school_id, 'Utilities', 'Electricity Bill April 2025', 45000.00, 'Bank Transfer', 'BILL-2025-04'),
    (v_school_id, 'Supplies', 'Exam Papers & Stationery', 12500.00, 'Cash', 'RCPT-EXP-089')
    ON CONFLICT DO NOTHING;
END $$;
