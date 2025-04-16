table 51303 "ACA-SuppExam Class. Units"
{
    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = Customer."No.";
        }
        field(2; "Programme"; Code[20])
        {
            Caption = 'Programme';
            TableRelation = "ACA-Programme".Code;
        }
        field(3; "Unit Code"; Code[20])
        {
            Caption = 'Unit Code';
            TableRelation = "ACA-Units/Subjects".Code WHERE("Programme Code" = FIELD(Programme));
        }
        field(4; "Unit Description"; Text[150])
        {
            Caption = 'Unit Description';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Units/Subjects".Desription WHERE("Programme Code" = FIELD(Programme),
                                                                      Code = FIELD("Unit Code")));
        }
        field(5; "Credit Hours"; Decimal)
        {
            Caption = 'Credit Hours';
        }
        field(6; "CAT Score"; Code[20])
        {
            Caption = 'CAT Score';
        }
        field(7; "Exam Score"; Code[20])
        {
            Caption = 'Exam Score';
        }
        field(8; "Total Score"; Code[20])
        {
            Caption = 'Total Score';
        }
        field(9; "Allow In Graduate"; Boolean)
        {
            Caption = 'Allow In Graduate';
        }
        field(10; "Unit Type"; Code[20])
        {
            Caption = 'Unit Type';
        }
        field(11; "Pass"; Boolean)
        {
            Caption = 'Pass';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Exam Grading Source".Pass WHERE("Academic Year" = FIELD("Academic Year"), "Exam Catregory" = FIELD("Exam Category"), "Total Score" = FIELD("Total Score Decimal"), "Results Exists Status" = FIELD("Results Exists Status")));
        }
        field(12; "Course Cat. Presidence"; Integer)
        {
            Caption = 'Course Cat. Presidence';
        }
        field(13; "Year of Study"; Integer)
        {
            Caption = 'Year of Study';
        }
        field(14; "Exam Score Decimal"; Decimal)
        {
            Caption = 'Exam Score Decimal';
            DecimalPlaces = 2 : 2;
        }
        field(15; "CAT Score Decimal"; Decimal)
        {
            Caption = 'CAT Score Decimal';
            DecimalPlaces = 2 : 2;
        }
        field(16; "Total Score Decimal"; Decimal)
        {
            Caption = 'Total Score Decimal';
            DecimalPlaces = 2 : 2;
        }
        field(17; "Weighted Total Score"; Decimal)
        {
            Caption = 'Weighted Total Score';
            DecimalPlaces = 2 : 2;
        }
        field(18; "Grade"; Code[20])
        {
            Caption = 'Grade';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Exam Grading Source".Grade WHERE("Academic Year" = FIELD("Academic Year"), "Exam Catregory" = FIELD("Exam Category"), "Total Score" = FIELD("Total Score Decimal"), "Results Exists Status" = FIELD("Results Exists Status")));
        }
        field(19; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "ACA-Academic Year".Code;
        }
        field(54; "Cohort"; Code[20])
        {
            Caption = 'Cohort';
        }
        field(55; "Use In Classification"; Boolean)
        {
            Caption = 'Use In Classification';
        }
        field(56; "Unit Exists"; Boolean)
        {
            Caption = 'Unit Exists';
            FieldClass = FlowField;
            CalcFormula = Exist("ACA-Units/Subjects" WHERE("Programme Code" = FIELD(Programme),
                                                          Code = FIELD("Unit Code")));
        }
        field(57; "Results Exists Status"; Option)
        {
            Caption = 'Results Exists Status';
            OptionMembers = " ","None Exists","CAT Only","Exam Only","Both Exists";
            OptionCaption = ' ,None Exists,CAT Only,Exam Only,Both Exists';
        }
        field(58; "No. of Resits"; Integer)
        {
            Caption = 'No. of Resits';
        }
        field(59; "No. of Repeats"; Integer)
        {
            Caption = 'No. of Repeats';
        }
        field(60; "School Code"; Code[20])
        {
            Caption = 'School Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('FACULTY'));
        }
        field(61; "Department Code"; Code[10])
        {
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
        }
        field(62; "Grade Comment"; Text[50])
        {
            Caption = 'Grade Comment';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Exam Grading Source".Remarks WHERE("Academic Year" = FIELD("Academic Year"),
                                                                        "Exam Catregory" = FIELD("Exam Category"),
                                                                        "Total Score" = FIELD("Total Score Decimal"),
                                                                        "Results Exists Status" = FIELD("Results Exists Status")));
        }
        field(63; "Comsolidated Prefix"; Text[30])
        {
            Caption = 'Comsolidated Prefix';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Exam Grading Source"."Consolidated Prefix" WHERE("Academic Year" = FIELD("Academic Year"),
                                                                                      "Exam Catregory" = FIELD("Exam Category"),
                                                                                      "Total Score" = FIELD("Total Score Decimal"),
                                                                                      "Results Exists Status" = FIELD("Results Exists Status")));
        }
        field(64; "Is a Resit/Repeat"; Boolean)
        {
            Caption = 'Is a Resit/Repeat';
            FieldClass = FlowField;
            CalcFormula = Exist("Aca-Special Exams Details" WHERE("Student No." = FIELD("Student No."),
                                                                  Programme = FIELD(Programme),
                                                                  "Unit Code" = FIELD("Unit Code")));
        }
        field(65; "Exam Category"; Code[20])
        {
            Caption = 'Exam Category';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Units/Subjects"."Exam Category" WHERE("Programme Code" = FIELD(Programme),
                                                                           Code = FIELD("Unit Code")));
        }
        field(66; "Reporting Academic Year"; Code[20])
        {
            Caption = 'Reporting Academic Year';
            TableRelation = "ACA-Academic Year".Code;
        }
        field(67; "Lost"; Code[10])
        {
            Caption = 'Lost';
        }
        field(68; "Is Supp. Unit"; Boolean)
        {
            Caption = 'Is Supp. Unit';
            FieldClass = FlowField;
            CalcFormula = Exist("Aca-Special Exams Details" WHERE("Student No." = FIELD("Student No."),
                                                                  "Unit Code" = FIELD("Unit Code"),
                                                                  Category = FILTER(Supplementary)));
        }
        field(69; "Special Unit Reason"; Code[20])
        {
            Caption = 'Special Unit Reason';
        }
        field(70; "Unit Stage"; Code[20])
        {
            Caption = 'Unit Stage';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Units/Subjects"."Stage Code" WHERE("Programme Code" = FIELD(Programme),
                                                                         Code = FIELD("Unit Code")));
        }
        field(71; "Is Special Unit"; Boolean)
        {
            Caption = 'Is Special Unit';
            FieldClass = FlowField;
            CalcFormula = Exist("Aca-Special Exams Details" WHERE("Student No." = FIELD("Student No."),
                                                                  "Unit Code" = FIELD("Unit Code"),
                                                                  Category = FILTER(Special)));
        }
        field(72; "Is Supp/Special"; Boolean)
        {
            Caption = 'Is Supp/Special';
            FieldClass = FlowField;
            CalcFormula = Exist("Aca-Special Exams Details" WHERE("Student No." = FIELD("Student No."),
                                                                  "Unit Code" = FIELD("Unit Code"),
                                                                  "Academic Year" = FIELD("Academic Year")));
        }
        field(73; "Is Retake"; Boolean)
        {
            Caption = 'Is Retake';
            FieldClass = FlowField;
            CalcFormula = Exist("Aca-Special Exams Details" WHERE("Student No." = FIELD("Student No."),
                                                                  "Unit Code" = FIELD("Unit Code"),
                                                                  Category = FILTER(Retake)));
        }
    }

    keys
    {
        key(PK; "Student No.", "Programme", "Unit Code")
        {
            Clustered = true;
        }
    }
}
