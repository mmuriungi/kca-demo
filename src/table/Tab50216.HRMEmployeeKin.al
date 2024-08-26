table 50216 "HRM-Employee Kin"
{
    Caption = 'Employee Relative';

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Employee C"."No.";
        }
        field(2; Relationship; Code[20])
        {
            NotBlank = true;
            TableRelation = Relative.Code;
        }
        field(3; SurName; Text[50])
        {
            NotBlank = true;
        }
        field(17; Fullname; text[50])
        {
            trigger OnValidate()
            begin
                Fullname := "Other Names" + '' + SurName;
            end;
        }
        field(4; "Other Names"; Text[100])
        {
            NotBlank = true;
        }
        field(5; "ID No/Passport No"; Text[50])
        {
        }
        field(6; "Date Of Birth"; Date)
        {
        }
        field(7; Occupation; Text[100])
        {
        }
        field(18; gender; Option)
        {
            OptionMembers = "",Male,Female;


        }
        field(19; Age; code[10])
        {

        }
        field(8; Address; Text[250])
        {
        }
        field(9; "Office Tel No"; Text[100])
        {
        }
        field(10; "Home Tel No"; Text[50])
        {
        }
        field(11; Remarks; Text[250])
        {
        }
        field(12; Type; Option)
        {
            OptionMembers = "Next of Kin",Beneficiary,Dependant;
        }
        field(13; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(14; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE("Table Name" = CONST("Employee Relative"),
                                                                     "No." = FIELD("Employee Code"),
                                                                     "Table Line No." = FIELD("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Code"; Code[10])
        {
        }
        field(16; "Percentage(%)"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Percentage(%)" > 100 then
                    Error('The total Percentage for all Beneficiaries should not be more than 100%');
            end;
        }
        field(50000; "No."; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", SurName, "Other Names", "Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        HRCommentLine: Record "Human Resource Comment Line";
        EMP: Record "HRM-Employee C";
        kin: Record "HRM-Employee Kin";
    begin
        HRCommentLine.SetRange("Table Name", HRCommentLine."Table Name"::"Employee Relative");
        HRCommentLine.SetRange("No.", "Employee Code");
        HRCommentLine.DeleteAll;
    end;





}

