table 50069 "ACA-SuppExam Class. Studs"
{
    Caption = 'ACA-SuppExam Class. Studs';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Student Number"; Code[20])
        {
            Caption = 'Student Number';
        }
        field(2; "Student Name"; Text[150])
        {
            Caption = 'Student Name';
        }
        field(3; "Programme"; Code[20])
        {
            Caption = 'Programme';
        }
        field(4; "Department"; Code[20])
        {
            Caption = 'Department';
        }
        field(5; "School Code"; Code[20])
        {
            Caption = 'School Code';
        }
        field(6; "Department Name"; Text[150])
        {
            Caption = 'Department Name';
        }
        field(7; "School Name"; Text[150])
        {
            Caption = 'School Name';
        }
        field(8; "Final Stage"; Code[20])
        {
            Caption = 'Final Stage';
        }
        field(9; "Final Year of Study"; Integer)
        {
            Caption = 'Final Year of Study';
        }
        field(10; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
        }
        field(11; "Graduating"; Boolean)
        {
            Caption = 'Graduating';
        }
        field(12; "Classification"; Code[50])
        {
            Caption = 'Classification';
        }
        field(13; "Total Courses"; Integer)
        {
            Caption = 'Total Courses';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme)));
        }
        field(14; "Total Units"; Decimal)
        {
            Caption = 'Total Units';
            CalcFormula = Sum("ACA-Classification Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme)));
            FieldClass = flowfield;
        }
        field(15; "Admission Date"; Date)
        {
            Caption = 'Admission Date';
        }
        field(16; "Admission Academic Year"; Code[20])
        {
            Caption = 'Admission Academic Year';
        }
        field(17; "Final Academic Year"; Code[21])
        {
            Caption = 'Final Academic Year';
        }
        field(18; "Total Marks"; Decimal)
        {
            Caption = 'Total Marks';
            FieldClass = flowfield;
            CalcFormula = Sum("ACA-Classification Units"."Total Score Decimal" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme)));
        }
        field(19; "Total Weighted Marks"; Decimal)
        {
            Caption = 'Total Weighted Marks';
            FieldClass = flowfield;
            CalcFormula = Sum("ACA-Classification Units"."Weighted Total Score" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme)));
        }
        field(20; "Normal Average"; Decimal)
        {
            Caption = 'Normal Average';
        }
        field(21; "Weighted Average"; Decimal)
        {
            Caption = 'Weighted Average';
        }
        field(22; "Total Failed Courses"; Integer)
        {
            Caption = 'Total Failed Courses';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), Pass = FILTER(false)));
        }
        field(23; "Total Failed Units"; Decimal)
        {
            Caption = 'Total Failed Units';
            FieldClass = flowfield;
            CalcFormula = Sum("ACA-Classification Units"."Total Score Decimal" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), Pass = FILTER(false)));
        }
        field(24; "Failed Courses"; Integer)
        {
            Caption = 'Failed Courses';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), Pass = FILTER(false)));
        }
        field(25; "Failed Units"; Decimal)
        {
            Caption = 'Failed Units';
            FieldClass = flowfield;
            CalcFormula = Sum("ACA-Classification Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), Pass = FILTER(false)));
        }
        field(26; "Failed Cores"; Integer)
        {
            Caption = 'Failed Cores';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), Pass = FILTER(false), "Unit Type" = FILTER('CORE')));
        }
        field(27; "Failed Required"; Integer)
        {
            Caption = 'Failed Required';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), Pass = FILTER(false), "Unit Type" = FILTER('REQUIRED')));
        }
        field(28; "Failed Electives"; Integer)
        {
            Caption = 'Failed Electives';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), Pass = FILTER(false), "Unit Type" = FILTER('ELECTIVE')));
        }
        field(29; "Total Cores Done"; Integer)
        {
            Caption = 'Total Cores Done';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Unit Type" = FILTER('CORE')));
        }
        field(30; "Total Cores Passed"; Integer)
        {
            Caption = 'Total Cores Passed';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), Pass = FILTER(true), "Unit Type" = FILTER('CORE')));
        }
        field(31; "Total Required Done"; Integer)
        {
            Caption = 'Total Required Done';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Unit Type" = FILTER('REQUIRED')));
        }
        field(32; "Total Electives Done"; Integer)
        {
            Caption = 'Total Electives Done';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Unit Type" = FILTER('ELECTIVE')));
        }
        field(33; "Tota Electives Passed"; Integer)
        {
            Caption = 'Tota Electives Passed';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), Pass = FILTER(true), "Unit Type" = FILTER('ELECTIVE')));
        }
        field(34; "Classified Electives C. Count"; Integer)
        {
            Caption = 'Classified Electives C. Count';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Unit Type" = FILTER('ELECTIVE'), "Allow In Graduate 222" = FILTER(true)));
        }
        field(35; "Classified Electives Units"; Decimal)
        {
            Caption = 'Classified Electives Units';
            FieldClass = flowfield;
            CalcFormula = Sum("ACA-Classification Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Unit Type" = FILTER('ELECTIVE'), "Allow In Graduate 222" = FILTER(true)));
        }
        field(36; "Total Classified C. Count"; Integer)
        {
            Caption = 'Total Classified C. Count';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Allow In Graduate 222" = FILTER(true), Pass = FILTER(true)));
        }
        field(37; "Total Classified Units"; Decimal)
        {
            Caption = 'Total Classified Units';
            FieldClass = flowfield;
            CalcFormula = Sum("ACA-Classification Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Allow In Graduate 222" = FILTER(true), Pass = FILTER(true)));
        }
        field(38; "Classified Total Marks"; Decimal)
        {
            Caption = 'Classified Total Marks';
            FieldClass = flowfield;
            CalcFormula = Sum("ACA-Classification Units"."Total Score Decimal" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Allow In Graduate 222" = FILTER(true), Pass = FILTER(true)));
        }
        field(39; "Classified W. Total"; Decimal)
        {
            Caption = 'Classified W. Total';
            FieldClass = flowfield;
            CalcFormula = Sum("ACA-Classification Units"."Weighted Total Score" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Allow In Graduate 222" = FILTER(true), Pass = FILTER(true)));
        }
        field(40; "Classified Average"; Decimal)
        {
            Caption = 'Classified Average';
        }
        field(41; "Classified W. Average"; Decimal)
        {
            Caption = 'Classified W. Average';
        }
        field(42; "Final Classification"; Code[50])
        {
            Caption = 'Final Classification';
        }
        field(43; "Final Classification Pass"; Boolean)
        {
            Caption = 'Final Classification Pass';
        }
        field(44; "Final Classification Order"; Integer)
        {
            Caption = 'Final Classification Order';
        }
        field(45; "Graduation Grade"; Code[20])
        {
            Caption = 'Graduation Grade';
        }
        field(46; "Final Classification Grade"; Code[20])
        {
            Caption = 'Final Classification Grade';
        }
        field(48; "Total Required Passed"; Integer)
        {
            Caption = 'Total Required Passed';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), Pass = FILTER(true), "Unit Type" = FILTER('REQUIRED')));
        }
        field(49; "Year of Study"; Integer)
        {
            Caption = 'Year of Study';
        }
        field(50; "Required Stage Units"; Decimal)
        {
            Caption = 'Required Stage Units';
            FieldClass = flowfield;
            CalcFormula = Sum("ACA-Classification Course Reg."."Required Stage Units" WHERE("Student Number" = FIELD("Student Number"), Programme = FIELD(Programme), "Graduation Academic Year" = FIELD("Academic Year")));
        }
        field(51; "Attained Stage Units"; Integer)
        {
            Caption = 'Attained Stage Units';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Allow In Graduate 222" = FILTER(TRUE), Pass = FILTER(TRUE)));
        }
        field(52; "Units Deficit"; Decimal)
        {
            Caption = 'Units Deficit';
        }
        field(54; "Cohort"; Code[20])
        {
            Caption = 'Cohort';
        }
        field(55; "Status Students Count"; Integer)
        {
            Caption = 'Status Students Count';
        }
        field(56; "Programme Option"; Code[20])
        {
            Caption = 'Programme Option';
        }
        field(57; "Results Exists Status"; Option)
        {
            Caption = 'Results Exists Status';
            OptionMembers = " ","CAT Only","Exam Only","None Exists","Both Exists";
            OptionCaption = ' ,CAT Only,Exam Only,None Exists,Both Exists';
        }
        field(58; "No. of Resits"; Integer)
        {
            Caption = 'No. of Resits';
        }
        field(59; "No. of Repeats"; Integer)
        {
            Caption = 'No. of Repeats';
        }
        field(60; "% Total Failed Courses"; Integer)
        {
            Caption = '% Total Failed Courses';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Year of Study" = FIELD("Year of Study"), Pass = FILTER(false)));
        }
        field(61; "% Total Failed Units"; Decimal)
        {
            Caption = '% Total Failed Units';
            FieldClass = flowfield;
            CalcFormula = Sum("ACA-Classification Units"."Total Score Decimal" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Year of Study" = FIELD("Year of Study"), Pass = FILTER(false)));
        }
        field(62; "% Failed Courses"; Integer)
        {
            Caption = '% Failed Courses';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Year of Study" = FIELD("Year of Study"), Pass = FILTER(false)));
        }
        field(63; "% Failed Units"; Decimal)
        {
            Caption = '% Failed Units';
            FieldClass = flowfield;
            CalcFormula = Sum("ACA-Classification Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Year of Study" = FIELD("Year of Study"), Pass = FILTER(false)));
        }
        field(64; "% Failed Cores"; Integer)
        {
            Caption = '% Failed Cores';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Year of Study" = FIELD("Year of Study"), Pass = FILTER(false), "Unit Type" = FILTER('CORE')));
        }
        field(65; "% Failed Required"; Integer)
        {
            Caption = '% Failed Required';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Year of Study" = FIELD("Year of Study"), Pass = FILTER(false), "Unit Type" = FILTER('REQUIRED')));
        }
        field(66; "% Failed Electives"; Integer)
        {
            Caption = '% Failed Electives';
            FieldClass = flowfield;
            CalcFormula = Count("ACA-Classification Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Year of Study" = FIELD("Year of Study"), Pass = FILTER(false), "Unit Type" = FILTER('ELECTIVE')));
        }
        field(67; "Finalist"; Boolean)
        {
            Caption = 'Finalist';
        }
        field(68; "Reporting Academic Year"; Code[20])
        {
            Caption = 'Reporting Academic Year';
        }
        field(109; "Supp/Special Exists"; Boolean)
        {
            Caption = 'Supp/Special Exists';
            FieldClass = flowfield;
            CalcFormula = Exist("ACA-SuppExam Class. Units" WHERE("Student No." = FIELD("Student Number"), "Year of Study" = FIELD("Year of Study"), "Is Supp. Unit" = FILTER(True), "Academic Year" = FIELD("Academic Year")));
        }
    }

    keys
    {
        key(PK; "Student Number", Programme, "Academic Year")
        {
            Clustered = true;
        }
    }
    var
        Table: record Field;
}
