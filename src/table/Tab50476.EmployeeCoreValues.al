/// <summary>
/// Table Employee Core Values (ID 50047).
/// </summary>
table 50476 "Employee Core Values"
{
    Caption = 'Employee Core Values';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[100])
        {
            Caption = 'Code';
            TableRelation = "Core Values".code;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Corevalues.Reset();
                Corevalues.SetRange(code, rec.Code);
                if Corevalues.Find('-') then begin
                    Description := Corevalues.Description;
                end;
            end;
        }
        field(2; Description; Text[500])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }

        field(4; Period; Code[50])
        {
            Caption = 'Period';
            DataClassification = ToBeClassified;
        }
        field(5; "Employee No"; Code[100])
        {
            Caption = 'Employee No';
            DataClassification = ToBeClassified;
        }
        field(6; "Appraisal No"; Code[50])
        {
            Caption = 'Appraisal No';
            DataClassification = ToBeClassified;
        }
        field(3; "Self Assement"; code[50])
        {
            Caption = 'Self Assement';
            TableRelation = "Response Scales".Code;
            DataClassification = ToBeClassified;
        }
        field(8; "Supervisors Comment"; Text[500])
        {
            Caption = 'Supervisors Comment';
            DataClassification = ToBeClassified;
        }
        field(9; "Response Scale"; code[50])
        {
            Caption = 'Response Scale';
            TableRelation = "Response Scales".Code;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                response.Reset();
                response.SetRange(Code, rec."Response Scale");
                if response.Find('-') then begin
                    Rating := response.Rating;
                end;


            end;
        }
        field(7; Rating; Integer)
        {
            Caption = 'Rating';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Code", "Appraisal No", "Employee No", Period)
        {
            Clustered = true;
        }
    }
    var
        Corevalues: record "Core Values";
        response: record "Response Scales";
}
