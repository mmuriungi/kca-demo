table 50112 "FIN-Budget  Virement"
{
    Caption = 'FIN-Budget  Virement';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(3; "Budget Name"; Code[20])
        {
            Caption = 'Budget Name';
            TableRelation = "G/L Budget Name".Name WHERE(Blocked = filter(false));
        }
        field(4; "Created By"; Code[20])
        {
            Caption = 'Created By';
        }
        field(6; "ShortCut Dimension 1"; Code[20])
        {
            //Caption = 'ShortCut Dimension 1';
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(7; "ShortCut Dimension 2"; Code[20])
        {

            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(8; "ShortCut Dimension 3"; Code[20])
        {
            Caption = 'ShortCut Dimension 3';
        }
        field(9; "Amount Remaining"; Decimal)
        {

        }
        field(10; "No. Series"; code[20]) { }
        field(11; Status; Option)
        {

            OptionMembers = Pending,"Pending Approval",Approved,Cancelled,Posted;
            Editable = false;
            Description = 'Stores the status of the record in the database';
        }
    }
    keys
    {
        key(PK; "No.", "ShortCut Dimension 1", "ShortCut Dimension 2", "Budget Name")
        {
            Clustered = true;
        }
    }
    var
        FINCashOfficeSetup: Record "Cash Office Setup";
        NoSeriesMgt: Codeunit 396;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            FINCashOfficeSetup.TESTFIELD(FINCashOfficeSetup."Virement Nos");
            NoSeriesMgt.InitSeries(FINCashOfficeSetup."Virement Nos", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        "No. Series" := '';

        "Document Date" := TODAY();
        "Created by" := USERID;
    end;
}
