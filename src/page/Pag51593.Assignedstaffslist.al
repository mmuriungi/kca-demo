page 51593 "Assigned staffs list"
{
    Caption = 'Assigned staffs list';
    PageType = ListPart;
    SourceTable = "Assigned staffs";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Consultant Type"; Rec."Consultant Type")
                {
                    ApplicationArea = All;
                    Caption = 'Consultant Type';
                }
                field("Staff Number"; Rec."Staff Number")
                {
                    ApplicationArea = All;
                    Caption = 'Consultant Number';
                    ToolTip = 'Specifies the value of the Staff Number field.', Comment = '%';
                }
                field("staff name"; Rec."staff name")
                {
                    ApplicationArea = All;
                    Caption = 'Consultant Name';
                    ToolTip = 'Specifies the value of the staff name field.', Comment = '%';
                }
                field("staff email"; Rec."staff email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the staff email field.', Comment = '%';
                }
                field("phone Number"; Rec."phone Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the phone Number field.', Comment = '%';
                }
                field(comment; Rec.comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the comment field.', Comment = '%';
                }
            }
        }
    }
}
