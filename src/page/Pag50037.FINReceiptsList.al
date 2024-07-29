page 50037 "FIN-Receipts List"
{
    CardPageID = "FIN-Receipt Header UP";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "FIN-Receipts Header";
    SourceTableView = WHERE(Posted = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Cashier; Rec.Cashier)
                {
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = All;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                }
                field("Received From"; Rec."Received From")
                {
                    ApplicationArea = All;
                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {
                    ApplicationArea = All;
                }
                field("Amount Recieved"; Rec."Amount Recieved")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {

                }
                field("Posted By"; Rec."Posted By")
                {
                }
                field("Print No."; Rec."Print No.")
                {
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = All;
                }
                field("No. Printed"; Rec."No. Printed")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Created Date Time"; Rec."Created Date Time")
                {
                }
                field("Register No."; Rec."Register No.")
                {
                }
                field("From Entry No."; Rec."From Entry No.")
                {
                }
                field("To Entry No."; Rec."To Entry No.")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                }
                field(Dim3; Rec.Dim3)
                {
                }
                field(Dim4; Rec.Dim4)
                {
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                }
                field("Patient Appointment No"; Rec."Patient Appointment No")
                {
                }
                field("Surrender No"; Rec."Surrender No")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Posted Receipt Card")
            {
                RunObject = Page "FIN-Posted Receipt UP";
                RunPageLink = "No." = FIELD("No.");
            }
        }
        area(reporting)
        {

        }
    }
}