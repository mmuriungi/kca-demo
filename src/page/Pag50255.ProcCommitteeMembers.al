page 50255 "Proc-Committee Members"
{
    Caption = 'Committee Members';
    PageType = ListPart;
    SourceTable = "Proc-Committee Members";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Committee; Rec.Committee)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Committee field.';
                }
                field("Member Type"; Rec."Member Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Type field.';
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Role; Rec.Role)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Role field.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No field.';
                }
            }
        }
    }
}
