page 52178620 "Proc Consolidation Lines"
{
    Caption = 'Proc Consolidation Lines';
    PageType = ListPart;
    SourceTable = "Proc Consolidated Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Votebook Account"; Rec."Votebook Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Votebook Account field.';
                }
                field("1st Quater"; Rec."1st Quater")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the 1st Quater field.';
                }
                field("2nd Quater"; Rec."2nd Quater")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the 2nd Quater field.';
                }
                field("3rd Quater"; Rec."3rd Quater")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the 3rd Quater field.';
                }
                field("4th Quater"; Rec."4th Quater")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the 4th Quater field.';
                }
                field("Unit Of Measure"; Rec."Unit Of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Of Measure field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Cost field.';
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
        }
    }
}
