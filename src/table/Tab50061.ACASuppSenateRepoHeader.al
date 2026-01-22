table 50061 "ACA-SuppSenate Repo. Header"
{
    Caption = 'ACA-SuppSenate Repo. Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "ACA-Academic Year".Code;
        }
        field(2; "School Code"; Code[20])
        {
            Caption = 'School Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('FACULTY'));
        }
        field(3; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = CustomerContent;
        }
        field(4; "Classification Code"; Code[20])
        {
            Caption = 'Classification Code';
            DataClassification = CustomerContent;
        }
        field(5; "School Classification Count"; Integer)
        {
            Caption = 'School Classification Count';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       "Year of Study" = FIELD("Year of Study")));
            FieldClass = FlowField;
        }
        field(6; "School Total Passed"; Integer)
        {
            Caption = 'School Total Passed';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       "Final Classification Pass" = FILTER(true)));
            FieldClass = FlowField;
        }
        field(7; "School Total Failed"; Integer)
        {
            Caption = 'School Total Failed';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       "Final Classification Pass" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(8; "School % Passed"; Decimal)
        {
            Caption = 'School % Passed';
            DataClassification = CustomerContent;
        }
        field(9; "School % Failed"; Decimal)
        {
            Caption = 'School % Failed';
            DataClassification = CustomerContent;
        }
        field(10; "Calss Caption"; Code[100])
        {
            Caption = 'Calss Caption';
            DataClassification = CustomerContent;
        }
        field(11; "Programme Code"; Code[20])
        {
            Caption = 'Programme Code';
            DataClassification = CustomerContent;
            TableRelation = "ACA-Programme".Code;
        }
        field(12; "Programme Classification Count"; Integer)
        {
            Caption = 'Programme Classification Count';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       Programme = FIELD("Programme Code")));
            FieldClass = FlowField;
        }
        field(13; "Programme Total Passed"; Integer)
        {
            Caption = 'Programme Total Passed';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       "Final Classification Pass" = FILTER(true),
                                                                       Programme = FIELD("Programme Code")));
            FieldClass = FlowField;
        }
        field(14; "Programme Total Failed"; Integer)
        {
            Caption = 'Programme Total Failed';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       "Final Classification Pass" = FILTER(false),
                                                                       Programme = FIELD("Programme Code")));
            FieldClass = FlowField;
        }
        field(15; "Programme % Passed"; Decimal)
        {
            Caption = 'Programme % Passed';
            DataClassification = CustomerContent;
        }
        field(16; "Programme % Failed"; Decimal)
        {
            Caption = 'Programme % Failed';
            DataClassification = CustomerContent;
        }
        field(17; "Prog. Class % Value"; Decimal)
        {
            Caption = 'Prog. Class % Value';
            DataClassification = CustomerContent;
        }
        field(18; "Sch. Class % Value"; Decimal)
        {
            Caption = 'Sch. Class % Value';
            DataClassification = CustomerContent;
        }
        field(19; "School Total Count"; Integer)
        {
            Caption = 'School Total Count';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code")));
            FieldClass = FlowField;
        }
        field(20; "Prog. Total Count"; Integer)
        {
            Caption = 'Prog. Total Count';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Programme = FIELD("Programme Code")));
            FieldClass = FlowField;
        }
        field(21; "Prog_AcadYear_Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE(Programme = FIELD("Programme Code"),
                                                                      "Academic Year" = FIELD("Academic Year"),
                                                                      Classification = FILTER(<> ''),
                                                                      "Year of Study" = FIELD("Year of Study")));
            Caption = 'Prog_AcadYear_Count';
        }
        field(22; "Prog_AcadYear_Status_Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE(Programme = FIELD("Programme Code"),
                                                                      "School Code" = FIELD("School Code"),
                                                                      "Academic Year" = FIELD("Academic Year"),
                                                                      Classification = FIELD("Classification Code"),
                                                                      "Year of Study" = FIELD("Year of Study")));
            Caption = 'Prog_AcadYear_Status_Count';
        }
        field(23; "Prog_AcadYearTrans_Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE(Programme = FIELD("Programme Code"),
                                                                      "School Code" = FIELD("School Code"),
                                                                      "Academic Year" = FIELD("Academic Year"),
                                                                      "Year of Study" = FIELD("Year of Study"),
                                                                      "Final Classification Pass" = FILTER(true)));
            Caption = 'Prog_AcadYearTrans_Count';
        }
        field(24; "ProgCat_AcadYear_BarcCo"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE(Programme = FIELD("Programme Code"),
                                                                      "School Code" = FIELD("School Code"),
                                                                      "Academic Year" = FIELD("Academic Year"),
                                                                      Classification = FILTER(<> ''),
                                                                      "Year of Study" = FIELD("Year of Study"),
                                                                      "Prog. Category" = FILTER(Undergraduate)));
            Caption = 'ProgCat_AcadYear_BarcCo';
        }
        field(25; "ProgCat_AcadYear_Status_BarcCo"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE(Programme = FIELD("Programme Code"),
                                                                      "School Code" = FIELD("School Code"),
                                                                      "Academic Year" = FIELD("Academic Year"),
                                                                      Classification = FIELD("Classification Code"),
                                                                      "Year of Study" = FIELD("Year of Study"),
                                                                      "Prog. Category" = FILTER(Undergraduate)));
            Caption = 'ProgCat_AcadYear_Status_BarcCo';
        }
        field(26; "ProgCat_AcadYearTrans_BarcCo"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE(Programme = FIELD("Programme Code"),
                                                                      "School Code" = FIELD("School Code"),
                                                                      "Academic Year" = FIELD("Academic Year"),
                                                                      "Year of Study" = FIELD("Year of Study"),
                                                                      "Final Classification Pass" = FILTER(true),
                                                                      "Prog. Category" = FILTER(Undergraduate)));
            Caption = 'ProgCat_AcadYearTrans_BarcCo';
        }
        field(27; "ProgCat_AcadYear_MasCo"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE(Programme = FIELD("Programme Code"),
                                                                      "School Code" = FIELD("School Code"),
                                                                      "Academic Year" = FIELD("Academic Year"),
                                                                      Classification = FILTER(<> ''),
                                                                      "Year of Study" = FIELD("Year of Study"),
                                                                      "Prog. Category" = FILTER(Postgraduate)));
            Caption = 'ProgCat_AcadYear_MasCo';
        }
        field(28; "ProgCat_AcadYear_Status_MasCo"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE(Programme = FIELD("Programme Code"),
                                                                      "School Code" = FIELD("School Code"),
                                                                      "Academic Year" = FIELD("Academic Year"),
                                                                      Classification = FIELD("Classification Code"),
                                                                      "Year of Study" = FIELD("Year of Study"),
                                                                      "Prog. Category" = FILTER(Postgraduate)));
            Caption = 'ProgCat_AcadYear_Status_MasCo';
        }
        field(29; "ProgCat_AcadYearTrans_MascCo"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE(Programme = FIELD("Programme Code"),
                                                                      "School Code" = FIELD("School Code"),
                                                                      "Academic Year" = FIELD("Academic Year"),
                                                                      "Year of Study" = FIELD("Year of Study"),
                                                                      "Final Classification Pass" = FILTER(true),
                                                                      "Prog. Category" = FILTER(Postgraduate)));
            Caption = 'ProgCat_AcadYearTrans_MascCo';
        }
        field(30; "ProgCat_AcadYear_DipCo"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE(Programme = FIELD("Programme Code"),
                                                                      "School Code" = FIELD("School Code"),
                                                                      "Academic Year" = FIELD("Academic Year"),
                                                                      Classification = FILTER(<> ''),
                                                                      "Year of Study" = FIELD("Year of Study"),
                                                                      "Prog. Category" = FILTER(Diploma)));
            Caption = 'ProgCat_AcadYear_DipCo';
        }
        field(31; "ProgCat_AcadYear_Status_DipCo"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE(Programme = FIELD("Programme Code"),
                                                                      "School Code" = FIELD("School Code"),
                                                                      "Academic Year" = FIELD("Academic Year"),
                                                                      Classification = FIELD("Classification Code"),
                                                                      "Year of Study" = FIELD("Year of Study"),
                                                                      "Prog. Category" = FILTER(Diploma)));
            Caption = 'ProgCat_AcadYear_Status_DipCo';
        }
        field(32; "ProgCat_AcadYearTrans_DipCo"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE(Programme = FIELD("Programme Code"),
                                                                      "School Code" = FIELD("School Code"),
                                                                      "Academic Year" = FIELD("Academic Year"),
                                                                      "Year of Study" = FIELD("Year of Study"),
                                                                      "Final Classification Pass" = FILTER(true),
                                                                      "Prog. Category" = FILTER(Diploma)));
            Caption = 'ProgCat_AcadYearTrans_DipCo';
        }
        field(33; "ProgCat_AcadYear_CertCo"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE(Programme = FIELD("Programme Code"),
                                                                      "School Code" = FIELD("School Code"),
                                                                      "Academic Year" = FIELD("Academic Year"),
                                                                      Classification = FILTER(<> ''),
                                                                      "Year of Study" = FIELD("Year of Study"),
                                                                      "Prog. Category" = FILTER(Certificate | Professional | "Course List")));
            Caption = 'ProgCat_AcadYear_CertCo';
        }
        field(34; "ProgCat_AcadYear_Status_CertCo"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE(Programme = FIELD("Programme Code"),
                                                                      "School Code" = FIELD("School Code"),
                                                                      "Academic Year" = FIELD("Academic Year"),
                                                                      Classification = FIELD("Classification Code"),
                                                                      "Year of Study" = FIELD("Year of Study"),
                                                                      "Prog. Category" = FILTER(Certificate | Professional | "Course List")));
            Caption = 'ProgCat_AcadYear_Status_CertCo';
        }
        field(35; "ProgCat_AcadYearTrans_CertCo"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE(Programme = FIELD("Programme Code"),
                                                                      "School Code" = FIELD("School Code"),
                                                                      "Academic Year" = FIELD("Academic Year"),
                                                                      "Year of Study" = FIELD("Year of Study"),
                                                                      "Final Classification Pass" = FILTER(true),
                                                                      "Prog. Category" = FILTER(Certificate | Professional | "Course List")));
            Caption = 'ProgCat_AcadYearTrans_CertCo';
        }
        field(50005; "Status Msg6"; Text[250])
        {
            Caption = 'Status Msg6';
            DataClassification = CustomerContent;
        }
        field(50006; "IncludeVariable 1"; Boolean)
        {
            Caption = 'IncludeVariable 1';
            DataClassification = CustomerContent;
        }
        field(50007; "IncludeVariable 2"; Boolean)
        {
            Caption = 'IncludeVariable 2';
            DataClassification = CustomerContent;
        }
        field(50008; "IncludeVariable 3"; Boolean)
        {
            Caption = 'IncludeVariable 3';
            DataClassification = CustomerContent;
        }
        field(50009; "IncludeVariable 4"; Boolean)
        {
            Caption = 'IncludeVariable 4';
            DataClassification = CustomerContent;
        }
        field(50010; "IncludeVariable 5"; Boolean)
        {
            Caption = 'IncludeVariable 5';
            DataClassification = CustomerContent;
        }
        field(50011; "IncludeVariable 6"; Boolean)
        {
            Caption = 'IncludeVariable 6';
            DataClassification = CustomerContent;
        }
        field(50020; "Status Msg1"; Text[200])
        {
            Caption = 'Status Msg1';
            DataClassification = CustomerContent;
        }
        field(50021; "Status Msg2"; Text[200])
        {
            Caption = 'Status Msg2';
            DataClassification = CustomerContent;
        }
        field(50022; "Status Msg3"; Text[200])
        {
            Caption = 'Status Msg3';
            DataClassification = CustomerContent;
        }
        field(50023; "Status Msg4"; Text[200])
        {
            Caption = 'Status Msg4';
            DataClassification = CustomerContent;
        }
        field(50024; "Status Msg5"; Text[200])
        {
            Caption = 'Status Msg5';
            DataClassification = CustomerContent;
        }
        field(63021; "Summary Page Caption"; Text[200])
        {
            Caption = 'Summary Page Caption';
            DataClassification = CustomerContent;
        }
        field(63022; "Include Failed Units Headers"; Boolean)
        {
            Caption = 'Include Failed Units Headers';
            DataClassification = CustomerContent;
        }
        field(63028; "Include Academic Year Caption"; Boolean)
        {
            Caption = 'Include Academic Year Caption';
            DataClassification = CustomerContent;
        }
        field(63029; "Academic Year Text"; Text[250])
        {
            Caption = 'Academic Year Text';
            DataClassification = CustomerContent;
        }
        field(63030; "Rubric Order"; Integer)
        {
            Caption = 'Rubric Order';
            DataClassification = CustomerContent;
        }
        field(63031; "Year of Study"; Integer)
        {
            Caption = 'Year of Study';
            DataClassification = CustomerContent;
        }
        field(63032; "School_AcadYear_Count"; Integer)
        {
            Caption = 'School_AcadYear_Count';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FILTER(<> ''),
                                                                       "Year of Study" = FIELD("Year of Study")));
            FieldClass = FlowField;
        }
        field(63033; "School_AcadYear_Status_Count"; Integer)
        {
            Caption = 'School_AcadYear_Status_Count';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       "Year of Study" = FIELD("Year of Study")));
            FieldClass = FlowField;
        }
        field(63051; "1st Year Grad. Comments"; Text[200])
        {
            Caption = '1st Year Grad. Comments';
            DataClassification = CustomerContent;
        }
        field(63052; "2nd Year Grad. Comments"; Text[200])
        {
            Caption = '2nd Year Grad. Comments';
            DataClassification = CustomerContent;
        }
        field(63053; "3rd Year Grad. Comments"; Text[200])
        {
            Caption = '3rd Year Grad. Comments';
            DataClassification = CustomerContent;
        }
        field(63054; "4th Year Grad. Comments"; Text[200])
        {
            Caption = '4th Year Grad. Comments';
            DataClassification = CustomerContent;
        }
        field(63055; "5th Year Grad. Comments"; Text[200])
        {
            Caption = '5th Year Grad. Comments';
            DataClassification = CustomerContent;
        }
        field(63056; "6th Year Grad. Comments"; Text[200])
        {
            Caption = '6th Year Grad. Comments';
            DataClassification = CustomerContent;
        }
        field(63057; "7th Year Grad. Comments"; Text[200])
        {
            Caption = '7th Year Grad. Comments';
            DataClassification = CustomerContent;
        }
        field(63058; "Finalists Graduation Comments"; Text[200])
        {
            Caption = 'Finalists Graduation Comments';
            DataClassification = CustomerContent;
        }
        field(63059; "Grad. Status Msg 1"; Text[250])
        {
            Caption = 'Grad. Status Msg 1';
            DataClassification = CustomerContent;
        }
        field(63060; "Grad. Status Msg 2"; Text[250])
        {
            Caption = 'Grad. Status Msg 2';
            DataClassification = CustomerContent;
        }
        field(63061; "Grad. Status Msg 3"; Text[250])
        {
            Caption = 'Grad. Status Msg 3';
            DataClassification = CustomerContent;
        }
        field(63062; "Grad. Status Msg 4"; Text[250])
        {
            Caption = 'Grad. Status Msg 4';
            DataClassification = CustomerContent;
        }
        field(63063; "Grad. Status Msg 5"; Text[250])
        {
            Caption = 'Grad. Status Msg 5';
            DataClassification = CustomerContent;
        }
        field(63064; "Grad. Status Msg 6"; Text[250])
        {
            Caption = 'Grad. Status Msg 6';
            DataClassification = CustomerContent;
        }
        field(63065; "School_AcadYearTrans_Count"; Integer)
        {
            Caption = 'School_AcadYearTrans_Count';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Final Classification Pass" = FILTER(true)));
            FieldClass = FlowField;
        }
        field(63066; "Reporting Academic Year"; Code[20])
        {
            Caption = 'Reporting Academic Year';
            DataClassification = CustomerContent;
        }
        field(63067; "SchCat_AcadYear_BarcCo"; Integer)
        {
            Caption = 'SchCat_AcadYear_BarcCo';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FILTER(<> ''),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Prog. Category" = FILTER("Undergraduate")));
            FieldClass = FlowField;
        }
        field(63068; "SchCat_AcadYear_Status_BarcCo"; Integer)
        {
            Caption = 'SchCat_AcadYear_Status_BarcCo';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Prog. Category" = FILTER('Undergraduate')));
            FieldClass = FlowField;
        }
        field(63069; "SchCat_AcadYearTrans_BarcCo"; Integer)
        {
            Caption = 'SchCat_AcadYearTrans_BarcCo';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Final Classification Pass" = FILTER(true),
                                                                       "Prog. Category" = FILTER('Undergraduate')));
            FieldClass = FlowField;
        }
        field(63070; "SchCat_AcadYear_MasCo"; Integer)
        {
            Caption = 'SchCat_AcadYear_MasCo';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FILTER(<> ''),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Prog. Category" = FILTER('Postgraduate')));
            FieldClass = FlowField;
        }
        field(63071; "SchCat_AcadYear_Status_MasCo"; Integer)
        {
            Caption = 'SchCat_AcadYear_Status_MasCo';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Prog. Category" = FILTER('Postgraduate')));
            FieldClass = FlowField;
        }
        field(63072; "SchCat_AcadYearTrans_MascCo"; Integer)
        {
            Caption = 'SchCat_AcadYearTrans_MascCo';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Final Classification Pass" = FILTER(true),
                                                                       "Prog. Category" = FILTER('Postgraduate')));
            FieldClass = FlowField;
        }
        field(63073; "SchCat_AcadYear_DipCo"; Integer)
        {
            Caption = 'SchCat_AcadYear_DipCo';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FILTER(<> ''),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Prog. Category" = FILTER('Diploma')));
            FieldClass = FlowField;
        }
        field(63074; "SchCat_AcadYear_Status_DipCo"; Integer)
        {
            Caption = 'SchCat_AcadYear_Status_DipCo';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Prog. Category" = FILTER('Diploma')));
            FieldClass = FlowField;
        }
        field(63075; "SchCat_AcadYearTrans_DipCo"; Integer)
        {
            Caption = 'SchCat_AcadYearTrans_DipCo';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Final Classification Pass" = FILTER(true),
                                                                       "Prog. Category" = FILTER('Diploma')));
            FieldClass = FlowField;
        }
        field(63076; "SchCat_AcadYear_CertCo"; Integer)
        {
            Caption = 'SchCat_AcadYear_CertCo';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FILTER(<> ''),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Prog. Category" = FILTER('Certificate|Professional|"Course List"')));
            FieldClass = FlowField;
        }
        field(63077; "SchCat_AcadYear_Status_CertCo"; Integer)
        {
            Caption = 'SchCat_AcadYear_Status_CertCo';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       Classification = FIELD("Classification Code"),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Prog. Category" = FILTER('Certificate|Professional|"Course List"')));
            FieldClass = FlowField;
        }
        field(63078; "SchCat_AcadYearTrans_CertCo"; Integer)
        {
            Caption = 'SchCat_AcadYearTrans_CertCo';
            CalcFormula = Count("ACA-Exam. Course Registration" WHERE("School Code" = FIELD("School Code"),
                                                                       "Academic Year" = FIELD("Academic Year"),
                                                                       "Year of Study" = FIELD("Year of Study"),
                                                                       "Final Classification Pass" = FILTER(true),
                                                                       "Prog. Category" = FILTER('Certificate|Professional|"Course List"')));
            FieldClass = FlowField;
        }
        field(63079; "Category"; Option)
        {
            Caption = 'Category';
            CalcFormula = Lookup("ACA-Programme".Category WHERE(Code = FIELD("Programme Code")));
            FieldClass = FlowField;
            OptionMembers = ,Certificate,Diploma,Undergraduate,Postgraduate,Professional,"Course List";
        }
    }

    keys
    {
        key(PK; "Academic Year", "School Code", "Department Code", "Classification Code", "Programme Code")
        {
            Clustered = true;
        }
    }
}