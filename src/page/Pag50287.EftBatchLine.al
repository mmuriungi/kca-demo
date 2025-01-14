page 50287 "Eft Batch Line"
{
    Caption = 'Eft Batch Line';
    PageType = ListPart;
    SourceTable = "EFT batch Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("PV Number"; Rec."PV Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PV Number field.', Comment = '%';
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payee field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Bank A/C No"; Rec."Bank A/C No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank A/C No field.', Comment = '%';
                }
                field("Bank A/C Name"; Rec."Bank A/C Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank A/C Name field.', Comment = '%';
                }
                field("Bank Branch No"; Rec."Bank Branch No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Branch No field.', Comment = '%';
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Code field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
            }
        }
    }
}
