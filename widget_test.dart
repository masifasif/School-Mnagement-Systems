import 'package:flutter_test/flutter_test.dart';
import 'package:basic_school_mgmt/app.dart';
import 'package:basic_school_mgmt/core/utils/grade_calculator.dart';
import 'package:basic_school_mgmt/core/utils/validators.dart';
import 'package:basic_school_mgmt/models/fee_model.dart';
import 'package:basic_school_mgmt/models/user_profile_model.dart';
import 'package:basic_school_mgmt/providers/attendance_provider.dart';

void main() {
  group('Unit Tests: Core Calculations & Logic', () {
    test('Grade Calculator accurately assigns grades based on percentage', () {
      expect(GradeCalculator.calculateGrade(95.0), 'A+');
      expect(GradeCalculator.calculateGrade(85.0), 'A');
      expect(GradeCalculator.calculateGrade(75.0), 'B+');
      expect(GradeCalculator.calculateGrade(65.0), 'B');
      expect(GradeCalculator.calculateGrade(55.0), 'C');
      expect(GradeCalculator.calculateGrade(45.0), 'D');
      expect(GradeCalculator.calculateGrade(35.0), 'F');

      expect(GradeCalculator.isPass(40.0), true);
      expect(GradeCalculator.isPass(39.9), false);
    });

    test('Fee Calculations: outstanding balance and partial payments', () {
      final studentFee = StudentFeeModel(
        id: 'sf_test',
        schoolId: 'sch_1',
        studentId: 'stu_1',
        feeTypeId: 'ft_1',
        sessionId: 'ses_1',
        monthYear: 'Apr 2025',
        amount: 5000.0,
        discount: 500.0,
        paidAmount: 2000.0,
      );

      // Total (5000) - Discount (500) - Paid (2000) = Outstanding (2500)
      expect(studentFee.outstanding, 2500.0);

      final fullPaidFee = studentFee.copyWith(paidAmount: 4500.0);
      expect(fullPaidFee.outstanding, 0.0);
    });

    test('Form Validators validate email, password, and required fields', () {
      expect(Validators.required(''), isNotNull);
      expect(Validators.required('Ahmed'), isNull);

      expect(Validators.email('invalid-email'), isNotNull);
      expect(Validators.email('admin@school.com'), isNull);

      expect(Validators.password('123'), isNotNull);
      expect(Validators.password('123456'), isNull);
    });

    test(
      'Security & Role Permissions: Only School Admin can manage school logo',
      () {
        final admin = UserProfileModel(
          id: 'u1',
          schoolId: 'sch_1',
          email: 'admin@school.com',
          fullName: 'Admin User',
          role: 'admin',
        );

        final teacher = UserProfileModel(
          id: 'u2',
          schoolId: 'sch_1',
          email: 'teacher@school.com',
          fullName: 'Teacher User',
          role: 'teacher',
        );

        final accountant = UserProfileModel(
          id: 'u3',
          schoolId: 'sch_1',
          email: 'accountant@school.com',
          fullName: 'Accountant User',
          role: 'accountant',
        );

        // Verify strict logo permission rule
        expect(admin.canManageLogo, isTrue);
        expect(teacher.canManageLogo, isFalse);
        expect(accountant.canManageLogo, isFalse);

        // Financials
        expect(admin.canManageFinancials, isTrue);
        expect(accountant.canManageFinancials, isTrue);
        expect(teacher.canManageFinancials, isFalse);
      },
    );

    test('Attendance Provider calculates percentages accurately', () {
      final attProv = AttendanceProvider();
      expect(attProv.todayAttendancePercentage, greaterThan(0.0));
    });
  });

  group('Widget Tests: UI Smoke & Navigation', () {
    testWidgets('App loads splash screen successfully with school branding', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const BrightFutureSchoolApp());

      expect(find.text('Bright Future School'), findsOneWidget);
      expect(find.text('Learn • Grow • Succeed'), findsOneWidget);
      expect(find.text('School Management System'), findsOneWidget);

      // Settle splash timer
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });
  });
}
