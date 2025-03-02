table 50052 "ACA-SuppExam. Co. Reg."
{
    Caption = 'ACA-SuppExam. Co. Reg.';
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
            fieldclass=flowfield;
            calcformula=Count("ACA-SuppExam Class. Units" WHERE ("Student No."=FIELD("Student Number"),Programme=FIELD(Programme),"Academic Year"=FIELD("Academic Year"),"Year of Study"=FIELD("Year of Study")));

        }
        field(14; "Total Units"; Decimal)
        {
            Caption = 'Total Units';
            fieldclass=flowfield;
            calcformula=Sum("ACA-SuppExam Class. Units"."Credit Hours" WHERE ("Student No."=FIELD("Student Number"),Programme=FIELD(Programme),"Academic Year"=FIELD("Academic Year"),"Year of Study"=FIELD("Year of Study")));
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
            fieldclass=flowfield;
            calcformula=Sum("ACA-SuppExam Class. Units"."Total Score Decimal" WHERE ("Student No."=FIELD("Student Number"),Programme=FIELD(Programme),"Academic Year"=FIELD("Academic Year"),"Year of Study"=FIELD("Year of Study")));
        }
        field(19; "Total Weighted Marks"; Decimal)
        {
            Caption = 'Total Weighted Marks';
            fieldclass=flowfield;
            calcformula=Sum("ACA-SuppExam Class. Units"."Weighted Total Score" WHERE ("Student No."=FIELD("Student Number"),Programme=FIELD(Programme),"Academic Year"=FIELD("Academic Year"),"Year of Study"=FIELD("Year of Study")));
        }
        field(20; "Normal Average"; Decimal)
        {
            Caption = 'Normal Average';
            fieldclass=flowfield;
            calcformula=Average("ACA-SuppExam Class. Units"."Total Score Decimal" WHERE ("Student No."=FIELD("Student Number"),Programme=FIELD(Programme),"Academic Year"=FIELD("Academic Year"),"Year of Study"=FIELD("Year of Study")));

        }
        field(21; "Weighted Average"; Decimal)
        {
            Caption = 'Weighted Average';
            fieldclass=flowfield;
            calcformula=Average("ACA-SuppExam Class. Units"."Weighted Total Score" WHERE ("Student No."=FIELD("Student Number"),Programme=FIELD(Programme),"Academic Year"=FIELD("Academic Year"),"Year of Study"=FIELD("Year of Study")));
        }
        field(22; "Total Failed Courses"; Integer)
        {
            Caption = 'Total Failed Courses';
            fieldclass=flowfield;
            calcformula=Count("ACA-SuppExam Class. Units" WHERE ("Student No."=FIELD("Student Number"),Programme=FIELD(Programme),Pass=FILTER(False),"Academic Year"=FIELD("Academic Year"),"Year of Study"=FIELD("Year of Study")));
        }
        field(23; "Total Failed Units"; Decimal)
        {
            Caption = 'Total Failed Units';
            fieldclass=flowfield;
            calcformula=Sum("ACA-SuppExam Class. Units"."Credit Hours" WHERE ("Student No."=FIELD("Student Number"),Programme=FIELD(Programme),Pass=FILTER(False),"Academic Year"=FIELD("Academic Year"),"Year of Study"=FIELD("Year of Study")));
        }
        field(24; "Failed Courses"; Integer)
        {
            Caption = 'Failed Courses';
            fieldclass=flowfield;
            calcformula=Count("ACA-SuppExam Class. Units" WHERE ("Student No."=FIELD("Student Number"),Programme=FIELD(Programme),"Academic Year"=FIELD("Academic Year"),"Year of Study"=FIELD("Year of Study"),Pass=FILTER(False)));
        }
        field(25; "Failed Units"; Decimal)
        {
            Caption = 'Failed Units';
            fieldclass=flowfield;
            calcformula=Sum("ACA-SuppExam Class. Units"."Credit Hours" WHERE ("Student No."=FIELD("Student Number"),Programme=FIELD(Programme),Pass=FILTER(False),"Academic Year"=FIELD("Academic Year"),"Year of Study"=FIELD("Year of Study")));
        }
        field(26; "Failed Cores"; Decimal)
        {
            Caption = 'Failed Cores';
            fieldclass=flowfield;
            calcformula=Sum("ACA-SuppExam Class. Units"."Credit Hours" WHERE ("Student No."=FIELD("Student Number"),Programme=FIELD(Programme),Pass=FILTER(False),"Academic Year"=FIELD("Academic Year"),"Year of Study"=FIELD("Year of Study"),"Unit Type"=FILTER('CORE')));
    
        }
        field(27; "Failed Required"; Decimal)
        {
            Caption = 'Failed Required';
            DataClassification = CustomerContent;
        }
        field(28; "Failed Electives"; Decimal)
        {
            Caption = 'Failed Electives';
            DataClassification = CustomerContent;
        }
        field(29; "Total Cores Done"; Decimal)
        {
            Caption = 'Total Cores Done';
            DataClassification = CustomerContent;
        }
        field(30; "Total Cores Passed"; Integer)
        {
            Caption = 'Total Cores Passed';
            DataClassification = CustomerContent;
        }
        field(31; "Total Required Done"; Integer)
        {
            Caption = 'Total Required Done';
            DataClassification = CustomerContent;
        }
        field(32; "Total Electives Done"; Integer)
        {
            Caption = 'Total Electives Done';
            DataClassification = CustomerContent;
        }
        field(33; "Tota Electives Passed"; Integer)
        {
            Caption = 'Tota Electives Passed';
            DataClassification = CustomerContent;
        }
        field(34; "Classified Electives C. Count"; Integer)
        {
            Caption = 'Classified Electives C. Count';
            DataClassification = CustomerContent;
        }
        field(35; "Classified Electives Units"; Decimal)
        {
            Caption = 'Classified Electives Units';
            DataClassification = CustomerContent;
        }
        field(36; "Total Classified C. Count"; Integer)
        {
            Caption = 'Total Classified C. Count';
            DataClassification = CustomerContent;
        }
        field(37; "Total Classified Units"; Decimal)
        {
            Caption = 'Total Classified Units';
            DataClassification = CustomerContent;
        }
        field(38; "Classified Total Marks"; Decimal)
        {
            Caption = 'Classified Total Marks';
            DataClassification = CustomerContent;
        }
        field(39; "Classified W. Total"; Decimal)
        {
            Caption = 'Classified W. Total';
            DataClassification = CustomerContent;
        }
        field(40; "Classified Average"; Decimal)
        {
            Caption = 'Classified Average';
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
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
            OptionMembers = " ","None Exists","CAT Only","Exam Only","Both Exists";
            OptionCaption = ' ,None Exists,CAT Only,Exam Only,Both Exists';
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
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
            OptionMembers = " ";
        }
        field(76; "Prog. Option Name"; Text[150])
        {
            Caption = 'Prog. Option Name';
            DataClassification = CustomerContent;
        }
        field(77; "Resit Exists"; Boolean)
        {
            Caption = 'Resit Exists';
            DataClassification = CustomerContent;
        }
        field(78; "Cumm. Resit Serial"; Integer)
        {
            Caption = 'Cumm. Resit Serial';
            DataClassification = CustomerContent;
        }
        field(79; "Programme Name"; Text[150])
        {
            Caption = 'Programme Name';
            DataClassification = CustomerContent;
        }
        field(80; "Required Core Courses"; Integer)
        {
            Caption = 'Required Core Courses';
            DataClassification = CustomerContent;
        }
        field(81; "Required Core Units"; Decimal)
        {
            Caption = 'Required Core Units';
            DataClassification = CustomerContent;
        }
        field(82; "Attained Core Courses"; Integer)
        {
            Caption = 'Attained Core Courses';
            DataClassification = CustomerContent;
        }
        field(83; "Attained Core Units"; Decimal)
        {
            Caption = 'Attained Core Units';
            DataClassification = CustomerContent;
        }
        field(84; "Deficit Core Courses"; Integer)
        {
            Caption = 'Deficit Core Courses';
            DataClassification = CustomerContent;
        }
        field(85; "Deficit Core Units"; Decimal)
        {
            Caption = 'Deficit Core Units';
            DataClassification = CustomerContent;
        }
        field(86; "Required Required Courses"; Integer)
        {
            Caption = 'Required Required Courses';
            DataClassification = CustomerContent;
        }
        field(87; "Required Required Units"; Decimal)
        {
            Caption = 'Required Required Units';
            DataClassification = CustomerContent;
        }
        field(88; "Attained Required Courses"; Integer)
        {
            Caption = 'Attained Required Courses';
            DataClassification = CustomerContent;
        }
        field(89; "Attained Required Units"; Decimal)
        {
            Caption = 'Attained Required Units';
            DataClassification = CustomerContent;
        }
        field(90; "Deficit Required Courses"; Integer)
        {
            Caption = 'Deficit Required Courses';
            DataClassification = CustomerContent;
        }
        field(91; "Deficit Required Units"; Decimal)
        {
            Caption = 'Deficit Required Units';
            DataClassification = CustomerContent;
        }
        field(92; "Required Electives Courses"; Integer)
        {
            Caption = 'Required Electives Courses';
            DataClassification = CustomerContent;
        }
        field(93; "Required Electives Units"; Decimal)
        {
            Caption = 'Required Electives Units';
            DataClassification = CustomerContent;
        }
        field(94; "Attained Electives Courses"; Integer)
        {
            Caption = 'Attained Electives Courses';
            DataClassification = CustomerContent;
        }
        field(95; "Attained Electives Units"; Decimal)
        {
            Caption = 'Attained Electives Units';
            DataClassification = CustomerContent;
        }
        field(96; "Deficit Electives Courses"; Integer)
        {
            Caption = 'Deficit Electives Courses';
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
        }
        field(102; "Missed Exam"; Boolean)
        {
            Caption = 'Missed Exam';
            DataClassification = CustomerContent;
        }
        field(103; "Missed Both CAT & Exam"; Boolean)
        {
            Caption = 'Missed Both CAT & Exam';
            DataClassification = CustomerContent;
        }
        field(104; "Grade"; Code[20])
        {
            Caption = 'Grade';
            DataClassification = CustomerContent;
        }
        field(105; "Remarks"; Text[100])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(106; "Override Remarks"; Boolean)
        {
            Caption = 'Override Remarks';
            DataClassification = CustomerContent;
        }
        field(107; "Exam category"; Code[20])
        {
            Caption = 'Exam category';
            DataClassification = CustomerContent;
        }
        field(108; "Average"; Decimal)
        {
            Caption = 'Average';
            DataClassification = CustomerContent;
        }
        field(109; "Supp Exists"; Boolean)
        {
            Caption = 'Supp Exists';
            DataClassification = CustomerContent;
        }
        field(110; "Total Courses Passed"; Integer)
        {
            Caption = 'Total Courses Passed';
            DataClassification = CustomerContent;
        }
        field(111; "Total Units Passed"; Decimal)
        {
            Caption = 'Total Units Passed';
            DataClassification = CustomerContent;
        }
        field(112; "Exists DTSC Prefix"; Boolean)
        {
            Caption = 'Exists DTSC Prefix';
            DataClassification = CustomerContent;
        }
        field(113; "Graduation Academic Year"; Code[20])
        {
            Caption = 'Graduation Academic Year';
            DataClassification = CustomerContent;
        }
        field(114; "Special Exists"; Boolean)
        {
            Caption = 'Special Exists';
            DataClassification = CustomerContent;
        }
        field(115; "Exists a Failed Supp."; Boolean)
        {
            Caption = 'Exists a Failed Supp.';
            DataClassification = CustomerContent;
        }
        field(116; "Exists a Failed Special"; Boolean)
        {
            Caption = 'Exists a Failed Special';
            DataClassification = CustomerContent;
        }
        field(117; "Supp. Registration Exists"; Boolean)
        {
            Caption = 'Supp. Registration Exists';
            DataClassification = CustomerContent;
        }
        field(121; "Supp/Special Exists"; Boolean)
        {
            Caption = 'Supp/Special Exists';
            DataClassification = CustomerContent;
        }
        field(123; "Allow View of Results"; Boolean)
        {
            Caption = 'Allow View of Results';
            DataClassification = CustomerContent;
        }
        field(124; "Special Registration Exists"; Boolean)
        {
            Caption = 'Special Registration Exists';
            DataClassification = CustomerContent;
        }
        field(125; "Academic Year Exclude Comp."; Boolean)
        {
            Caption = 'Academic Year Exclude Comp.';
            DataClassification = CustomerContent;
        }
        field(126; "Supp or Special Exists"; Boolean)
        {
            Caption = 'Supp or Special Exists';
            DataClassification = CustomerContent;
        }
        field(127; "Defined Units (Flow)"; Integer)
        {
            Caption = 'Defined Units (Flow)';
            DataClassification = CustomerContent;
        }
        field(63032; "Special Programme Class"; Option)
        {
            Caption = 'Special Programme Class';
            DataClassification = CustomerContent;
            OptionMembers = " ";
        }
        field(63033; "Skip Supplementary Generation"; Boolean)
        {
            Caption = 'Skip Supplementary Generation';
            DataClassification = CustomerContent;
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