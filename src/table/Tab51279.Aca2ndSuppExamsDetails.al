table 51279 "Aca-2nd Supp. Exams Details"
{
    Caption = 'Aca-2nd Supp. Exams Details';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
        }
        field(2; Semester; Code[20])
        {
            Caption = 'Semester';
        }
        field(3; "Exam Session"; Code[20])
        {
            Caption = 'Exam Session';
        }
        field(4; "Student No."; Code[20])
        {
            Caption = 'Student No.';
        }
        field(5; Stage; Code[20])
        {
            Caption = 'Stage';
        }
        field(6; Programme; Code[20])
        {
            Caption = 'Programme';
        }
        field(7; "Unit Code"; Code[20])
        {
            Caption = 'Unit Code';
            trigger OnValidate()
            begin
                IF GENGeneralSetUp.FIND('-') THEN BEGIN
                    IF GENGeneralSetUp."Special Exam Fee" <> 0 THEN "Cost Per Exam" := GENGeneralSetUp."Special Exam Fee";
                END;
                IF Category = Category::Supplementary THEN BEGIN
                    ACAAcademicYear.RESET;
                    ACAAcademicYear.SETRANGE(Current, TRUE);
                    IF ACAAcademicYear.FIND('-') THEN BEGIN
                        Rec."Current Academic Year" := ACAAcademicYear.Code;
                    END;
                    ACAStudentUnits.RESET;
                    ACAStudentUnits.SETRANGE(Unit, Rec."Unit Code");
                    ACAStudentUnits.SETRANGE("Student No.", Rec."Student No.");
                    IF ACAStudentUnits.FIND('+') THEN BEGIN
                        "Academic Year" := ACAStudentUnits."Academic Year";
                        Semester := ACAStudentUnits.Semester;
                        Stage := ACAStudentUnits.Stage;
                        Programme := ACAStudentUnits.Programme;
                        Category := Rec.Category::Supplementary;
                    END ELSE
                        ERROR('The unit selected is not available for Supplementary');
                END;
            end;
        }
        field(8; "Unit Description"; Text[150])
        {
            Caption = 'Unit Description';
            FieldClass=FlowField;
            CalcFormula=Lookup("ACA-Units/Subjects".Desription WHERE ("Programme Code"=FIELD(Programme),Code=FIELD("Unit Code")));
        }
        field(10; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = New,Approved,Rejected;
        }
        field(11; "CAT Marks"; Decimal)
        {
            Caption = 'CAT Marks';
            DecimalPlaces = 2 : 2;
        }
        field(12; "Exam Marks"; Decimal)
        {
            Caption = 'Exam Marks';
            DecimalPlaces = 2 : 2;
        }
        field(13; "Total Marks"; Decimal)
        {
            Caption = 'Total Marks';
            DecimalPlaces = 2 : 2;
        }
        field(14; Grade; Code[10])
        {
            Caption = 'Grade';
        }
        field(15; "Cost Per Exam"; Decimal)
        {
            Caption = 'Cost Per Exam';
            DecimalPlaces = 2 : 2;
        }
        field(16; Category; Option)
        {
            Caption = 'Category';
            OptionMembers = " ",Special,Supplementary;
            OptionCaption = ' ,Special,Supplementary';
        }
        field(17; "Current Academic Year"; Code[20])
        {
            Caption = 'Current Academic Year';
        }
        field(18; "Marks Exists"; Boolean)
        {
            Caption = 'Marks Exists';
            FieldClass=FlowField;
            CalcFormula=Exist("Aca-Special Exams Results" WHERE ("Student No."=FIELD("Student No."),Unit=FIELD("Unit Code"),Semester=FIELD(Semester)));
        }
        field(19; Sequence; Integer)
        {
            Caption = 'Sequence';
        }
        field(20; "Special Exam Reason"; Code[20])
        {
            Caption = 'Special Exam Reason';
        }
        field(21; "Current Semester"; Code[20])
        {
            Caption = 'Current Semester';
        }
        field(22; "Charge Posted"; Boolean)
        {
            Caption = 'Charge Posted';
        }
        field(23; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(25; "Created Date/Time"; DateTime)
        {
            Caption = 'Created Date/Time';
            Editable = false;
        }
        field(26; "Last Edited By"; Code[50])
        {
            Caption = 'Last Edited By';
            Editable = false;
        }
        field(27; "Last Edited Date/Time"; DateTime)
        {
            Caption = 'Last Edited Date/Time';
            Editable = false;
        }
        field(28; "Original Marks"; Decimal)
        {
            Caption = 'Original Marks';
            DecimalPlaces = 2 : 2;
        }
        field(29; "New Mark"; Decimal)
        {
            Caption = 'New Mark';
            DecimalPlaces = 2 : 2;
        }
        field(42; "Semester flow"; Code[20])
        {
            Caption = 'Semester flow';
            FieldClass=FlowField;
            CalcFormula=Lookup("ACA-Student Units".Semester WHERE ("Student No."=FIELD("Student No."),Programme=FIELD(Programme),Unit=FIELD("Unit Code"),"Reg. Reversed"=FILTER(false)));
        }
        field(43; "Academic Year (Flow)"; Code[20])
        {
            Caption = 'Academic Year (Flow)';
            FieldClass=FlowField;
            CalcFormula=Lookup("ACA-Semesters"."Academic Year" WHERE (Code=FIELD(Semester)));
        }
    }

    keys
    {
        key(PK; "Student No.", "Unit Code", "Academic Year", Semester, Sequence)
        {
            Clustered = true;
        }
        key(IX1; Sequence)
        {
        }
    }
    var
        GENGeneralSetUp: Record "ACA-General Set-Up";
        ACAAcademicYear: Record "ACA-Academic Year";
        ACAStudentUnits: Record "ACA-Student Units";


    trigger OnInsert()
    begin
        ACAAcademicYear.RESET;
        ACAAcademicYear.SETRANGE(Current, TRUE);
        IF ACAAcademicYear.FIND('-') THEN BEGIN
            Rec."Current Academic Year" := ACAAcademicYear.Code;
        END;
        "Created By" := UserId;
        "Created Date/Time" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        "Last Edited By" := UserId;
        "Last Edited Date/Time" := CurrentDateTime;
    end;

    trigger OnDelete()
    begin
        IF Rec."Charge Posted" THEN ERROR('Charge Posted. Deletion is not allowed!.');
    end;
}
