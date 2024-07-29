table 50069 "Tender Header"
{
    Caption = 'Tender Header';


    fields
    {
        field(1; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(4; "View Online"; Boolean)
        {

        }
        field(11; "Your Reference"; Text[30])
        {
            Caption = 'Your Reference';
        }
        field(19; "Expected Opening Date"; DateTime)
        {
            Caption = 'Expected Opening Date';
            trigger OnValidate()
            begin
                if "Expected Closing Date" > "Expected Opening Date" then
                    error('Closing date can note be later than opening date')
            end;
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(21; "Expected Closing Date"; DateTime)
        {
            Caption = 'Expected Closing Date';

        }
        field(22; "Posting Description"; Text[50])
        {
            Caption = 'Posting Description';
        }
        field(28; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = filter(false));
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }

        field(92; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to County';
        }
        field(93; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(107; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }

        field(120; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,"Pending Approval",Released,Closed,Cancelled,Stopped;
        }

        field(121; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center"."Code";
        }

        field(122; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(123; Cancelled; Boolean)
        {
        }
        field(124; "Cancelled By"; Code[20])
        {
        }
        field(125; "Cancelled Date"; Date)
        {
        }
        field(126; DocApprovalType; Option)
        {
            OptionMembers = Purchase,Requisition,Quote;
        }
        field(127; "Procurement Type Code"; Code[20])
        {
            //TableRelation = "PROC-Procurement Limit Code";
        }
        field(128; "Created By"; Code[20])
        {
        }

    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Check if the number has been inserted by the user
        IF "No." = '' THEN BEGIN
            PurchSetup.RESET;
            PurchSetup.GET();
            PurchSetup.TESTFIELD(PurchSetup."Tender No.");
            NoSeriesMgt.InitSeries(PurchSetup."Tender No.", xRec."No. Series", TODAY, "No.", "No. Series");
        END;
    end;

    trigger OnModify()
    begin
        IF xRec."No." <> "No." THEN BEGIN
            PurchSetup.GET();
            NoSeriesMgt.TestManual(PurchSetup."Tender No.");
        END;
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
