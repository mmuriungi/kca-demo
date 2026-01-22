table 52179107 "Audit Resource Allocation"
{
    Caption = 'Audit Resource Allocation';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Allocation No."; Code[20])
        {
            Caption = 'Allocation No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Audit No."; Code[20])
        {
            Caption = 'Audit No.';
            TableRelation = "Audit Header"."No." WHERE(Type = CONST(Audit));
            DataClassification = ToBeClassified;
        }
        field(3; "Resource Type"; Option)
        {
            Caption = 'Resource Type';
            OptionMembers = Auditor,Equipment,Facility,External;
            OptionCaption = 'Auditor,Equipment,Facility,External';
            DataClassification = ToBeClassified;
        }
        field(4; "Resource Code"; Code[50])
        {
            Caption = 'Resource Code';
            DataClassification = ToBeClassified;
        }
        field(5; "Resource Name"; Text[100])
        {
            Caption = 'Resource Name';
            DataClassification = ToBeClassified;
        }
        field(6; "Allocation Start Date"; Date)
        {
            Caption = 'Allocation Start Date';
            DataClassification = ToBeClassified;
        }
        field(7; "Allocation End Date"; Date)
        {
            Caption = 'Allocation End Date';
            DataClassification = ToBeClassified;
        }
        field(8; "Allocated Hours"; Decimal)
        {
            Caption = 'Allocated Hours';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(9; "Actual Hours"; Decimal)
        {
            Caption = 'Actual Hours';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(10; "Utilization %"; Decimal)
        {
            Caption = 'Utilization %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(11; "Cost Rate"; Decimal)
        {
            Caption = 'Cost Rate';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(12; "Total Cost"; Decimal)
        {
            Caption = 'Total Cost';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(13; "Actual Cost"; Decimal)
        {
            Caption = 'Actual Cost';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0:2;
        }
        field(14; "Allocation Status"; Option)
        {
            Caption = 'Allocation Status';
            OptionMembers = Planned,Confirmed,Active,Completed,Cancelled;
            OptionCaption = 'Planned,Confirmed,Active,Completed,Cancelled';
            DataClassification = ToBeClassified;
        }
        field(15; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = ToBeClassified;
        }
        field(16; "Skill Required"; Text[100])
        {
            Caption = 'Skill Required';
            DataClassification = ToBeClassified;
        }
        field(17; "Comments"; Text[250])
        {
            Caption = 'Comments';
            DataClassification = ToBeClassified;
        }
        field(18; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    
    keys
    {
        key(PK; "Allocation No.")
        {
            Clustered = true;
        }
        key(Audit; "Audit No.", "Resource Type")
        {
        }
        key(Resource; "Resource Code", "Allocation Start Date")
        {
        }
        key(Status; "Allocation Status", "Allocation Start Date")
        {
        }
    }
    
    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created Date" := CurrentDateTime;
    end;
    
    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified Date" := CurrentDateTime;
    end;
}