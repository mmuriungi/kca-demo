table 50053 "ACA-2ndSuppExam. Co. Reg."
{
    Caption = 'ACA-2ndSuppExam. Co. Reg.';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Student Number"; Code[20])
        {
            Caption = 'Student Number';
            DataClassification = CustomerContent;
        }
        field(2; "Student Name"; Text[150])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(3; "Programme"; Code[20])
        {
            Caption = 'Programme';
            DataClassification = CustomerContent;
        }
        field(4; "Department"; Code[20])
        {
            Caption = 'Department';
            DataClassification = CustomerContent;
        }
        field(5; "School Code"; Code[20])
        {
            Caption = 'School Code';
            DataClassification = CustomerContent;
        }
        field(6; "Department Name"; Text[150])
        {
            Caption = 'Department Name';
            DataClassification = CustomerContent;
        }
        field(7; "School Name"; Text[150])
        {
            Caption = 'School Name';
            DataClassification = CustomerContent;
        }
        field(8; "Final Stage"; Code[20])
        {
            Caption = 'Final Stage';
            DataClassification = CustomerContent;
        }
        field(9; "Final Year of Study"; Integer)
        {
            Caption = 'Final Year of Study';
            DataClassification = CustomerContent;
        }
        field(10; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(11; "Graduating"; Boolean)
        {
            Caption = 'Graduating';
            DataClassification = CustomerContent;
        }
        field(12; "Classification"; Code[50])
        {
            Caption = 'Classification';
            DataClassification = CustomerContent;
        }
        field(13; "Total Courses"; Integer)
        {
            Caption = 'Total Courses';
            DataClassification = CustomerContent;
        }
        field(14; "Total Units"; Decimal)
        {
            Caption = 'Total Units';
            DataClassification = CustomerContent;
        }
        field(15; "Admission Date"; Date)
        {
            Caption = 'Admission Date';
            DataClassification = CustomerContent;
        }
        field(16; "Admission Academic Year"; Code[20])
        {
            Caption = 'Admission Academic Year';
            DataClassification = CustomerContent;
        }
        field(17; "Final Academic Year"; Code[20])
        {
            Caption = 'Final Academic Year';
            DataClassification = CustomerContent;
        }
        field(18; "Total Marks"; Decimal)
        {
            Caption = 'Total Marks';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-2ndSuppExam Class. Units"."Total Score Decimal" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study")));
        }
        field(19; "Total Weighted Marks"; Decimal)
        {
            Caption = 'Total Weighted Marks';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-2ndSuppExam Class. Units"."Weighted Total Score" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study")));
        }
        field(20; "Normal Average"; Decimal)
        {
            Caption = 'Normal Average';
            FieldClass = FlowField;
            CalcFormula = Average("ACA-2ndSuppExam Class. Units"."Total Score Decimal" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study")));
        }
        field(21; "Weighted Average"; Decimal)
        {
            Caption = 'Weighted Average';
            FieldClass = FlowField;
            CalcFormula = Average("ACA-2ndSuppExam Class. Units"."Weighted Total Score" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study")));
        }
        field(22; "Total Failed Courses"; Integer)
        {
            Caption = 'Total Failed Courses';
            FieldClass = FlowField;
            CalcFormula = Count("ACA-2ndSuppExam Class. Units" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study"), "Pass" = const(FALSE)));
        }
        field(23; "Total Failed Units"; Decimal)
        {
            Caption = 'Total Failed Units';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-2ndSuppExam Class. Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study"), "Pass" = const(FALSE)));
        }
        field(24; "Failed Courses"; Integer)
        {
            Caption = 'Failed Courses';
            FieldClass = FlowField;
            CalcFormula = Count("ACA-2ndSuppExam Class. Units" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study"), "Pass" = const(false)));
        }
        field(25; "Failed Units"; Decimal)
        {
            Caption = 'Failed Units';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-2ndSuppExam Class. Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Pass" = const(false), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study")));
        }
        field(26; "Failed Cores"; Decimal)
        {
            Caption = 'Failed Cores';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-2ndSuppExam Class. Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Pass" = const(false), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study"), "Unit Type" = filter('CORE')));
        }
        field(27; "Failed Required"; Decimal)
        {
            Caption = 'Failed Required';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-2ndSuppExam Class. Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Pass" = const(false), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study"), "Unit Type" = filter('REQUIRED')));
        }
        field(28; "Failed Electives"; Decimal)
        {
            Caption = 'Failed Electives';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-2ndSuppExam Class. Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Pass" = const(false), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study"), "Unit Type" = filter('ELECTIVE')));
        }
        field(29; "Total Cores Done"; Decimal)
        {
            Caption = 'Total Cores Done';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-2ndSuppExam Class. Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study"), "Unit Type" = filter('CORE')));
        }
        field(30; "Total Cores Passed"; Integer)
        {
            Caption = 'Total Cores Passed';
            FieldClass = FlowField;
            CalcFormula = Count("ACA-2ndSuppExam Class. Units" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Pass" = const(true), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study"), "Unit Type" = filter('CORE')));
        }
        field(31; "Total Required Done"; Integer)
        {
            Caption = 'Total Required Done';
            FieldClass = FlowField;
            CalcFormula = Count("ACA-2ndSuppExam Class. Units" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study"), "Unit Type" = filter('REQUIRED')));
        }
        field(32; "Total Electives Done"; Integer)
        {
            Caption = 'Total Electives Done';
            FieldClass = FlowField;
            CalcFormula = Count("ACA-2ndSuppExam Class. Units" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study"), "Unit Type" = filter('ELECTIVE')));
        }
        field(33; "Tota Electives Passed"; Integer)
        {
            Caption = 'Tota Electives Passed';
            FieldClass = FlowField;
            CalcFormula = Count("ACA-2ndSuppExam Class. Units" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study"), "Pass" = const(true), "Unit Type" = filter('ELECTIVE')));
        }
        field(34; "Classified Electives C. Count"; Integer)
        {
            Caption = 'Classified Electives C. Count';
            FieldClass = FlowField;
            CalcFormula = Count("ACA-2ndSuppExam Class. Units" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study"), "Unit Type" = filter('ELECTIVE'), "Allow In Graduate" = const(true)));
        }
        field(35; "Classified Electives Units"; Decimal)
        {
            Caption = 'Classified Electives Units';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-2ndSuppExam Class. Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study"), "Unit Type" = filter('ELECTIVE'), "Allow In Graduate" = const(true)));
        }
        field(36; "Total Classified C. Count"; Integer)
        {
            Caption = 'Total Classified C. Count';
            FieldClass = FlowField;
            CalcFormula = Count("ACA-2ndSuppExam Class. Units" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study"), "Allow In Graduate" = const(true), "Pass" = const(true)));
        }
        field(37; "Total Classified Units"; Decimal)
        {
            Caption = 'Total Classified Units';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-2ndSuppExam Class. Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study"), "Allow In Graduate" = const(true), "Pass" = const(true)));
        }
        field(38; "Classified Total Marks"; Decimal)
        {
            Caption = 'Classified Total Marks';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-2ndSuppExam Class. Units"."Total Score Decimal" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study"), "Allow In Graduate" = const(true), "Pass" = const(true)));
            Editable = false;
        }
        field(39; "Classified W. Total"; Decimal)
        {
            Caption = 'Classified W. Total';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-2ndSuppExam Class. Units"."Weighted Total Score" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study"), "Allow In Graduate" = const(true), "Pass" = const(true)));
            //Sum("ACA-2ndSuppExam Class. Units"."Weighted Total Score" WHERE (Student No.=FIELD(Student Number),Programme=FIELD(Programme),Academic Year=FIELD(Academic Year),Year of Study=FIELD(Year of Study),Allow In Graduate=FILTER(Yes),Pass=FILTER(Yes)))
            Editable = false;
        }
        field(40; "Classified Average"; Decimal)
        {
            Caption = 'Classified Average';
        }
        field(41; "Classified W. Average"; Decimal)
        {
            Caption = 'Classified W. Average';
            DataClassification = CustomerContent;
        }
        field(42; "Final Classification"; Code[50])
        {
            Caption = 'Final Classification';
            DataClassification = CustomerContent;
        }
        field(43; "Final Classification Pass"; Boolean)
        {
            Caption = 'Final Classification Pass';
            DataClassification = CustomerContent;
        }
        field(44; "Final Classification Order"; Integer)
        {
            Caption = 'Final Classification Order';
            DataClassification = CustomerContent;
        }
        field(45; "Graduation Grade"; Code[20])
        {
            Caption = 'Graduation Grade';
            DataClassification = CustomerContent;
        }
        field(46; "Final Classification Grade"; Code[20])
        {
            Caption = 'Final Classification Grade';
            DataClassification = CustomerContent;
        }
        field(48; "Total Required Passed"; Integer)
        {
            Caption = 'Total Required Passed';
            FieldClass = FlowField;
            CalcFormula = Count("ACA-2ndSuppExam Class. Units" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Year of Study" = FIELD("Year of Study"), "Pass" = const(true), "Unit Type" = const('REQUIRED')));
            Editable = false;
        }
        field(49; "Year of Study"; Integer)
        {
            Caption = 'Year of Study';
            DataClassification = CustomerContent;
        }
        field(50; "Required Stage Units"; Decimal)
        {
            Caption = 'Required Stage Units';
            DataClassification = CustomerContent;
        }
        field(51; "Attained Stage Units"; Decimal)
        {
            Caption = 'Attained Stage Units';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-2ndSuppExam Class. Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Year of Study" = FIELD("Year of Study"), "Allow In Graduate" = const(true)));
            Editable = false;
        }
        field(52; "Units Deficit"; Decimal)
        {
            Caption = 'Units Deficit';
            DataClassification = CustomerContent;
        }
        field(53; "Multiple Programe Reg. Exists"; Boolean)
        {
            Caption = 'Multiple Programe Reg. Exists';
            DataClassification = CustomerContent;
        }
        field(54; "Cohort"; Code[20])
        {
            Caption = 'Cohort';
            DataClassification = CustomerContent;
        }
        field(55; "Programme Option"; Code[20])
        {
            Caption = 'Programme Option';
            DataClassification = CustomerContent;
        }
        field(57; "Results Exists Status"; Option)
        {
            Caption = 'Results Exists Status';
            DataClassification = CustomerContent;
            OptionMembers = " ";
        }
        field(58; "No. of Resits"; Integer)
        {
            Caption = 'No. of Resits';
            DataClassification = CustomerContent;
        }
        field(59; "No. of Repeats"; Integer)
        {
            Caption = 'No. of Repeats';
            DataClassification = CustomerContent;
        }
        field(60; "% Total Failed Courses"; Decimal)
        {
            Caption = '% Total Failed Courses';
            DataClassification = CustomerContent;
        }
        field(61; "% Total Failed Units"; Decimal)
        {
            Caption = '% Total Failed Units';
            DataClassification = CustomerContent;
        }
        field(62; "% Failed Courses"; Decimal)
        {
            Caption = '% Failed Courses';
            DataClassification = CustomerContent;
        }
        field(63; "% Failed Units"; Decimal)
        {
            Caption = '% Failed Units';
            DataClassification = CustomerContent;
        }
        field(64; "% Failed Cores"; Decimal)
        {
            Caption = '% Failed Cores';
            DataClassification = CustomerContent;
        }
        field(65; "% Failed Required"; Decimal)
        {
            Caption = '% Failed Required';
            DataClassification = CustomerContent;
        }
        field(66; "% Failed Electives"; Decimal)
        {
            Caption = '% Failed Electives';
            DataClassification = CustomerContent;
        }
        field(67; "Finalist"; Boolean)
        {
            Caption = 'Finalist';
            DataClassification = CustomerContent;
        }
        field(68; "Provisional Transcript Remark"; Text[100])
        {
            Caption = 'Provisional Transcript Remark';
            DataClassification = CustomerContent;
        }
        field(69; "Transcript Remark"; Text[100])
        {
            Caption = 'Transcript Remark';
            DataClassification = CustomerContent;
        }
        field(70; "Record Count"; Integer)
        {
            Caption = 'Record Count';
            DataClassification = CustomerContent;
        }
        field(71; "Rubric Number"; Integer)
        {
            Caption = 'Rubric Number';
            DataClassification = CustomerContent;
        }
        field(72; "Total Failed Core Units"; Decimal)
        {
            Caption = 'Total Failed Core Units';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-2ndSuppExam Class. Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Year of Study" = FIELD("Year of Study"), Pass = const(false), "Unit Type" = const('CORE'), "Academic Year" = FIELD("Academic Year")));
            Editable = false;
        }
        field(73; "Reporting Academic Year"; Code[20])
        {
            Caption = 'Reporting Academic Year';
            DataClassification = CustomerContent;
        }
        field(74; "Category Order"; Integer)
        {
            Caption = 'Category Order';
            DataClassification = CustomerContent;
        }
        field(75; "Prog. Category"; Option)
        {
            Caption = 'Prog. Category';
            OptionMembers = " ",Certificate,Diploma,Undergraduate,Postgraduate,Professional,"Course List";
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Programme".Category WHERE(Code = FIELD(Programme)));
        }
        field(76; "Prog. Option Name"; Text[150])
        {
            Caption = 'Prog. Option Name';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Programme Options".desription WHERE("Programme Code" = FIELD(Programme), Code = FIELD("Programme Option")));
        }
        field(77; "Resit Exists"; Boolean)
        {
            Caption = 'Resit Exists';
            FieldClass = FlowField;
            CalcFormula = Exist("ACA-Student Units" WHERE("Processed Marks" = FILTER(true), "Passed" = FILTER(false), "Reg. Reversed" = FILTER(false), "Student No." = FIELD("Student Number")));
        }
        field(78; "Cumm. Resit Serial"; Integer)
        {
            Caption = 'Cumm. Resit Serial';
            DataClassification = CustomerContent;
        }
        field(79; "Programme Name"; Text[150])
        {
            Caption = 'Programme Name';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Programme".Description WHERE(Code = FIELD(Programme)));
        }
        field(80; "Required Core Courses"; Integer)
        {
            Caption = 'Required Core Courses';
            FieldClass = FlowField;
            CalcFormula = Count("ACA-Units/Subjects" WHERE("Programme Code" = FIELD(Programme), "Year of Study" = FIELD("Year of Study"), "Unit Type" = FILTER('CORE')));
        }
        field(81; "Required Core Units"; Decimal)
        {
            Caption = 'Required Core Units';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-Units/Subjects"."Credit Hours" WHERE("Programme Code" = FIELD(Programme), "Year of Study" = FIELD("Year of Study"), "Unit Type" = FILTER('CORE')));
        }
        field(82; "Attained Core Courses"; Integer)
        {
            Caption = 'Attained Core Courses';
            FieldClass = FlowField;
            CalcFormula = Count("ACA-2ndSuppExam Class. Units" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Year of Study" = FIELD("Year of Study"), "Allow In Graduate" = FILTER(true), "Unit Type" = FILTER('CORE')));
        }
        field(83; "Attained Core Units"; Decimal)
        {
            Caption = 'Attained Core Units';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-2ndSuppExam Class. Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"), "Programme" = FIELD("Programme"), "Year of Study" = FIELD("Year of Study"), "Allow In Graduate" = FILTER(true), "Unit Type" = FILTER('CORE')));
        }
        field(84; "Deficit Core Courses"; Integer)
        {
            Caption = 'Deficit Core Courses';

        }
        field(85; "Deficit Core Units"; Decimal)
        {
            Caption = 'Deficit Core Units';
            DataClassification = CustomerContent;
        }
        field(86; "Required Required Courses"; Integer)
        {
            Caption = 'Required Required Courses';
            FieldClass = FlowField;
            CalcFormula = Count("ACA-Units/Subjects" WHERE("Programme Code" = FIELD(Programme), "Year of Study" = FIELD("Year of Study"), "Unit Type" = FILTER('REQUIRED')));
        }
        field(87; "Required Required Units"; Decimal)
        {
            Caption = 'Required Required Units';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-Units/Subjects"."Credit Hours" WHERE("Programme Code" = FIELD(Programme), "Year of Study" = FIELD("Year of Study"), "Unit Type" = FILTER('REQUIRED')));
        }
        field(88; "Attained Required Courses"; Integer)
        {
            Caption = 'Attained Required Courses';
            FieldClass = FlowField;
            CalcFormula = Count("ACA-2ndSuppExam Class. Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Year of Study" = FIELD("Year of Study"), "Allow In Graduate" = FILTER(true), "Unit Type" = FILTER('REQUIRED')));
        }
        field(89; "Attained Required Units"; Decimal)
        {
            Caption = 'Attained Required Units';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-2ndSuppExam Class. Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Year of Study" = FIELD("Year of Study"), "Allow In Graduate" = FILTER(true), "Unit Type" = FILTER('REQUIRED')));
        }
        field(90; "Deficit Required Courses"; Integer)
        {
            Caption = 'Deficit Required Courses';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-2ndSuppExam Class. Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Year of Study" = FIELD("Year of Study"), "Allow In Graduate" = FILTER(true), "Unit Type" = FILTER('REQUIRED')));
        }
        field(91; "Deficit Required Units"; Decimal)
        {
            Caption = 'Deficit Required Units';
            DataClassification = CustomerContent;
        }
        field(92; "Required Electives Courses"; Integer)
        {
            Caption = 'Required Electives Courses';
            FieldClass = FlowField;
            CalcFormula = Count("ACA-Units/Subjects" WHERE("Programme Code" = FIELD(Programme), "Year of Study" = FIELD("Year of Study"), "Unit Type" = FILTER('ELECTIVE'|'ELECTIVES')));
        }
        field(93; "Required Electives Units"; Decimal)
        {
            Caption = 'Required Electives Units';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-Units/Subjects"."Credit Hours" WHERE("Programme Code" = FIELD(Programme), "Year of Study" = FIELD("Year of Study"), "Unit Type" = FILTER('ELECTIVE'|'ELECTIVES')));
        }
        field(94; "Attained Electives Courses"; Integer)
        {
            Caption = 'Attained Electives Courses';
            FieldClass = FlowField;
            CalcFormula = Count("ACA-2ndSuppExam Class. Units" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Year of Study" = FIELD("Year of Study"), "Allow In Graduate" = FILTER(true), "Unit Type" = FILTER('ELECTIVE'|'ELECTIVES')));
        }
        field(95; "Attained Electives Units"; Decimal)
        {
            Caption = 'Attained Electives Units';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-2ndSuppExam Class. Units"."Credit Hours" WHERE("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Year of Study" = FIELD("Year of Study"), "Allow In Graduate" = FILTER(true), "Unit Type"=FILTER('ELECTIVE'|'ELECTIVES')));
        }
        field(96; "Deficit Electives Courses"; Integer)
        {
            Caption = 'Deficit Electives Courses';

        }
        field(97; "Deficit Electives Units"; Decimal)
        {
            Caption = 'Deficit Electives Units';
            DataClassification = CustomerContent;
        }
        field(98; "Cummulative Fails"; Integer)
        {
            Caption = 'Cummulative Fails';
            DataClassification = CustomerContent;
        }
        field(99; "Cumm. Required Stage Units"; Integer)
        {
            Caption = 'Cumm. Required Stage Units';
            DataClassification = CustomerContent;
        }
        field(100; "Cumm Attained Units"; Integer)
        {
            Caption = 'Cumm Attained Units';
            DataClassification = CustomerContent;
        }
        field(101; "Missed CAT"; Boolean)
        {
            Caption = 'Missed CAT';
            FieldClass=FlowField;
            CalcFormula=Exist("ACA-2ndSuppExam Class. Units" WHERE("Student No."=FIELD("Student Number"),Programme=FIELD(Programme),"Year of Study"=FIELD("Year of Study"),"Results Exists Status"=FILTER("Exam Only")));
        }
        field(102; "Missed Exam"; Boolean)
        {
            Caption = 'Missed Exam';
            FieldClass=FlowField;
            CalcFormula=Exist("ACA-2ndSuppExam Class. Units" WHERE("Student No."=FIELD("Student Number"),Programme=FIELD(Programme),"Year of Study"=FIELD("Year of Study"),"Results Exists Status"=FILTER("CAT Only")));
        }
        field(103; "Missed Both CAT & Exam"; Boolean)
        {
            Caption = 'Missed Both CAT & Exam';
            FieldClass=FlowField;
            CalcFormula=Exist("ACA-2ndSuppExam Class. Units" WHERE("Student No."=FIELD("Student Number"),Programme=FIELD(Programme),"Year of Study"=FIELD("Year of Study"),"Results Exists Status"=FILTER("None Exists")));
        }
        field(104; "Grade"; Code[20])
        {
            Caption = 'Grade';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Final Grade Source".Grade WHERE ("Academic Year"=FIELD("Academic Year"),"Exam Catregory"=FIELD("Exam category"),"Total Score"=FIELD("Normal Average"),"Missing CAT"=FIELD("Missed CAT"),"Missing Exam"=FIELD("Missed Exam"),"Missed Both CAT & Exam"=FIELD("Missed Both CAT & Exam"),Grade=FILTER(<>'^')));
            Editable = false;
        }
        field(105; "Remarks"; Text[100])
        {
            Caption = 'Remarks';
            FieldClass=FlowField;
            CalcFormula=Lookup("ACA-Final Grade Source".Remarks WHERE ("Academic Year"=FIELD("Academic Year"),"Exam Catregory"=FIELD("Exam category"),"Total Score"=FIELD("Normal Average"),"Missing CAT"=FIELD("Missed CAT"),"Missing Exam"=FIELD("Missed Exam"),"Missed Both CAT & Exam"=FIELD("Missed Both CAT & Exam"),Grade=FILTER('<>^')));
            Editable = false;
        }
        field(106; "Override Remarks"; Boolean)
        {
            Caption = 'Override Remarks';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Final Grade Source"."Override Transcript Comments" WHERE ("Academic Year"=FIELD("Academic Year"),"Exam Catregory"=FIELD("Exam category"),"Total Score"=FIELD("Normal Average"),"Missing CAT"=FIELD("Missed CAT"),"Missing Exam"=FIELD("Missed Exam"),"Missed Both CAT & Exam"=FIELD("Missed Both CAT & Exam"),Grade=FILTER('<>^')));
            Editable = false;
        }
        field(107; "Exam category"; Code[20])
        {
            Caption = 'Exam category';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Programme"."Exam Category" WHERE (Code=FIELD(Programme)));
            Editable = false;
        }
        field(108; "Average"; Decimal)
        {
            Caption = 'Average';
            FieldClass = FlowField;
            CalcFormula = Average("ACA-2ndSuppExam Class. Units"."Total Score Decimal" WHERE ("Student No."=FIELD("Student Number"),Programme=FIELD(Programme),"Year of Study"=FIELD("Year of Study"),"Academic Year"=FIELD("Academic Year")));
        }
        field(109; "Supp Exists"; Boolean)
        {
            Caption = 'Supp Exists';
            FieldClass = FlowField;
            CalcFormula = Exist("ACA-2ndSuppExam Class. Units" WHERE ("Student No." = FIELD("Student Number"), "Year of Study" = FIELD("Year of Study"), "Academic Year" = FIELD("Academic Year"), "Is Supp. Unit" = FILTER(true)));
            Editable = false;
        }
        field(110; "Total Courses Passed"; Integer)
        {
            Caption = 'Total Courses Passed';
            FieldClass = FlowField;
            CalcFormula = Count("ACA-2ndSuppExam Class. Units" WHERE ("Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study"), "Pass" = FILTER(true)));
            Editable = false;
        }
        field(111; "Total Units Passed"; Decimal)
        {
            Caption = 'Total Units Passed';
            FieldClass = FlowField;
            CalcFormula = Sum("ACA-2ndSuppExam Class. Units"."Credit Hours" WHERE ("Student No."=FIELD("Student Number"),Programme=FIELD(Programme),"Academic Year"=FIELD("Academic Year"),"Year of Study"=FIELD("Year of Study"),Pass=const(true)));
            Editable = false;
        }
        field(112; "Exists DTSC Prefix"; Boolean)
        {
            Caption = 'Exists DTSC Prefix';
            FieldClass=FlowField;
            CalcFormula=Exist("ACA-2ndSuppExam Class. Units" WHERE ("Student No."=FIELD("Student Number"),Programme=FIELD(Programme),"Year of Study"=FIELD("Year of Study"),"Academic Year"=FIELD("Academic Year"),"Results Exists Status"=FILTER("None Exists"|"Exam Only"|"CAT Only")));
        }
        field(113; "Graduation Academic Year"; Code[20])
        {
            Caption = 'Graduation Academic Year';
            FieldClass=FlowField;
            CalcFormula=Lookup("ACA-Classification Course Reg."."Graduation Academic Year" WHERE ("Student Number"=FIELD("Student Number"),Programme=FIELD(Programme)));
            Editable = false;
        }
        field(114; "Exists Failed 2nd Supp"; Boolean)
        {
            Caption = 'Exists Failed 2nd Supp';
            FieldClass=FlowField;
            CalcFormula=Exist("ACA-2ndSuppExam Class. Units" WHERE ("Student No."=FIELD("Student Number"),"Year of Study"=FIELD("Year of Study"),Pass=const(false),"Academic Year"=FIELD("Academic Year"),"Is Supp. Unit"=const(true)));
            Editable = false;
        }
        field(115; "Special Exists"; Boolean)
        {
            Caption = 'Special Exists';
            FieldClass=FlowField;
            CalcFormula=Exist("ACA-2ndSuppExam Class. Units" WHERE ("Student No."=FIELD("Student Number"),"Year of Study"=FIELD("Year of Study"),"Is Special Unit"=const(true),"Academic Year"=FIELD("Academic Year")));
            Editable = false;
        }
        field(116; "Exists a Failed Special"; Boolean)
        {
            Caption = 'Exists a Failed Special';
            FieldClass=FlowField;
            CalcFormula=Exist("ACA-2ndSuppExam Class. Units" WHERE ("Student No."=FIELD("Student Number"),"Year of Study"=FIELD("Year of Study"),"Is Special Unit"=const(true),"Academic Year"=FIELD("Academic Year"),Pass=const(false)));
            Editable = false;
        }
        field(117; "Supp. Registration Exists"; Boolean)
        {
            Caption = 'Supp. Registration Exists';
            FieldClass=FlowField;
            CalcFormula=Exist("ACA-2ndSuppExam Class. Units" WHERE ("Student No."=FIELD("Student Number"),"Year of Study"=FIELD("Year of Study"),"Academic Year"=FIELD("Academic Year"),"Is Supp. Unit"=const(true)));
            Editable = false;
        }
        field(121; "Supp/Special Exists"; Boolean)
        {
            Caption = 'Supp/Special Exists';
            FieldClass=FlowField;
            CalcFormula=Exist("ACA-2ndSuppExam Class. Units" WHERE ("Student No."=FIELD("Student Number"),"Year of Study"=FIELD("Year of Study"),"Is Supp. Unit"=const(true),"Academic Year"=FIELD("Academic Year")));
            Editable = false;
        }
        field(123; "Allow View of Results"; Boolean)
        {
            Caption = 'Allow View of Results';
            FieldClass=FlowField;
            CalcFormula=Lookup("ACA-Academic Year"."Release Results" WHERE (Code=FIELD("Academic Year")));
        }
        field(124; "Special Registration Exists"; Boolean)
        {
            Caption = 'Special Registration Exists';
            FieldClass=FlowField;
            CalcFormula=Exist("ACA-2ndSuppExam Class. Units" WHERE ("Student No."=FIELD("Student Number"),"Year of Study"=FIELD("Year of Study"),"Academic Year"=FIELD("Academic Year"),"Is Special Unit"=const(true)));
            Editable = false;
        }
        field(125; "Academic Year Exclude Comp."; Boolean)
        {
            Caption = 'Academic Year Exclude Comp.';
            FieldClass=FlowField;
            CalcFormula=Exist("ACA-Course Registration" WHERE ("Student No."=FIELD("Student Number"),"Academic Year"=FIELD("Academic Year"),"Academic Year Exclude Comp."=const(true)));
            Editable = false;
        }
        field(127; "Defined Units (Flow)"; Integer)
        {
            Caption = 'Defined Units (Flow)';
            FieldClass=FlowField;
            CalcFormula=Sum("ACA-Defined Units per YoS"."Number of Units" WHERE (programmes=FIELD(Programme),"Year of Study"=FIELD("Year of Study"),Options=FIELD("Programme Option"),"Academic Year"=FIELD("Academic Year")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Student Number", Programme, "Academic Year", "Year of Study")
        {
            Clustered = true;
        }
    }
}