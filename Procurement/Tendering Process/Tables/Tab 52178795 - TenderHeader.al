table 52178795 "Tender Header"
{
    Caption = 'Tender Header';


    fields
    {
        field(1; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "View Online"; Boolean)
        {

        }
        field(4; "Your Reference"; Text[30])
        {
            Caption = 'Your Reference';
        }
        field(5; "Expected Opening Date"; Date)
        {
            Caption = 'Expected Opening Date';
            trigger OnValidate()
            begin
                if "Expected Closing Date" > "Expected Opening Date" then
                    error('Closing date can note be later than opening date')
            end;
        }
        field(6; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(7; "Expected Closing Date"; Date)
        {
            Caption = 'Expected Closing Date';

        }
        field(8; "Posting Description"; Text[50])
        {
            Caption = 'Posting Description';
        }
        field(9; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = filter(false));
        }
        field(10; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(11; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }

        field(12; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to County';
        }
        field(13; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(14; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }

        field(15; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Released,Closed,Cancelled,Stopped,Rejected';
            OptionMembers = Open,"Pending Approval",Released,Closed,Cancelled,Stopped,Rejected;
        }

        field(16; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center"."Code";
        }

        field(17; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(18; Cancelled; Boolean)
        {
        }
        field(19; "Cancelled By"; Code[20])
        {
        }
        field(20; "Cancelled Date"; Date)
        {
        }
        field(21; DocApprovalType; Option)
        {
            OptionMembers = Purchase,Requisition,Quote;
        }
        field(22; "Procurement Type Code"; Code[20])
        {
            //TableRelation = "PROC-Procurement Limit Code";
        }
        field(23; "Created By"; Code[20])
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
            /*  PurchSetup.RESET;
             PurchSetup.GET();
             PurchSetup.TESTFIELD(PurchSetup."Quotation Request No");
             NoSeriesMgt.InitSeries(PurchSetup."Quotation Request No", xRec."No. Series", TODAY, "No.", "No. Series"); */
            tenderNoseries.Get();
            tenderNoseries.TestField("Tender No.");
            NoSeriesMgt.InitSeries(tenderNoseries."Tender No.", xRec."No. Series", TODAY, "No.", "No. Series");
        END;
    end;

    trigger OnModify()
    begin
        IF xRec."No." <> "No." THEN BEGIN
            tenderNoseries.GET();
            NoSeriesMgt.TestManual(tenderNoseries."Tender No.");
        END;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        tenderNoseries: Record "Tender Series Setup";
}
