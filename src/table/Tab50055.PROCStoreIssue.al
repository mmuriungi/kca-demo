table 50055 "PROC-Store Issue"
{
    /* DrillDownPageID = 68005;
    LookupPageID = 68005;
 */
    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Date; Date)
        {
            NotBlank = true;
        }
        field(3; "Date Issued"; Date)
        {
            NotBlank = true;
        }
        field(4; "Issued By"; Text[50])
        {
            NotBlank = true;
        }
        field(5; "Received By"; Text[50])
        {
            NotBlank = true;
        }
        field(6; Remarks; Text[50])
        {
        }
        field(7; "Entered By"; Code[20])
        {
            NotBlank = true;
        }
        field(8; Status; Option)
        {
            OptionMembers = New,Posted;
        }
        field(9; Location; Code[10])
        {
            TableRelation = Location.Code;
        }
        field(10; "Plan No"; Code[10])
        {
            // TableRelation = "PROC-Internal Requisition Plan";
        }
        field(11; "Gen. Prod Posting"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(12; Posted; Boolean)
        {
        }
        field(13; Department; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
        }
        field(14; "Issue Type"; Option)
        {
            OptionMembers = Issue,Transfer;
        }
        field(15; "Transfer to Location"; Code[10])
        {
            TableRelation = Location.Code;
        }
        field(16; "Transfer Transit"; Code[10])
        {
            TableRelation = Location.Code WHERE("Use As In-Transit" = CONST(true));
        }
        field(17; "Transfer Remarks"; Text[30])
        {
        }
        field(18; "Request No"; Code[10])
        {
        }
        field(19; "Vote Book"; Code[20])
        {
            TableRelation = "G/L Account"."No." WHERE("Budget Controlled" = CONST(true));
        }
        field(20; "Vote Balance"; Decimal)
        {
        }
        field(21; Committed; Boolean)
        {
        }
        field(22; "Committed By"; Code[20])
        {
        }
        field(23; "Committed On"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PurchSetup: Record 312;
        NoSeriesMgt: Codeunit 396;
}

