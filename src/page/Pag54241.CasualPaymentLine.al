page 54241 "Casual Payment Line."
{
    PageType = ListPart;
    SourceTable = "Casual Payment Lines.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Bank Account No"; Rec."Bank Account No")
                {
                    ApplicationArea = All;
                }
                field(Occupation; Rec.Occupation)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No of Days"; Rec."No of Days")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Period (Month)"; Rec."Period (Month)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay Rate"; Rec."Pay Rate")
                {
                    ApplicationArea = All;
                }
                field("Rate per Date"; Rec."Rate per Date")
                {
                    Caption = 'Rate Per Day';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Rate per Month"; Rec."Rate per Month")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay Stutatories"; Rec."Pay Stutatories")
                {
                    ApplicationArea = All;
                }
                field("Total Amount To be Payed"; Rec."Basic Amount")
                {
                    ApplicationArea = All;
                }
                field("PAYE Amount"; Rec."PAYE Amount")
                {
                    ApplicationArea = All;
                }
                field("NSSF Amount"; Rec."NSSF Amount")
                {
                    ApplicationArea = All;
                }
                field("NHIF Amount"; Rec."NHIF Amount")
                {
                    ApplicationArea = All;
                }
                field("Net Pay"; Rec."Net Pay")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

