page 50365 "HRM-Other Payees"
{
    CardPageID = "HRM-Payee Card";
    DataCaptionFields = "No.", "First Name", "Middle Name", "Last Name";
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "HRM-Other Payees";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Last Name"; Rec."Last Name")
                {
                }
                field("PIN Number"; Rec."PIN Number")
                {
                }
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field("Main Bank"; Rec."Main Bank")
                {
                }
                field("Branch Bank"; Rec."Branch Bank")
                {
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Update Payee Memo")
            {
                Image = Users;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    Customer: Record 18;
                    HRMOtherPayees: Record "HRM-Other Payees";
                begin
                    /*
                    Customer.RESET;
                    Customer.SETRANGE("No.", HRMOtherPayees."No.");
                    
                    
                    IF NOT Customer.FIND
                     THEN BEGIN
                     REPEAT
                       Customer.INIT;
                       Customer."No." := HRMOtherPayees."No.";
                       Customer.Name := HRMOtherPayees.Names;
                       Customer."Customer Posting Group" := 'PAYEE';
                       Customer."Phone No.":=  HRMOtherPayees."Cellular Phone Number";
                       Customer."Gen. Bus. Posting Group" := 'LOCAL';
                       Customer."E-Mail" := HRMOtherPayees."E-Mail";
                       VALIDATE("No.");
                       Customer.INSERT;
                       //MESSAGE('update ' + "No.");
                       UNTIL  HRMOtherPayees.NEXT = 0;
                       END;
                    
                    */

                end;
            }
        }
    }
}

