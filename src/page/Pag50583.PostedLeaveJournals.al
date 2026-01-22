page 50583 "Posted Leave Journals"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HRM-Leave Ledger";
    SourceTableView = where("Transaction Type" = filter(<> Application));

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = all;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the First Name field.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = all;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = all;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = all;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = all;
                }
                field("No. of Days"; Rec."No. of Days")
                {
                    ApplicationArea = all;
                }

                field("Remaining days"; Rec."Remaining days")
                {
                    ApplicationArea = all;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = all;
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    ApplicationArea = all;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    var
        leaveLedger: Record "HRM-Leave Ledger";
        lastNo: Integer;
        EmplName: Text[150];

}

